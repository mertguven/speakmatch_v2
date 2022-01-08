import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:speakmatch_v2/core/utilities/custom_snackbar.dart';
import 'package:speakmatch_v2/cubit/home/call/call_cubit.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';
import 'package:speakmatch_v2/data/model/home/request/agora_access_token_request_model.dart';
import 'package:speakmatch_v2/presentation/main/home/call/voice_call_view.dart';
import 'package:speakmatch_v2/presentation/main/page_router_view.dart';

class MatchedView extends StatefulWidget {
  final UserResponseModel matchedUser;
  final String roomName;
  const MatchedView({Key key, this.matchedUser, this.roomName})
      : super(key: key);

  @override
  _MatchedViewState createState() => _MatchedViewState();
}

class _MatchedViewState extends State<MatchedView> {
  @override
  void initState() {
    super.initState();
    context.read<CallCubit>().getAgoraAccessToken(
        AgoraAccessTokenRequestModel(channelName: widget.roomName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            Text(
              "${widget.matchedUser.displayName}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20),
            ),
            Lottie.asset("assets/animations/loading.json"),
            bloc.BlocListener<CallCubit, CallState>(
              listener: (context, state) {
                if (state is SuccessAgoraTokenState) {
                  Timer(
                      Duration(milliseconds: 1500),
                      () => Get.offAll(
                          () => VoiceCallView(
                                roomName: widget.roomName,
                                matchedUser: widget.matchedUser,
                                token: state.token,
                              ),
                          transition: Transition.noTransition));
                } else if (state is UnSuccessAgoraTokenState) {
                  customSnackbar(false, state.errorMessage);
                  Get.offAll(() => PageRouterView(),
                      transition: Transition.leftToRight);
                }
              },
              child: Text(
                "connecting".tr,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20),
              ),
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
