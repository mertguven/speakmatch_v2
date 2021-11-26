import 'package:flutter/material.dart';
import 'package:speakmatch_v2/core/utilities/linear_loading_animation.dart';

class ProfileViewLoadingAnimationWidget extends StatelessWidget {
  const ProfileViewLoadingAnimationWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearLoadingAnimation(
      child: Column(
        children: [
          CircleAvatar(maxRadius: 70),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Text(
                  "SpeakMatch",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  "example@speakmatch.com",
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
    );
  }
}
