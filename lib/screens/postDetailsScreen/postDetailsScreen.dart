import 'package:brocker/appCubite/cubit.dart';
import 'package:brocker/appCubite/stats.dart';
import 'package:brocker/panorama.dart';
import 'package:brocker/screens/chatDetailsScreen/chatDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';

import '../../component/components.dart';
import '../../models/getPostsModel.dart';

class PostDetailsScreen extends StatelessWidget {
  PostDetailsScreen({super.key, required this.postId});
  final String postId;
  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (AppCubit.get(context).ListPosts == null)
          return Scaffold(body: Center(child: CircularProgressIndicator()));

        for (var element in AppCubit.get(context).ListPosts!.posts!) {
          if (element.id == postId)
            return Scaffold(
              body: buildPostDetails(context, element),
            );
        }
        return Scaffold(
          body: Center(
            child: Text("Error 404"),
          ),
        );
      },
    );
  }

  Widget buildPostDetails(BuildContext context, GetPostModel post) {
    String date = post.createdAt!;
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MMM d hh:mm a');
    var outputDate = outputFormat.format(inputDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
            height: MediaQuery.of(context).size.height * .35,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              ImageSlideshow(
                height: MediaQuery.of(context).size.height * .35,
                width: MediaQuery.of(context).size.width,
                indicatorRadius: 5,
                initialPage: 0,
                indicatorColor: Colors.white,
                indicatorBackgroundColor: Colors.grey,
                children: post.images!.map((e) {
                  return Image(
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                          child: Text(
                        "Image Not Found!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ));
                    },
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return CircularProgressIndicator();
                    },
                    image: NetworkImage(
                      "http://10.0.2.2:4000/uploads/${e}",
                    ),
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                  );
                }).toList(),
                autoPlayInterval: 5000,
                isLoop: true,
              ),
              Positioned(
                top: 30,
                left: 15,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    )),
              )
            ])),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(post.title!,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.bodyLarge),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 25),
          child: Text(outputDate,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.grey)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Text("Asking",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.grey)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${post.price}",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.grey, fontSize: 25),
              ),
              IconButton(
                  onPressed: () {
                    AppCubit.get(context).changeFavorites(post.id!);
                  },
                  icon: CircleAvatar(
                      backgroundColor:
                          AppCubit.get(context).isFavorites(post.id!)
                              ? Colors.red
                              : Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        size: 17,
                        color: Colors.white,
                      )))
            ],
          ),
        ),
        Divider(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Icon(
                  Icons.roofing_rounded,
                  size: 30,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Flate ${post.flatSpecs!.space}m",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey),
                ),
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.emoji_people_sharp,
                  size: 30,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Type ${post.flatSpecs!.flatType}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey),
                )
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.meeting_room,
                  size: 30,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "rooms ${post.flatSpecs!.numberOfRooms}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey),
                )
              ],
            ),
          ],
        ),
        Divider(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: button("image 360", () {
            navigateTo(
                context,
                panorama(
                  imagePath: post.mainImg,
                ));
            // AppCubit.get(context).newChate(post.seller!.id!, context);
          },
              h: 50,
              w: 10,
              color: Colors.black54,
              colorText: Colors.white,
              fontsize: 18,
              borderradius: 10,
              colorborder: Colors.black54),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: post.seller!.userType == "admin"
                          ? AssetImage("assets/images/admin.png")
                          : AssetImage("assets/images/profileImg.png"),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.seller!.fullname!,
                          overflow: TextOverflow.visible,
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text(
                        post.seller!.userType!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              post.seller!.id != AppCubit.get(context).getUserModel!.id
                  ? button("Start Messge", () {
                      AppCubit.get(context).newChate(post.seller!.id!, context);
                    },
                      h: 50,
                      w: 10,
                      color: Colors.black54,
                      colorText: Colors.white,
                      fontsize: 12,
                      borderradius: 10,
                      colorborder: Colors.black54)
                  : Container()
            ],
          ),
        )
      ],
    );
  }
}


// {
//     "message": "Chat is found",
//     "chat": {
//         "_id": "6442c24766e2542472a2008a",
//         "firstUser": "6435d249f38764bf980a8293",
//         "secondUser": "6442c02866e2542472a20074",
//         "messages": [],
//         "createdAt": "2023-04-21T17:05:11.069Z",
//         "updatedAt": "2023-04-21T17:05:11.069Z",
//         "__v": 0
//     }
// }



// {
//     "message": "Chat created successfully",
//     "chat": {
//         "_id": "6470da52ed40390b365b23f8",
//         "firstUser": {
//             "_id": "6435d249f38764bf980a8293",
//             "fullname": "khaled ahmed",
//             "age": "23",
//             "nationalId": "30008042101612",
//             "username": "khaled",
//             "email": "khaled123@gmail.com",
//             "password": "$2b$10$3z3A81gYIZIA9IS2B7L9PO8uN429Enu9hrMh3H5SOO833p.TFdzMm",
//             "userType": "admin",
//             "favouritePosts": [
//                 "64396f6c22497a98ca20bb21"
//             ],
//             "chats": [],
//             "wallet": "6435d249f38764bf980a8294",
//             "createdAt": "2023-04-11T21:34:01.057Z",
//             "updatedAt": "2023-05-26T14:36:12.384Z",
//             "__v": 0
//         },
//         "secondUser": {
//             "_id": "6442c02866e2542472a20074",
//             "fullname": "ahmed ismail",
//             "age": "24",
//             "nationalId": "30008042105522",
//             "username": "ahmed",
//             "email": "ahmed123@gmail.com",
//             "password": "$2b$10$3z3A81gYIZIA9IS2B7L9PO8uN429Enu9hrMh3H5SOO833p.TFdzMm",
//             "userType": "normal",
//             "favouritePosts": [],
//             "chats": [],
//             "wallet": "6442c02866e2542472a20075",
//             "createdAt": "2023-04-21T16:56:08.741Z",
//             "updatedAt": "2023-04-21T16:56:08.741Z",
//             "__v": 0
//         },
//         "messages": [],
//         "createdAt": "2023-05-26T16:12:02.414Z",
//         "updatedAt": "2023-05-26T16:12:02.414Z",
//         "__v": 0
//     }
// }