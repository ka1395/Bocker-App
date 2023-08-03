abstract class AppStates {}

class AppIntialState extends AppStates {}

class AppChangePageState extends AppStates {}

class AppChangeSwitchState extends AppStates {}

class GetUserDataSuccessState extends AppStates {}

class GetUserDataLoadingState extends AppStates {}

class GetUserDataErrorState extends AppStates {}

class PutUserDataLoadingStats extends AppStates {}

class PutUserDataSuccessStats extends AppStates {

}

class PutUserDataErrorStats extends AppStates {}

class HomeGetAllPostsSuccessState extends AppStates {}

class HomeGetAllPostsLoadingState extends AppStates {}

class HomeGetAllPostsErrorState extends AppStates {}

class GetFavoritesLoadingStats extends AppStates {}

class GetFavoritesSuccessStats extends AppStates {}

class GetFavoritesErrorStats extends AppStates {
  final error;

  GetFavoritesErrorStats(this.error);
}

class FavoritesChangeStats extends AppStates {}

class FavoritesSucssesChangeStats extends AppStates {}

class FavoritesErrorChangeStats extends AppStates {
  final error;

  FavoritesErrorChangeStats(this.error);
}

class GetChatsLoadingStats extends AppStates {}

class GetChatsSuccessStats extends AppStates {}

class GetChatsErrorStats extends AppStates {
  final error;

  GetChatsErrorStats(this.error);
}
class CreateChatLoadingStats extends AppStates {}

class CreateChatSuccessStats extends AppStates {}

class CreateChatErrorStats extends AppStates {
  final error;

  CreateChatErrorStats(this.error);
}
class SendMessageSuccessStats extends AppStates {}
class GetMessageSuccessStats extends AppStates {}

 


// class SendMessageLoadingStats extends AppStates {}

// class SendMessageErrorStats extends AppStates {
//   final error;

//   SendMessageErrorStats(this.error);
// }
