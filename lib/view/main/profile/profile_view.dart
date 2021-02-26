import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speakmatch_v2/shared-prefs.dart';
import 'package:speakmatch_v2/view/signin_signup/login_and_register_view.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("@user12312"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getUserInformation(),
        builder: (context, result) {
          return result.hasData
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        maxRadius: 70,
                        backgroundImage: NetworkImage(
                            "https://media-exp1.licdn.com/dms/image/C4D03AQG7W4deihSP1Q/profile-displayphoto-shrink_800_800/0/1608990485436?e=1619654400&v=beta&t=sPX-HGvB6YaOVC7BVaLF8_7KlMHJN-X9ffOm9-tcvr0"),
                      ),
                      Text("Profile View"),
                      RaisedButton(
                        onPressed: () {
                          SharedPrefs.sharedClear();
                          Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(builder: (context) => LoginAndRegisterView()),
                              (_) => false);
                        },
                        child: Text("Exit"),
                      ),
                    ],
                  ),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<void> getUserInformation() async {}
}
