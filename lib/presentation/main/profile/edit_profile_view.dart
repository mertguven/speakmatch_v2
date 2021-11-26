import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/presentation/main/profile/edit/change_email_view.dart';
import 'package:speakmatch_v2/presentation/main/profile/edit/change_password_view.dart';
import 'package:speakmatch_v2/presentation/main/profile/edit/change_personal_information_view.dart';

class EditProfileView extends StatelessWidget {
  final UserResponseModel userResponseModel;
  const EditProfileView(this.userResponseModel, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Edit Profile",
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
      body: ListView.separated(
        itemCount: 3,
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(height: 10);
        },
        itemBuilder: (context, index) => ListTile(
          leading: Icon(
              index == 0
                  ? FontAwesomeIcons.solidUser
                  : index == 1
                      ? FontAwesomeIcons.lock
                      : FontAwesomeIcons.solidPaperPlane,
              color: Colors.black),
          title: Text(
            index == 0
                ? "Change Personal Information"
                : index == 1
                    ? "Change Password"
                    : "Change Email",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Icon(FontAwesomeIcons.chevronRight, color: Colors.black),
          onTap: () {
            if (index == 0) {
              Get.to(
                  () => ChangePersonalInformationView(
                      userResponseModel: userResponseModel),
                  transition: Transition.cupertino);
            } else if (index == 1) {
              Get.to(() => ChangePasswordView(),
                  transition: Transition.cupertino);
            } else {
              Get.to(() => ChangeEmailView(), transition: Transition.cupertino);
            }
          },
        ),
      ),
    );
  }
}
