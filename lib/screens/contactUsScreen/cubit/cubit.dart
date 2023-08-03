import 'package:bloc/bloc.dart';
import 'package:brocker/Network/remote/endPoint.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Network/remote/dio.dart';
import '../../../models/ContactModel.dart';
import 'stats.dart';

class ContactCubit extends Cubit<ContactStats> {
  ContactCubit() : super(ContactInitialState());
  static ContactCubit get(context) => BlocProvider.of(context);

//  "name": "Seif",
//     "email": "seiftahawy54@gmail.com",
//     "message": "testing 12345"
  ContactModel? contactModel;
  postData({
    required String name,
    required String email,
    required String message,
  }) {
    emit(ContactLoadingState());
    DioHelper.post(url: CONTACT, data: {
      "name": name,
      "email": email,
      "message": message,
    }).then((value) {
      contactModel = ContactModel.fromJson(value.data);
      print(contactModel!.message);

      emit(ContactSuccessState());
    }).catchError((Error) {
      print(Error);
      emit(ContactErrorState());
    });
  }
}
