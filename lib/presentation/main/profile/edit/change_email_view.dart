import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:speakmatch_v2/core/utilities/custom_snackbar.dart';
import 'package:speakmatch_v2/cubit/profile/profile_cubit.dart';
import 'package:speakmatch_v2/data/model/profile/request/update_email_request_model.dart';
import 'package:speakmatch_v2/presentation/authentication/authentication_view.dart';

class ChangeEmailView extends StatefulWidget {
  const ChangeEmailView({Key key}) : super(key: key);

  @override
  _ChangeEmailViewState createState() => _ChangeEmailViewState();
}

class _ChangeEmailViewState extends State<ChangeEmailView> {
  final _textEditingController = <TextEditingController>[];
  final _focusNode = <FocusNode>[];

  @override
  void initState() {
    for (var i = 0; i < 2; i++) {
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
          "changeEmail".tr,
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
                  EasyLoading.show(status: "loading".tr);
                } else {
                  EasyLoading.dismiss();
                  if (state is SuccessSignOutState) {
                    Get.offAll(() => AuthenticationView(),
                        transition: Transition.cupertino);
                    customSnackbar(true, "emailHasBeenChanged".tr);
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
            decoration: InputDecoration(labelText: "currentPassword".tr),
            focusNode: _focusNode[0],
            textInputAction: TextInputAction.next,
            controller: _textEditingController[0],
            onFieldSubmitted: (term) {
              _focusNode[0].unfocus();
              FocusScope.of(context).requestFocus(_focusNode[1]);
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(labelText: "newEmail".tr),
            keyboardType: TextInputType.emailAddress,
            focusNode: _focusNode[1],
            controller: _textEditingController[1],
          ),
        ],
      ),
    );
  }

  void changeData() async {
    if (_textEditingController[0].text.isNotEmpty &&
        _textEditingController[1].text.isNotEmpty) {
      context.read<ProfileCubit>().changeEmail(UpdateEmailRequestModel(
            password: _textEditingController[0].text.trim(),
            email: _textEditingController[1].text.trim(),
          ));
    } else {
      customSnackbar(false, "emailFieldMustBeFilled".tr);
    }
  }
}
