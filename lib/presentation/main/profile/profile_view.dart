import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:speakmatch_v2/presentation/main/profile/edit_profile_view.dart';
import 'package:speakmatch_v2/presentation/main/profile/settings_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
                      child: Column(
                        children: [
                          CircleAvatar(
                            maxRadius: 70,
                            backgroundImage: NetworkImage(
                                "https://randomuser.me/api/portraits/women/65.jpg"),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    "Mert Güven",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  "mertguven789@gmail.com",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                                "Speakmatch VIP",
                                style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "You've to get VIP to block ads!",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: context.width * 0.6,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: StadiumBorder(),
                              primary: Theme.of(context).colorScheme.secondary),
                          child: Text(
                            "Get Speakmatch VIP",
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
          Get.to(() => EditProfileView(), transition: Transition.cupertino);
        } else if (index == 2) {
          Get.to(() => SettingsView(), transition: Transition.cupertino);
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
                ? "Edit Profile"
                : index == 1
                    ? "Change Photo"
                    : "Settings",
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

  Container likeAndDislikeContainer(int index) {
    return Container(
      constraints: BoxConstraints(minWidth: context.width * 0.2),
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blueGrey.withOpacity(0.1),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              index == 0 ? "134" : "59",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
          Text(
            index == 0 ? "Like" : "Dislike",
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
        ],
      ),
    );
  }

  ListTile customListTile(int index) {
    return ListTile(
      title: Text(
          index == 0
              ? "Edit Profile"
              : index == 1
                  ? "Change Password"
                  : index == 2
                      ? "Contact us"
                      : "Privacy Policy",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
      //subtitle: Text("@56asw121s"),
      onTap: () {},
      leading: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5),
            ]),
        padding: EdgeInsets.all(15),
        child: Icon(
          index == 0
              ? FontAwesomeIcons.userEdit
              : index == 1
                  ? FontAwesomeIcons.key
                  : index == 2
                      ? FontAwesomeIcons.solidAddressBook
                      : FontAwesomeIcons.userShield,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
      ),
    );
  }
}
