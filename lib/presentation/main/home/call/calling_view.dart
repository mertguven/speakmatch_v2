import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:speakmatch_v2/cubit/home/call/call_cubit.dart';
import 'package:speakmatch_v2/cubit/profile/profile_cubit.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/presentation/main/home/call/matched_view.dart';
import 'package:speakmatch_v2/shared-prefs.dart';

class CallingView extends StatefulWidget {
  const CallingView({Key key}) : super(key: key);

  @override
  _CallingViewState createState() => _CallingViewState();
}

class _CallingViewState extends State<CallingView> {
  UserResponseModel _matchedUserResponseModel;
  String _roomName;

  @override
  void initState() {
    calling();
    super.initState();
  }

  Future<void> deleteUserAtWaitingRoom() async {
    context.read<CallCubit>().deleteUserAtWaitingRoom();
  }

  void calling() async {
    context.read<CallCubit>().calling();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: context.watch<CallCubit>().listeningToMeetingRooms(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.size > 0) {
              for (var item in snapshot.data.docChanges) {
                if (item.doc.id.contains(SharedPrefs.getUid)) {
                  _roomName = item.doc.id;
                  for (var user in _roomName.split("-")) {
                    if (!user.contains(SharedPrefs.getUid)) {
                      context
                          .read<CallCubit>()
                          .getMatchingUsersInfo(user)
                          .then((value) {
                        _matchedUserResponseModel = value;
                        deleteUserAtWaitingRoom().whenComplete(() => Timer(
                            Duration(seconds: 2),
                            () => Get.offAll(
                                () => MatchedView(
                                    matchedUser: _matchedUserResponseModel,
                                    roomName: _roomName),
                                transition: Transition.noTransition)));
                      });
                    }
                  }
                }
              }
            }
            /*if (snapshot.hasData &&
                snapshot.data.docs.length > 0 &&
                snapshot.data.docs.any((element) {
                  if (element.id.contains(SharedPrefs.getUid)) {
                    _roomName = element.id;
                    for (var user in _roomName.split("-")) {
                      if (!user.contains(SharedPrefs.getUid)) {
                        context
                            .read<CallCubit>()
                            .getMatchingUsersInfo(user)
                            .then((value) => _matchedUserResponseModel = value);
                      }
                    }
                    return true;
                  } else {
                    return false;
                  }
                })) {
              deleteUserAtWaitingRoom().whenComplete(() {
                Timer(
                    Duration(seconds: 2),
                    () => Get.offAll(
                        () => MatchedView(
                            matchedUser: _matchedUserResponseModel,
                            roomName: _roomName),
                        transition: Transition.noTransition));

                /*Future.delayed(
                    Duration(seconds: 2),
                    () => Get.offAll(
                        () => MatchedView(
                            matchedUser: _matchedUserResponseModel,
                            roomName: _roomName),
                        transition: Transition.noTransition));*/
              });
            }*/
            return callingWidget();
          },
        ),
      ),
    );
  }

  Column callingWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LottieBuilder.asset("assets/animations/calling.json"),
        Text(
          "Calling...",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20),
        ),
      ],
    );
  }
}
