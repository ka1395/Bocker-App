class FavoriteModel {
  String? id;
  String? title;
  String? mainImg;
  String? status;
  dynamic price;
  String? createdAt;
  String? updatedAt;
  String? seller;
  FlatSpecsModel? flatSpecs;
  List? comments;
  List? images;
  FavoriteModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    title = json["title"];
    mainImg = json["mainImg"];
    status = json["status"];
    price = json["price"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    createdAt = json["createdAt"];
    seller = json["seller"];
    flatSpecs = FlatSpecsModel.fromJson(json["flatSpecs"]);
    comments = json["comments"];
    images = json["images"];
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
//             "seller": "63978d0ecb1e229576e2949b"
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