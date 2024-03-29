import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:speakmatch_v2/core/constants/app_constant.dart';
import 'package:speakmatch_v2/core/helper/url_launcher_helper.dart';
import 'package:speakmatch_v2/core/utilities/custom_snackbar.dart';
import 'package:speakmatch_v2/core/utilities/delete_user_dialog.dart';
import 'package:speakmatch_v2/cubit/profile/profile_cubit.dart';
import 'package:speakmatch_v2/presentation/authentication/authentication_view.dart';
import 'package:speakmatch_v2/presentation/main/profile/settings/change_language_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "settings".tr,
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            listItems("language".tr, "changeLanguage".tr),
            listItems("contactUs".tr, "helpAndSupport".tr),
            listItems("legal".tr, "privacyPolicy".tr),
            listItems("share".tr, "inviteYourFriends".tr),
            bloc.BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is ProfileLoadingState) {
                  EasyLoading.show(status: "loading".tr);
                } else {
                  EasyLoading.dismiss();
                  if (state is SuccessSignOutState) {
                    Get.offAll(() => AuthenticationView(),
                        duration: Duration(seconds: 1),
                        transition: Transition.cupertino);
                  } else if (state is ProfileErrorState) {
                    customSnackbar(false, state.errorMessage);
                  }
                }
              },
              builder: (context, state) {
                return signoutAndDeleteButton("signOut".tr);
              },
            ),
            imageAndVersionWidget(),
            signoutAndDeleteButton("deleteAccount".tr),
          ],
        ),
      ),
    );
  }

  Widget listItems(String title, String buttonTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(blurRadius: 1, color: Colors.grey.shade400),
              ],
            ),
            child: ListTile(
              onTap: () {
                if (title == "language".tr) {
                  Get.to(() => ChangeLanguageView(),
                      transition: Transition.cupertino);
                } else if (title == "contactUs".tr) {
                  UrlLauncherHelper().emailSender();
                } else if (title == "legal".tr) {
                  UrlLauncherHelper().launcher(AppConstant.privacyPolicyUrl);
                } else {
                  Share.share(
                      "${AppConstant.shareTextContent} ${AppConstant.googlePlayUrl}");
                }
              },
              title: Text(buttonTitle),
            ),
          )
        ],
      ),
    );
  }

  Widget imageAndVersionWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          FractionallySizedBox(
            widthFactor: 0.2,
            child: Image.asset("assets/images/settings_logo.png"),
          ),
          Text(
            "version".tr,
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }

  Container signoutAndDeleteButton(String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      child: ElevatedButton.icon(
          onPressed: () {
            if (title == "signOut".tr) {
              signOut();
            } else {
              deleteUserDialog(context.read<ProfileCubit>());
            }
          },
          style: ElevatedButton.styleFrom(
              primary: title == "signOut".tr
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 15)),
          icon: Icon(
              title == "signOut".tr
                  ? FontAwesomeIcons.signOutAlt
                  : FontAwesomeIcons.trash,
              color: title == "signOut".tr
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).colorScheme.secondary),
          label: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: title == "signOut".tr
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).colorScheme.secondary),
          )),
    );
  }

  void signOut() async {
    context.read<ProfileCubit>().signOut();
  }
}
