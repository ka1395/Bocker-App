class GetChatsModel {
  // List<Map<String ,dynamic>> ?chat;
  String? id;
  UserModel? firstUser;
  UserModel? secondUser;
  List<MessageModel>? messages;
  String? createdAt;
  String? updatedAt;
  GetChatsModel.fromJson(Map<String, dynamic> json) {
    messages = [];
    id = json["_id"];
    firstUser = UserModel.fromJson(json['firstUser']);
    secondUser = UserModel.fromJson(json['secondUser']);
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    json["messages"].forEach((msg) {
      messages!.add(MessageModel.fromJson(msg));
    });
  }
}

class UserModel {
  String? id;
  String? fullname;
  String? age;
  String? nationalId;
  String? username;
  String? email;
  String? password;
  String? userType;

  String? wallet;
  String? createdAt;
  String? updatedAt;
  List? favouriteIdPosts;
  List? chats;
  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    fullname = json["fullname"];
    nationalId = json["nationalId"];
    username = json["username"];
    email = json["email"];
    password = json["password"];
    userType = json["userType"];
    wallet = json["wallet"];
    createdAt = json["createdAt"];
    favouriteIdPosts = json["favouriteIdPosts"];
    chats = json["chats"];
  }
}

class MessageModel {
  String? id;
  String? text;
   String? sender;
  String? receiver;
  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    text = json["text"];
    sender = json["sender"];
    receiver = json["receiver"];
  }

  MessageModel(this.id, this.text, this.sender, this.receiver);


 

}




//message
//  {
//                     "text": "How are you my friend?",
//                     "sender": "6435d249f38764bf980a8293",
//                     "receiver": "6442c02866e2542472a20074",
//                     "_id": "647118ac8ec6e0e4db18096e"
//                 },



// "chat": [
//         {
//             "_id": "6442c24766e2542472a2008a",
//             "firstUser": {
//                 "_id": "6435d249f38764bf980a8293",
//                 "fullname": "khaled ahmed",
//                 "age": "23",
//                 "nationalId": "30008042101612",
//                 "username": "khaled",
//                 "email": "khaled123@gmail.com",
//                 "password": "$2b$10$oDDaTfssAn2WQwhsA7YR3elaz6T3kPqYDbZdomwmgMjSFINXd/2VS",
//                 "userType": "admin",
//                 "favouritePosts": [
//                     "64396f6c22497a98ca20bb21",
//                     "64396fa422497a98ca20bb24"
//                 ],
//                 "chats": [],
//                 "wallet": "6435d249f38764bf980a8294",
//                 "createdAt": "2023-04-11T21:34:01.057Z",
//                 "updatedAt": "2023-04-25T18:05:03.748Z",
//                 "__v": 0
//             },
//             "secondUser": {
//                 "_id": "6442c02866e2542472a20074",
//                 "fullname": "ahmed ismail",
//                 "age": "24",
//                 "nationalId": "30008042105522",
//                 "username": "ahmed",
//                 "email": "ahmed123@gmail.com",
//                 "password": "$2b$10$3z3A81gYIZIA9IS2B7L9PO8uN429Enu9hrMh3H5SOO833p.TFdzMm",
//                 "userType": "normal",
//                 "favouritePosts": [],
//                 "chats": [],
//                 "wallet": "6442c02866e2542472a20075",
//                 "createdAt": "2023-04-21T16:56:08.741Z",
//                 "updatedAt": "2023-04-21T16:56:08.741Z",
//                 "__v": 0
//             },
//             "messages": [],
//             "createdAt": "2023-04-21T17:05:11.069Z",
//             "updatedAt": "2023-04-21T17:05:11.069Z",
//             "__v": 0
//         }
//     ]