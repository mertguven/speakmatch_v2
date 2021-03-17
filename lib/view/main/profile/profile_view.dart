import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:speakmatch_v2/controller/home/home_controller.dart';
import 'package:speakmatch_v2/controller/profile/profile_controller.dart';
import 'package:speakmatch_v2/model/home/request/UserStatusChangeRequestMessage.dart';
import 'package:speakmatch_v2/model/profile/response/GetUserInformationResponseMessage.dart';
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
  NetworkImage networkImageProvider;
  int counter = 0;

  Future getImage(String cameraOrGallery) async {
    PickedFile pickedFile;
    if (cameraOrGallery == "camera") {
      pickedFile = await picker.getImage(
          source: ImageSource.camera, maxHeight: 3264, maxWidth: 1836);
      _image = File(pickedFile.path);
      _upload(_image);
    } else {
      pickedFile = await picker.getImage(
          source: ImageSource.gallery, maxHeight: 3264, maxWidth: 1836);
      _image = File(pickedFile.path);
      _upload(_image);
    }
    Navigator.pop(context);
  }

  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'guhadestek@gmail.com',
      queryParameters: {'subject': '...'});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetUserInformationResponseMessage>(
      future: getUserInformation(),
      builder: (context, result) {
        if (result.hasData) {
          networkImageProvider =
              NetworkImage(result.data.url + "?value=$counter");
          return Scaffold(
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
                              "Kullanıcı Bilgileri",
                              Icon(FontAwesomeIcons.userAlt,
                                  color: Colors.black)),
                          getDrawerList(
                              "Şifre Değiştir",
                              Icon(FontAwesomeIcons.unlock,
                                  color: Colors.black)),
                          getDrawerList(
                              "Arkadaşlarını Davet Et",
                              Icon(FontAwesomeIcons.userFriends,
                                  color: Colors.black)),
                          getDrawerList("İletişim",
                              Icon(FontAwesomeIcons.at, color: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                  ListTile(
                    onTap: () => signOut(),
                    title: Text(
                      "Çıkış Yap",
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
              title: Text("Profil"),
              centerTitle: true,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          blurRadius: 20,
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 8),
                          spreadRadius: 0.8),
                    ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                                  image: _image,
                                                  url: result.data.url,
                                                ))),
                                    child: Hero(
                                      tag: "photo",
                                      child: CircleAvatar(
                                        maxRadius: 70,
                                        backgroundColor: Colors.grey.shade300,
                                        backgroundImage: networkImageProvider,
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).accentColor,
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
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              stats("109", "Follow"),
                              stats("2062", "Follow"),
                              stats("89", "Follow"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.001),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Beğeniler",
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
                                padding: EdgeInsets.symmetric(horizontal: 10),
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
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  ListTile getDrawerList(String text, Icon icon) {
    return ListTile(
      onTap: () {
        switch (text) {
          case "Kullanıcı Bilgileri":
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => ChangeUserInformationView()));
            break;
          case "Şifre Değiştir":
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => ChangePasswordView()));
            break;
          case "Arkadaşlarını Davet Et":
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => InviteFriendsView()));
            break;
          case "İletişim":
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
    final profileController =
        Provider.of<ProfileController>(context, listen: false);
    return await profileController.getUserInformation();
  }

  void signOut() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Çıkış Yap"),
            content: Text("Çıkmak istediğinden emin misin?"),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: () => logOutEvent(),
                child: Text("Evet"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Hayır",
                  style: TextStyle(color: Colors.white),
                ),
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
                title: Text("Kamera"),
                onTap: () => getImage("camera"),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.image),
                title: Text("Galeri"),
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
            title: Text("İletişim"),
            content: Text("guhadestek@gmail.com"),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                ),
                onPressed: () => launch(_emailLaunchUri.toString()),
                child: Text("Bize ulaş"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Kapat",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  void _upload(File file) async {
    final profileController =
        Provider.of<ProfileController>(context, listen: false);
    var response = await profileController.changeProfilePhoto(file);
    if (response.success) {
      setState(() {
        networkImageProvider.evict();
        counter++;
      });
    }
  }

  logOutEvent() async {
    var homeController = Provider.of<HomeController>(context, listen: false);
    UserStatusChangeRequestMessage request =
        UserStatusChangeRequestMessage(status: "Offline");
    await homeController.changeUserStatus(request);
    SharedPrefs.sharedClear();
    Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (context) => LoginAndRegisterView()),
        (_) => false);
  }
}
