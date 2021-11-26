import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum GenderList { male, female, none }

class RadioButtons extends StatelessWidget {
  final Rx<GenderList> genderList;
  const RadioButtons({Key key, this.genderList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Obx(
            () => RadioListTile(
              title: Text("Male"),
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
              title: Text("Female"),
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
    );
  }
}
