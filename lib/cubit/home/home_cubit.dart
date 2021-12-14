import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:speakmatch_v2/controller/home_controller.dart';
import 'package:speakmatch_v2/data/model/authentication/response/authentication_response_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  HomeController _homeController = HomeController();

  Future<UserResponseModel> getUser() async {
    final response = await _homeController.currentUser();
    if (response != null) {
      return response;
    } else {
      return null;
    }
  }
}
