import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:speakmatch_v2/core/utilities/custom_divider.dart';
import 'package:speakmatch_v2/cubit/home/notification/notification_cubit.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<RxBool> _isOpen = <RxBool>[];
  @override
  void initState() {
    context.read<NotificationCubit>().getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: _appBar,
      body: bloc.BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoadingState) {
            return _loadingWidget;
          } else if (state is NotificationLoadedState) {
            if (state.listOfModel.length > 0) {
              _isOpen.addAll(Iterable.generate(
                  state.listOfModel.length, (i) => false.obs));
              return _notificationsWidget(state);
            } else {
              return _thereIsNotNotification;
            }
          } else if (state is NotificationFailedState) {
            return _notificationFailed(state);
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  AppBar get _appBar {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title:
          Text("Notifications", style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Center get _loadingWidget => Center(child: CircularProgressIndicator());

  SingleChildScrollView _notificationsWidget(NotificationLoadedState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10),
          shrinkWrap: true,
          itemCount: state.listOfModel.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100),
              child: ExpansionTile(
                leading: CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/inactive_bnb_logo.png"),
                  backgroundColor: Colors.transparent,
                ),
                title: Text(
                  state.listOfModel[index].title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                  ),
                ),
                children: [
                  CustomDivider(color: Theme.of(context).colorScheme.primary),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 10, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            state.listOfModel[index].body,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "${state.listOfModel[index].sendTime.day}/${state.listOfModel[index].sendTime.month}/${state.listOfModel[index].sendTime.year}, ${state.listOfModel[index].sendTime.hour}:${state.listOfModel[index].sendTime.second}",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Center get _thereIsNotNotification {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            "assets/animations/no_notification.json",
            width: context.width * 0.7,
          ),
          Text(
            "There is nothing here",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          )
        ],
      ),
    );
  }

  Text _notificationFailed(NotificationFailedState state) {
    return Text(
      state.errorMessage,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
