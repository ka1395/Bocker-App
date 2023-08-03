import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:brocker/Network/remote/endPoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Network/remote/dio.dart';
import '../../../models/registerModel.dart';
import 'states.dart';

class RegisterCubit extends Cubit<RegisterStats> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  bool isVisibalPassword = true;

  IconData iconStatePassword = Icons.visibility_off;

  changeVisibalPassword() {
    isVisibalPassword = !isVisibalPassword;

    iconStatePassword =
        !isVisibalPassword ? Icons.visibility : Icons.visibility_off;

    emit(RegisterchangeVisibiltyPasswordState());
  }

  bool isVisibalPasswordConfirem = true;

  IconData iconStatePasswordConfirem = Icons.visibility_off;

  changeVisibalPasswordConfirem() {
    isVisibalPasswordConfirem = !isVisibalPasswordConfirem;

    iconStatePasswordConfirem =
        !isVisibalPasswordConfirem ? Icons.visibility : Icons.visibility_off;

    emit(RegisterchangeVisibiltyPasswordConfiremState());
  }

  RegisterModel? registerModel;
  postData({
    required String fullname,
    required int age,
    required String nationalId,
    required String username,
    required String password,
    required String confirmPassword,
    required String email,
  }) {
    emit(RegisterLoadingState());
    DioHelper.post(url: REGISTER, data: {
      "fullname": fullname,
      "age": age,
      "nationalId": nationalId,
      "username": username,
      "password": password,
      "confirmPassword": confirmPassword,
      "email": email,
    }).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      print(registerModel!.error);
      print(registerModel!.message);
      emit(RegisterSuccessState());
    }).catchError((Error) {
      print(Error);
      emit(RegisterErrorState());
    });
  }
}
