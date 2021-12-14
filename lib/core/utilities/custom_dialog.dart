import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

void customDialog(BuildContext context,
    {String content,
    VoidCallback onPressed,
    String buttonText,
    String title,
    String lottiePath,
    Image image}) {
  Get.dialog(
      AlertDialog(
        elevation: 100,
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: EdgeInsets.only(bottom: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Container(
          constraints: BoxConstraints(maxHeight: context.height * 0.5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).primaryColor),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: image ?? LottieBuilder.asset(lottiePath),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                content,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: StadiumBorder()),
            child: Text(
              buttonText,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          )
        ],
      ),
      transitionCurve: Curves.easeInQuint);
}
