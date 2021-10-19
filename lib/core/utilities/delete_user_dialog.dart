import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakmatch_v2/cubit/profile/profile_cubit.dart';

void deleteUserDialog(ProfileCubit read) {
  final String _title = "Delete User";
  final String _cancelText = "Cancel";
  final String _deleteText = "Delete";
  final String _contentText = "Are you sure want to delete your account?";
  final String _noteText =
      "Please, rethink your decision because you will not be able to undo this action!";
  final List<ElevatedButton> buttons = List.generate(
      2,
      (index) => ElevatedButton(
            onPressed: () async {
              Get.back();
              if (index == 1) {
                read.deleteUser();
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            _noteText,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ),
      ],
    ),
  );
}
