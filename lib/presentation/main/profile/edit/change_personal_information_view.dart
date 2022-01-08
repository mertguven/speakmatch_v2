import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:speakmatch_v2/core/utilities/custom_snackbar.dart';
import 'package:speakmatch_v2/cubit/profile/profile_cubit.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/presentation/main/page_router_view.dart';

enum GenderList { male, female, none }

class ChangePersonalInformationView extends StatefulWidget {
  final UserResponseModel userResponseModel;
  const ChangePersonalInformationView({Key key, this.userResponseModel})
      : super(key: key);

  @override
  _ChangePersonalInformationViewState createState() =>
      _ChangePersonalInformationViewState();
}

class _ChangePersonalInformationViewState
    extends State<ChangePersonalInformationView> {
  TextEditingController _textEditingController;
  Rx<GenderList> genderList;

  @override
  void initState() {
    super.initState();
    _textEditingController =
        TextEditingController(text: widget.userResponseModel.displayName);
    genderList = widget.userResponseModel.gender == "male"
        ? GenderList.male.obs
        : widget.userResponseModel.gender == "female"
            ? GenderList.female.obs
            : GenderList.none.obs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "changePersonalInformation".tr,
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: bloc.BlocListener<ProfileCubit, ProfileState>(
              listener: (context, state) async {
                if (state is ProfileLoadingState) {
                  await EasyLoading.show(status: "loading".tr);
                } else {
                  EasyLoading.dismiss().whenComplete(() {
                    if (state is SuccessChangePersonalInformationState) {
                      Get.offAll(() => PageRouterView(pageToShow: 2),
                          transition: Transition.leftToRight);
                      customSnackbar(true, "changesSaved".tr);
                    } else if (state is ProfileErrorState) {
                      customSnackbar(false, state.errorMessage);
                    }
                  });
                }
              },
              child: IconButton(
                  onPressed: () => saveData(),
                  icon: Icon(
                    FontAwesomeIcons.check,
                    color: Colors.black,
                  )),
            ),
          )
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          TextFormField(
              decoration: InputDecoration(labelText: "name".tr),
              controller: _textEditingController),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => RadioListTile(
                    title: Text("male".tr),
                    activeColor: Theme.of(context).colorScheme.primary,
                    groupValue: genderList.value,
                    value: GenderList.male,
                    onChanged: (value) {
                      genderList.value = value;
                    },
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => RadioListTile(
                    title: Text("female".tr),
                    activeColor: Theme.of(context).colorScheme.primary,
                    groupValue: genderList.value,
                    value: GenderList.female,
                    onChanged: (value) {
                      genderList.value = value;
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void saveData() async {
    if (_textEditingController.text.isNotEmpty) {
      try {
        context.read<ProfileCubit>().changeUserInformation(UserResponseModel(
            uid: widget.userResponseModel.uid,
            isVip: widget.userResponseModel.isVip,
            creationTime: widget.userResponseModel.creationTime,
            displayName: _textEditingController.text.trim(),
            email: widget.userResponseModel.email,
            emailVerified: widget.userResponseModel.emailVerified,
            imageUrl: widget.userResponseModel.imageUrl,
            gender: genderList.value == GenderList.male
                ? "male"
                : genderList.value == GenderList.female
                    ? "female"
                    : null,
            lastSignInTime: widget.userResponseModel.lastSignInTime));
      } catch (e) {}
    } else {
      customSnackbar(false, "nameFieldMustBeFilled".tr);
    }
  }
}
