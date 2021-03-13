import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:speakmatch_v2/controller/profile/profile_controller.dart';
import 'package:speakmatch_v2/model/profile/request/ChangeUserInformationRequestMessage.dart';
import 'package:speakmatch_v2/model/profile/response/GetUserInformationResponseMessage.dart';

class ChangeUserInformationView extends StatefulWidget {
  @override
  _ChangeUserInformationViewState createState() =>
      _ChangeUserInformationViewState();
}

class _ChangeUserInformationViewState extends State<ChangeUserInformationView> {
  String username;
  String age;
  String email;
  String gender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcı Bilgileri"),
      ),
      body: FutureBuilder<GetUserInformationResponseMessage>(
        future: getUserInformation(),
        builder: (context, result) {
          return result.hasData
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: result.data.username == null
                                ? ""
                                : result.data.username,
                            counterText: "Kullanıcı Adı",
                            counterStyle: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 2),
                            ),
                          ),
                          onChanged: (girilen) {
                            username = girilen;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 2),
                            ),
                            hintText:
                                result.data.age == null ? "" : result.data.age,
                            counterText: "Yaş",
                            counterStyle: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          onChanged: (girilen) {
                            age = girilen.toString();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 2),
                              ),
                              hintText: result.data.email == null
                                  ? ""
                                  : result.data.email,
                              counterText: "E-Posta",
                              counterStyle: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14)),
                          onChanged: (girilen) {
                            email = girilen;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          onTap: () => showSelectGenderDialog(),
                          leading: Icon(
                            FontAwesomeIcons.venusMars,
                            color: Theme.of(context).accentColor,
                          ),
                          title: Text(
                            gender != null
                                ? gender
                                : result.data.sex == null
                                    ? "Cinsiyet"
                                    : result.data.sex,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            primary: Theme.of(context).accentColor,
                            elevation: 5,
                          ),
                          onPressed: () => saveChanges(result.data),
                          child: Text(
                            "Kaydet",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<GetUserInformationResponseMessage> getUserInformation() async {
    final profileController =
        Provider.of<ProfileController>(context, listen: false);
    return await profileController.getUserInformation();
  }

  void showSelectGenderDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("Cinsiyetini Seç"),
            children: [
              genderOptions(0),
              genderOptions(1),
              genderOptions(2),
            ],
          );
        });
  }

  SimpleDialogOption genderOptions(int index) {
    return SimpleDialogOption(
      onPressed: () {
        setState(() {
          gender = index == 0
              ? "Erkek"
              : index == 1
                  ? "Kadın"
                  : "Diğer";
        });
        print(gender);
        Navigator.pop(context);
      },
      child: Row(
        children: [
          getGenderIcon(index),
          SizedBox(width: 20),
          Text(
            index == 0
                ? "Erkek"
                : index == 1
                    ? "Kadın"
                    : "Diğer",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Icon getGenderIcon(int index) {
    return Icon(
        index == 0
            ? FontAwesomeIcons.mars
            : index == 1
                ? FontAwesomeIcons.venus
                : FontAwesomeIcons.venusMars,
        color: index == 0
            ? Colors.blue
            : index == 1
                ? Colors.red
                : Colors.grey);
  }

  saveChanges(GetUserInformationResponseMessage data) async {
    final profileController =
        Provider.of<ProfileController>(context, listen: false);
    var request = ChangeUserInformationRequestMessage(
      username: username == null ? data.username : username,
      age: age == null ? data.age : age,
      email: email == null ? data.email : email,
      sex: gender == null ? data.sex : gender,
    );
    var response = await profileController.changeUserInformation(request);
    if (response.success) {
      Navigator.pop(context);
      Navigator.pop(context);
      customSnackbar(response.success, response.messages);
    } else {
      customSnackbar(response.success, response.messages);
    }
  }

  customSnackbar(bool success, String content) {
    Get.snackbar(null, null,
        margin: EdgeInsets.all(15),
        duration: Duration(seconds: 5),
        borderRadius: 7,
        messageText: Text(
          content,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        icon: Icon(
          success ? Icons.done : Icons.info,
          size: 28.0,
          color: Colors.white,
        ),
        backgroundColor: success ? Colors.lightGreen : Color(0xffD64565),
        snackPosition: SnackPosition.TOP);
  }
}
