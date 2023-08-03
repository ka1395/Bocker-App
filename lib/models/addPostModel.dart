class AddPostModel {
  GetPostModel ?post;
  AddPostModel.fromJson(Map<String, dynamic> json) {
    post = json["post"];
 
  }
}

class GetPostModel {
  String? id;
  String? title;
  String? mainImg;
  String? status;
  dynamic price;
  String? createdAt;
  String? updatedAt;
  SellerModel? seller;
  FlatSpecsModel? flatSpecs;
  List? comments;
  List? images;
  GetPostModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    title = json["title"];
    mainImg = json["mainImg"];
    status = json["status"];
    price = json["price"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    createdAt = json["createdAt"];
    seller = SellerModel.fromJson(json["seller"]);
    flatSpecs = FlatSpecsModel.fromJson(json["flatSpecs"]);
    comments = json["comments"];
    images = json["images"];
  }
}

class SellerModel {
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
  SellerModel.fromJson(Map<String, dynamic> json) {
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

class FlatSpecsModel {
  String? space;

  String? numberOfRooms;

  String? flatType;

  String? id;
  FlatSpecsModel.fromJson(Map<String, dynamic> json) {
    space = json["space"];
    numberOfRooms = json["numberOfRooms"];
    flatType = json["flatType"];
    id = json["_id"];
  }
}



// {
//             "_id": "63b17f7986ab185e6bc7becd",
//             "seller": {
//                 "favouritePosts": [],
//                 "_id": "63978d0ecb1e229576e2949b",
//                 "fullname": "testing user 3",
//                 "age": "22",
//                 "nationalId": "30008042100436",
//                 "username": "seif55",
//                 "email": "seiftahaww54@gmail.com",
//                 "password": "$2b$10$0XkCn88iEm94oHCq9TNhkOK4HHtUlzYjPpztBMfzs/cJ983/Z0KFm",
//                 "userType": "admin",
//                 "chats": [],
//                 "wallet": "63978d0ecb1e229576e2949c",
//                 "createdAt": "2022-12-12T20:20:30.638Z",
//                 "updatedAt": "2022-12-12T20:20:30.638Z",
//                 "__v": 0
//             },
//             "title": "this is a great post 2",
//             "mainImg": "c2221ddbd901189149fb-focus.jpeg",
//             "images": [
//                 "206b6b0d66786f37d82c-full.jpeg"
//             ],
//             "status": "accepted",
//             "price": 30,
//             "flatSpecs": {
//                 "space": "20m",
//                 "numberOfRooms": "3",
//                 "flatType": "single",
//                 "_id": "63b17f7986ab185e6bc7bece"
//             },
//             "comments": [],
//             "createdAt": "2023-01-01T12:41:29.024Z",
//             "updatedAt": "2023-02-24T06:02:55.570Z",
//             "__v": 0
//         },











  // Map<String, dynamic> toMap() {
  //   return {
  //     "name": name,
  //     "pId":pId,
  //     "Postimage": Postimage,
  //     "uId": uId,
  //     "text": text,
  //     "dateTime": dateTime,
  //     "image": image,
  //     "likes": likes,
  //   };
  // }




//  "error": true,
//     "message": [
//         {
//             "field": "title",
//             "reason": "Invalid value"
//         }
//     ]




// {
//     "post": {
//         "seller": "6435d249f38764bf980a8293",
//         "title": "test upolade post",
//         "mainImg": "ffea9d0e701d939c140c-img4.jpg",
//         "images": [
//             "3a065c6609bd752f11b5-img4.jpg"
//         ],
//         "status": "underReview",
//         "price": 1000000,
//         "flatSpecs": {
//             "space": "42m",
//             "numberOfRooms": "7",
//             "flatType": "single",
//             "_id": "643ddeb653eeeaa8961976b8"
//         },
//         "_id": "643ddeb653eeeaa8961976b7",
//         "comments": [],
//         "createdAt": "2023-04-18T00:05:10.714Z",
//         "updatedAt": "2023-04-18T00:05:10.714Z",
//         "__v": 0
//     }
// }