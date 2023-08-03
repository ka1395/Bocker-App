import 'package:bloc/bloc.dart';
import 'package:brocker/Network/remote/dio.dart';
import 'package:brocker/const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Network/remote/endPoint.dart';
import 'stats.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChartIntialState());

  static ChatCubit get(context) => BlocProvider.of(context);

  
}
