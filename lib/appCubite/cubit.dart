import 'package:bloc/bloc.dart';
import 'package:brocker/Network/remote/webSocket.dart';
import 'package:brocker/component/components.dart';
import 'package:brocker/models/getChatsModel.dart';
import 'package:brocker/models/getPostsModel.dart';
import 'package:brocker/screens/chatDetailsScreen/chatDetailsScreen.dart';
import 'package:brocker/screens/homescreen/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../Network/remote/dio.dart';
import '../Network/remote/endPoint.dart';
import '../const.dart';
import '../models/favoriteModel.dart';
import '../models/getUserData.dart';
import '../screens/chateScreen/chateScreen.dart';
import '../screens/favoriteScreen/favoriteScreen.dart';
import 'stats.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());

  static AppCubit get(BuildContext context) => BlocProvider.of(context);
  final Widget networkSvg = SvgPicture.network(
    "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1462889/pat.svg",
    semanticsLabel: 'A shark?!',
    fit: BoxFit.cover,
    height: 600,
  );
  int indexPage = 0;
  List<Widget> pageBottomNavigationPar = [
    HomeScreen(),
    FavoriteScreen(),
    ChatScreen()
  ];
  changePage(index, context) {
    if (index == 3) {
      indexPage = 0;
      token = '';
      Navigator.of(context).pop();
    } else if (index == 2) {
      getChats();
      indexPage = index;
    } else if (index == 0) {
      getPostData();
      indexPage = index;
    } else {
      indexPage = index;
    }

    emit(AppChangePageState());
  }

  GetUserModel? getUserModel;
  getUserData() {
    emit(GetUserDataLoadingState());

    DioHelper.get(url: USER, token: token).then((value) {
      getUserModel = GetUserModel.fromJson(value.data['user']);

      emit(GetUserDataSuccessState());
    }).catchError((Error) {
      print(Error);
      emit(GetUserDataErrorState());
    });
  }

  putUserData({
    String? name,
    String? username,
    String? email,
    String? age,
    String? nationalId,
  }) {
    emit(PutUserDataLoadingStats());
    DioHelper.put(url: UPDATE_USER, token: token, data: {
      "fullname": name,
      "username": username,
      "email": email,
      "age": age,
      "nationalId": nationalId,
    }).then((value) {
      // print(value.data["message"]);
      getUserData();
      emit(PutUserDataSuccessStats());
    }).catchError((Error) {
      print(Error);
      emit(PutUserDataErrorStats());
    });
  }

  ListGetPostModel? ListPosts;
  getPostData() {
    emit(HomeGetAllPostsLoadingState());
    DioHelper.get(url: GETAllPOSTS, token: token).then((value) {
      ListPosts = ListGetPostModel.fromJson(value.data);

      emit(HomeGetAllPostsSuccessState());
    }).catchError((Error) {
      print(Error);
      emit(HomeGetAllPostsErrorState());
    });
  }

  List<FavoriteModel>? favorits;

  void getFavoritiesData() {
    favorits = [];
    emit(GetFavoritesLoadingStats());

    DioHelper.get(url: FAVORITES, token: token).then((value) {
      value.data["favouritePosts"].forEach((element) {
        favorits!.add(FavoriteModel.fromJson(element));
      });
      emit(GetFavoritesSuccessStats());
    }).catchError((Error) {
      print(Error);

      emit(GetFavoritesErrorStats(Error));
    });
  }

  isFavorites(String id) {
    var out = favorits!.where((element) => element.id == id);
    if (out.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  FavoriteModel? favoritesModel;
  void changeFavorites(String id) {
    emit(FavoritesChangeStats());
    var out = favorits!.where((element) => element.id == id);
    if (out.isEmpty) {
      DioHelper.put(url: "${FAVORITES}${id}", token: token).then((value) {
        if (value.data["error"] != null)
          print("Error to add Item");
        else {
          print(value.data["message"]);
          getFavoritiesData();
        }
        emit(FavoritesSucssesChangeStats());
      }).catchError((Error) {
        print(Error);
        emit(FavoritesErrorChangeStats(Error));
      });
    } else {
      DioHelper.delet(url: "${DELETE}${id}", token: token).then((value) {
        if (value.data["error"] != null)
          print("Error to add Item");
        else {
          print(value.data["message"]);
          getFavoritiesData();
        }
        emit(FavoritesSucssesChangeStats());
      }).catchError((Error) {
        print(Error);
        emit(FavoritesErrorChangeStats(Error));
      });
    }
  }

  List<GetChatsModel> chats = [];
  getChats() {
    chats = [];
    emit(GetChatsLoadingStats());
    DioHelper.get(url: CHATS, token: token).then((value) {
      value.data["chat"].forEach((element) {
        chats.add(GetChatsModel.fromJson(element));
      });
      emit(GetChatsSuccessStats());
    }).catchError((onError) {
      emit(GetChatsErrorStats(onError));
    });
  }

  void newChate(String id, context) {
    emit(CreateChatLoadingStats());

    DioHelper.post(url: "${CREATE_CHATS}${id}", token: token).then((value) {
      if (value.data["message"] == "Chat created successfully")
        chats.add(GetChatsModel.fromJson(value.data['chat']));

      chats.forEach((element) {
        if (value.data["chat"]['_id'] == element.id) {
          emit(CreateChatSuccessStats());
          navigateTo(
              context,
              ChatDetails(
                chat: element,
              ));
        }
      });
    }).catchError((Error) {
      print(Error);
      emit(CreateChatErrorStats(Error));
    });
  }

  List<MessageModel>? ListMessage;
  void GetMessage({required String ChatId}) {
    ListMessage = [];
    chats.forEach((element) {
      if (element.id == ChatId) {
        ListMessage = element.messages;
      }
    });
    GetMessageSuccessStats();
  }

  void sendMessage(
      {required String otherUserId,
      required String chatId,
      required String message,
      required GetChatsModel chat}) {
    chat.messages!
        .add(MessageModel(chatId, message, getUserModel!.id, otherUserId));

    emit(SendMessageSuccessStats());
    WebSocketHelper.sendMessage(
        otherUserId: otherUserId, chatId: chatId, message: message);
  }
}
