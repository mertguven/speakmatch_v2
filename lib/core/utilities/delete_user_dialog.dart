import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:speakmatch_v2/core/utilities/custom_snackbar.dart';
import 'package:speakmatch_v2/cubit/profile/profile_cubit.dart';
import 'package:speakmatch_v2/data/model/profile/request/delete_user_request_model.dart';
import 'package:speakmatch_v2/shared-prefs.dart';

void deleteUserDialog(ProfileCubit read) {
  final String _title = "Delete User";
  final String _cancelText = "Cancel";
  final String _deleteText = "Delete";
  final String _contentText = "Are you sure want to delete your account?";
  final String _noteText =
      "Please, rethink your decision because you will not be able to undo this action!";
  TextEditingController _textEditingController = TextEditingController();
  final validate = false.obs;
  final List<ElevatedButton> buttons = List.generate(
      2,
      (index) => ElevatedButton(
            onPressed: () async {
              if (index == 0) {
                Get.back();
              } else if (index == 1) {
                if (SharedPrefs.getidToken == null &&
                    _textEditingController.text != null) {
                  await read.deleteUser(DeleteUserRequestModel(
                      password: _textEditingController.text.trim()));
                } else if (SharedPrefs.getidToken != null) {
                  await read.deleteUser();
                } else {
                  validate.value = true;
                }
              }
            },
            child: Text(index == 0 ? _cancelText : _deleteText),
            style: ElevatedButton.styleFrom(
                primary: index == 0 ? Colors.grey.shade400 : Color(0xffD64565),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
          ));
  Get.defaultDialog(
    titlePadding: const EdgeInsets.symmetric(vertical: 10),
    title: _title,
    titleStyle: TextStyle(fontWeight: FontWeight.bold),
    cancel: buttons.first,
    confirm: buttons.last,
    content: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(_contentText, textAlign: TextAlign.center),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Text(
            _noteText,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ),
        SharedPrefs.getidToken == null
            ? BlocListener<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is ProfileErrorState) {
                    customSnackbar(false, state.errorMessage);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Obx(
                    () => TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                          labelText: "Password",
                          errorText:
                              validate.value ? "password is required" : null,
                          contentPadding: const EdgeInsets.all(8),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
              )
            : SizedBox()
      ],
    ),
  );
}
