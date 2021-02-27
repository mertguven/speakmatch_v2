import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speakmatch_v2/controller/profile/profile_controller.dart';
import 'package:speakmatch_v2/locator.dart';
import 'package:speakmatch_v2/model/profile/GetUserInformationResponseMessage.dart';
import 'package:speakmatch_v2/shared-prefs.dart';
import 'package:speakmatch_v2/view/main/profile/big_profile_picture.dart';
import 'package:speakmatch_v2/view/main/profile/drawer_list/change_password.dart';
import 'package:speakmatch_v2/view/main/profile/drawer_list/change_user_information.dart';
import 'package:speakmatch_v2/view/main/profile/drawer_list/invite_friends.dart';
import 'package:speakmatch_v2/view/signin_signup/login_and_register_view.dart';
import 'package:speakmatch_v2/core/extension/device_screen_size.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File _image;
  final picker = ImagePicker();

  Future getImage(String cameraOrGallery) async {
    final pickedFile = await picker.getImage(
        source: cameraOrGallery == "camera"
            ? ImageSource.camera
            : ImageSource.gallery,
        preferredCameraDevice: CameraDevice.front);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
      Navigator.pop(context);
    });
  }

  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'guhadestek@gmail.com',
      queryParameters: {'subject': 'Subject'});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetUserInformationResponseMessage>(
      future: getUserInformation(),
      builder: (context, result) {
        return result.hasData
            ? Scaffold(
                endDrawer: Drawer(
                  elevation: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          drawerHeader(context, result),
                          ListView(
                            shrinkWrap: true,
                            children: [
                              getDrawerList(
                                  "User Information",
                                  Icon(FontAwesomeIcons.user,
                                      color: Colors.black)),
                              getDrawerList(
                                  "Password",
                                  Icon(FontAwesomeIcons.unlock,
                                      color: Colors.black)),
                              getDrawerList(
                                  "Invite Friends",
                                  Icon(FontAwesomeIcons.userFriends,
                                      color: Colors.black)),
                              getDrawerList(
                                  "Contact",
                                  Icon(FontAwesomeIcons.at,
                                      color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                      ListTile(
                        onTap: () => signOut(),
                        title: Text(
                          "Log Out",
                          style: TextStyle(color: Color(0xffD64565)),
                        ),
                        leading: Icon(FontAwesomeIcons.signOutAlt,
                            color: Color(0xffD64565)),
                      ),
                    ],
                  ),
                ),
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Text("Profile"),
                  centerTitle: true,
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 8),
                              spreadRadius: 0.5),
                        ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 80,
                                        backgroundColor: Colors.grey.shade200,
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BigProfilePicture(
                                                        image: _image))),
                                        child: Hero(
                                          tag: "photo",
                                          child: CircleAvatar(
                                            maxRadius: 70,
                                            backgroundColor:
                                                Colors.grey.shade300,
                                            backgroundImage: _image == null
                                                ? AssetImage(
                                                    "assets/images/user.png")
                                                : Image.file(_image).image,
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: IconButton(
                                                    highlightColor:
                                                        Colors.transparent,
                                                    iconSize: 20,
                                                    icon: Icon(
                                                      FontAwesomeIcons.camera,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () =>
                                                        bottomSheet(context),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    result.data.username,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                stats("109", "Follow"),
                                stats("2062", "Follow"),
                                stats("89", "Follow"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        //margin: EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.02),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Likes",
                                style: TextStyle(
                                    color: Color(0xffD64565),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 10,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          "https://picsum.photos/300/300?random=$index"),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  ListTile getDrawerList(String text, Icon icon) {
    return ListTile(
      onTap: () {
        switch (text) {
          case "User Information":
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => ChangeUserInformationView()));
            break;
          case "Password":
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => ChangePasswordView()));
            break;
          case "Invite Friends":
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => InviteFriendsView()));
            break;
          case "Contact":
            showContact();
            break;
        }
      },
      title: Text(text),
      leading: icon,
    );
  }

  Container drawerHeader(BuildContext context,
      AsyncSnapshot<GetUserInformationResponseMessage> result) {
    return Container(
      height: context.deviceHeight() * 0.1,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3))),
      child: Center(
          child: Text(result.data.username,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600))),
    );
  }

  Column stats(String title, String message) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: title == "2062" ? 18 : 16)),
        Text(message,
            style: TextStyle(
                fontSize: title == "2062" ? 18 : 16, color: Colors.grey)),
      ],
    );
  }

  Future<GetUserInformationResponseMessage> getUserInformation() async {
    ProfileController profileController = locator<ProfileController>();
    return await profileController.getUserInformation();
  }

  void signOut() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Log Out"),
            content: Text("Are you sure you want to quit?"),
            actions: [
              RaisedButton(
                onPressed: () {
                  SharedPrefs.sharedClear();
                  Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => LoginAndRegisterView()),
                      (_) => false);
                },
                child: Text("Yes"),
                color: Colors.red,
              ),
              RaisedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "No",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.grey,
              ),
            ],
          );
        });
  }

  bottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(FontAwesomeIcons.camera),
                title: Text("Camera"),
                onTap: () => getImage("camera"),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.image),
                title: Text("Gallery"),
                onTap: () => getImage("gallery"),
              ),
            ],
          ),
        );
      },
    );
  }

  void showContact() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Contact"),
            content: Text("guhadestek@gmail.com"),
            actions: [
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 15),
                onPressed: () => launch(_emailLaunchUri.toString()),
                child: Text("Contact Us"),
                color: Colors.red,
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 15),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Close",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.grey,
              ),
            ],
          );
        });
  }
}
