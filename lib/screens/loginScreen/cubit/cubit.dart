import 'package:brocker/Network/remote/dio.dart';
import 'package:brocker/const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Network/remote/endPoint.dart';
import '../../../models/loginModel.dart';
import 'stats.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginIntialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;
  postData({
    required String userName,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.post(url: LOGIN, data: {
      "username": userName,
      "password": password,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      if (loginModel!.token != null) token = loginModel!.token!;
      print(token);

      emit(LoginSuccessState());
    }).catchError((Error) {
      print(Error);
      emit(LoginErrorState());
    });
  }
}
