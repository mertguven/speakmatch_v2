import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speakmatch_v2/cubit/profile/profile_cubit.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/presentation/main/page_router_view.dart';
import 'package:speakmatch_v2/presentation/main/profile/components/profile_view_loading_animation_widget.dart';
import 'package:speakmatch_v2/presentation/main/profile/edit_profile_view.dart';
import 'package:speakmatch_v2/presentation/main/profile/settings_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  UserResponseModel userResponseModel;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  void getUserData() async {
    userResponseModel = await context.read<ProfileCubit>().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.only(top: 40),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.grey.withOpacity(0.15),
                    ),
                  ],
                  borderRadius: BorderRadius.vertical(
                    bottom:
                        Radius.elliptical(context.width, context.height * 0.15),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: bloc.BlocConsumer<ProfileCubit, ProfileState>(
                        listener: (contex, state) {
                          if (state is ProfileLoadedState) {
                            userResponseModel = state.model;
                          }
                        },
                        builder: (context, state) {
                          if (state is ProfileLoadedState) {
                            return Column(
                              children: [
                                CircleAvatar(
                                  maxRadius: 70,
                                  backgroundColor: Colors.grey.shade300,
                                  backgroundImage:
                                      NetworkImage(state.model.imageUrl),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          state.model.displayName,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        state.model.email,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return ProfileViewLoadingAnimationWidget();
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Spacer(),
                              editingButtons(0),
                              Spacer(flex: 4),
                              editingButtons(2),
                              Spacer(),
                            ],
                          ),
                          editingButtons(1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  FontAwesomeIcons.solidGem,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Text(
                                "speakmatchVip".tr,
                                style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            child: Text(
                              "youveToGetVipToBlockAds".tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: context.width * 0.6,
                        child: ElevatedButton(
                          onPressed: () => Get.offAll(
                              () => PageRouterView(pageToShow: 0),
                              transition: Transition.leftToRightWithFade),
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: StadiumBorder(),
                              primary: Theme.of(context).colorScheme.secondary),
                          child: Text(
                            "getSpeakmatchVip".tr,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget editingButtons(int index) {
    return InkWell(
      onTap: () {
        if (index == 0) {
          Get.to(() => EditProfileView(userResponseModel),
              transition: Transition.cupertino);
        } else if (index == 2) {
          Get.to(() => SettingsView(), transition: Transition.cupertino);
        } else {
          imagePickerFunction().then((value) {
            if (value != null) {
              return context.read<ProfileCubit>().uploadPhoto(value);
            }
          });
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Icon(
              index == 0
                  ? FontAwesomeIcons.pen
                  : index == 1
                      ? FontAwesomeIcons.camera
                      : FontAwesomeIcons.cog,
              color: index == 1
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.grey,
            ),
          ),
          Text(
            index == 0
                ? "editProfile".tr
                : index == 1
                    ? "changePhoto".tr
                    : "settings".tr,
            style: TextStyle(
              color: index == 1
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Future<Uint8List> imagePickerFunction() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      return await file.readAsBytes();
    } else {
      return null;
    }
  }
}
