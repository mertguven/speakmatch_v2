import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:speakmatch_v2/core/utilities/custom_snackbar.dart';
import 'package:speakmatch_v2/cubit/profile/profile_cubit.dart';
import 'package:speakmatch_v2/data/model/profile/request/update_password_request_model.dart';
import 'package:speakmatch_v2/presentation/authentication/authentication_view.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key key}) : super(key: key);

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _textEditingController = <TextEditingController>[];
  final _focusNode = <FocusNode>[];

  @override
  void initState() {
    for (var i = 0; i < 3; i++) {
      _textEditingController.add(TextEditingController());
      _focusNode.add(FocusNode());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Change Password",
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
              listener: (context, state) {
                if (state is ProfileLoadingState) {
                  EasyLoading.show(status: "Loading...");
                } else {
                  EasyLoading.dismiss();
                  if (state is SuccessSignOutState) {
                    Get.offAll(() => AuthenticationView(),
                        transition: Transition.cupertino);
                    customSnackbar(true, "Password has been changed.");
                  } else if (state is ProfileErrorState) {
                    customSnackbar(false, state.errorMessage);
                  }
                }
              },
              child: IconButton(
                  onPressed: () => changeData(),
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
              decoration: InputDecoration(labelText: "Current Password"),
              focusNode: _focusNode[0],
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (term) {
                _focusNode[0].unfocus();
                FocusScope.of(context).requestFocus(_focusNode[1]);
              },
              controller: _textEditingController[0]),
          SizedBox(height: 20),
          TextFormField(
              decoration: InputDecoration(labelText: "New Password"),
              focusNode: _focusNode[1],
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (term) {
                _focusNode[1].unfocus();
                FocusScope.of(context).requestFocus(_focusNode[2]);
              },
              controller: _textEditingController[1]),
          SizedBox(height: 20),
          TextFormField(
              decoration: InputDecoration(labelText: "Re-NewPassword"),
              focusNode: _focusNode[2],
              onFieldSubmitted: (term) {
                _focusNode[2].unfocus();
              },
              controller: _textEditingController[2]),
        ],
      ),
    );
  }

  void changeData() async {
    if (_textEditingController[0].text.isNotEmpty &&
        _textEditingController[1].text.isNotEmpty &&
        _textEditingController[2].text.isNotEmpty) {
      if (_textEditingController[0].text == _textEditingController[1].text) {
        customSnackbar(
            false, "Old password and new password cannot be the same");
      } else if (_textEditingController[1].text ==
          _textEditingController[2].text) {
        context.read<ProfileCubit>().changePassword(UpdatePasswordRequestModel(
            oldPassword: _textEditingController[0].text.trim(),
            newPassword: _textEditingController[1].text.trim()));
      } else {
        customSnackbar(false, "Passwords must be the same");
      }
    } else {
      customSnackbar(false, "All field must be filled.");
    }
  }
}
