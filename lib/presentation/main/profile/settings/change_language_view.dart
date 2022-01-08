import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:speakmatch_v2/core/constants/app_constant.dart';
import 'package:speakmatch_v2/shared-prefs.dart';

class ChangeLanguageView extends StatefulWidget {
  const ChangeLanguageView({Key key}) : super(key: key);

  @override
  _ChangeLanguageViewState createState() => _ChangeLanguageViewState();
}

class _ChangeLanguageViewState extends State<ChangeLanguageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "changeLanguage".tr,
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        itemCount: AppConstant.supportedLocales.length,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                onTap: () {
                  SharedPrefs.saveLocale(AppConstant.supportedLocales[index]);
                  Get.updateLocale(AppConstant.supportedLocales[index]);
                },
                child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 1,
                              color: Colors.grey.shade300)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          child: Image.asset(
                            "assets/images/lang/${AppConstant.supportedLocales[index].languageCode}.png",
                            scale: 2,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            index == 0 ? "english".tr : "turkish".tr,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Icon(
                          FontAwesomeIcons.chevronRight,
                          color: Theme.of(context).colorScheme.primary,
                          size: 18,
                        ),
                      ],
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
