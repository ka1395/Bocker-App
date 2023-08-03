class GetUserModel {
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
  GetUserModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    fullname = json["fullname"];
    age = json['age'];
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
// "user": {
//         "_id": "6435d249f38764bf980a8293",
//         "fullname": "khaled ahmed",
//         "age": "23",
//         "nationalId": "30008042101612",
//         "username": "khaled",
//         "email": "khaled123@gmail.com",
//         "password": "$2b$10$oDDaTfssAn2WQwhsA7YR3elaz6T3kPqYDbZdomwmgMjSFINXd/2VS",
//         "userType": "admin",
//         "favouritePosts": [
//             "64396f6c22497a98ca20bb21"
//         ],
//         "chats": [],
//         "wallet": "6435d249f38764bf980a8294",
//         "createdAt": "2023-04-11T21:34:01.057Z",
//         "updatedAt": "2023-05-15T22:00:27.167Z",
//         "__v": 0
//     }