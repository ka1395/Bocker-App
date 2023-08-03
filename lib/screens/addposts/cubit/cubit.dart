import 'dart:io';

import 'package:brocker/Network/remote/dio.dart';
import 'package:brocker/models/CreatePostModel.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Network/remote/endPoint.dart';
import '../../../const.dart';
import 'stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';

class AddPostCubit extends Cubit<AddPostStats> {
  AddPostCubit() : super(Initstats());
  static AddPostCubit getobject(context) => BlocProvider.of(context);
  PageController screencontroller = PageController();

  var titlecontroller = TextEditingController();
  var pricecontroller = TextEditingController();
  var spacecontroller = TextEditingController();
  var roomscontroller = TextEditingController();
  int currentpage = 0;

  File? mainimage;
  ImagePicker picker = ImagePicker();

  Future getmainimage() async {
    var temp = await picker.pickImage(source: ImageSource.gallery);
    if (temp != null) {
      mainimage = File(temp.path);
      emit(PickeImageSuccessStats());
    } else {
      print("No Image");
      emit(PickeImageErrorState());
    }
  }

  List<File> images = [];
  int imageindex = 0;
  Future getimages() async {
    var temp = null;
    temp = await picker.pickImage(source: ImageSource.gallery);
    if (temp != null) {
      images.add(File(temp.path));
      imageindex++;
      emit(PickeImageSuccessStats());
    } else {
      print("No Image");
      emit(PickeImageErrorState());
    }
  }

  void removeallimages() {
    images = [];
    imageindex = 0;
    emit(RemoveAllImagesstats());
  }

  void removeimages({required int index}) {
    emit(RemoveImagesprogressstats());
    images.removeAt(index - 1);
    imageindex--;
    emit(RemoveImagesstats());
  }

  // uploadPost({String ?filePath,}) async {
  //   var postUrl = "http://10.0.2.2:4000/uploads";
  //   String fileName = filePath!.split("/").last;

  //   FormData formData = FormData.fromMap({
  //     'mainImg': await MultipartFile.fromFile(filePath, filename: fileName),

  //   });

  //   DioHelper.post(url: GETAllPOSTS, data: formData as Map<String, dynamic>);
  // }
  String? stateError = '';
  CreatePostModel? postModel;
  FlatSpecsModel? flatSpecs;
  CreatePost({
    required String title,
    required String price,
    required File mainImg,
    required String space,
    required String flatType,
    required String numberOfRooms,
    List<File>? images,
  }) async {
    emit(CreatePostLoadingStats());

    flatSpecs = FlatSpecsModel(
        flatType: flatType, numberOfRooms: numberOfRooms, space: space);
    // var postUrl = "http://10.0.2.2:4000/uploads";
    String fileName = mainImg.path.split("/").last;
    // String fileNameImages = images![0].path.split("/").last;

    FormData formData = FormData.fromMap({
      'title': title,
      'price': price,
      'flatSpecs': flatSpecs!.toMap(),
    });

    formData.files.add(MapEntry(
      'mainImg',
      await MultipartFile.fromFile(mainImg.path,
              filename: fileName, contentType: MediaType("image", 'jpeg'))
          .whenComplete(() {
        print("Complete uploade mainImg ");
      }),
    ));

    for (int i = 0; i < images!.length; i++) {
      String imagePath = images[i].path;
      formData.files.add(MapEntry(
        'images',
        await MultipartFile.fromFile(imagePath,
                filename: imagePath.split('/').last,
                contentType: MediaType("image", 'jpg'))
            .whenComplete(() {
          print("Complete uploade images ");
        }),
      ));
    }

    await DioHelper.dio.post(
      GETAllPOSTS,
      data: formData,
      options: Options(headers: {
        "Authorization": "Bearer ${token}",
        "Content-Type": "multipart/form-data",
      }),
      onSendProgress: (count, total) {
        print("===============${count} : ${total}=============");
      },
    ).then((value) {
      if (value.data["error"] == true) {
        if (value.data["message"].runtimeType == List) {
          stateError =
              "${value.data["message"][0]['field']} is ${value.data["message"][0]['reason']}";
          print(stateError);
        } else {
          if (value.data["message"] ==
                  "Cannot read properties of undefined (reading '0')" ||
              value.data["message"] ==
                  "Cannot read properties of undefined (reading 'map')") {
            stateError = "Invalid Image";
            print(stateError);
          } else {
            stateError = value.data["message"];
            print(stateError);
          }
        }
      } else {
        stateError = "${value.data["post"]["status"]}";
        print(value.data["post"]["status"]);
      }
      emit(CreatePostSuccessStats());
    }).catchError((onError) {
      print(onError);
      emit(CreatePostErrorStats(onError));
    });

    // FirebaseFirestore.instance
    //     .collection("post")
    //     .add(postModel!.toMap())
    //     .then((value) {
    //   FirebaseFirestore.instance
    //       .collection("post")
    //       .doc(value.id)
    //       .update({'pId': value.id});
    //   // getPosts();
    //   removePostImage();
    //   emit(CreatePostSuccessStats());
    // }).catchError((onError) {
    //   print(onError);
    //   emit(CreatePostErrorStats(onError));
    // });
  }
}
