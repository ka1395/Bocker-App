import 'dart:io';

class CreatePostModel {
  String? title;
  String? price;
  File? mainImg;
  List<File>? images;
  FlatSpecsModel? flatSpecs;
  CreatePostModel.fromJson(Map<String, dynamic> json) {
    images = json["images"];
    title = json["title"];
    price = json["price"];
    mainImg = json["mainImg"];
    flatSpecs = FlatSpecsModel.fromJson(json["flatSpecs"]);
  }
  CreatePostModel(
      {this.title, this.price, this.mainImg, this.images, this.flatSpecs});

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "price": price,
      "mainImg": mainImg,
      "images": images,
      "flatSpecs": flatSpecs,
    };
  }
}

class FlatSpecsModel {
  String? space;
  String? flatType;
  String? numberOfRooms;
  FlatSpecsModel({this.flatType, this.numberOfRooms, this.space});
  Map<String, dynamic> toMap() {
    return {
      "space": space,
      "flatType": flatType,
      "numberOfRooms": numberOfRooms,
    };
  }

  FlatSpecsModel.fromJson(Map<String, dynamic> json) {
    space = json["space"];
    flatType = json["flatType"];
    numberOfRooms = json["numberOfRooms"];
  }
}






// '{"title":"testing the test of tests",
// "price":30,
// "flatSpecs":{
//   "space":"20m",
// "flatType":"single",
// "numberOfRooms":"3"
// }
// }'