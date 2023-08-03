import 'package:flutter/material.dart';

import '../appCubite/cubit.dart';
import '../models/getPostsModel.dart';
import '../screens/postDetailsScreen/postDetailsScreen.dart';
import 'components.dart';

Widget buildPost(BuildContext context, GetPostModel post) => InkWell(
      onTap: () {
        navigateTo(
            context,
            PostDetailsScreen(
              postId: post.id!,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .3,
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Stack(children: [
                  Image(
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
                      "http://10.0.2.2:4000/uploads/${post.images![0]}",
                    ),
                    fit: BoxFit.fill,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
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
                              )))),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: Container(
                      padding: EdgeInsets.all(11),
                      color: Colors.black54,
                      child: Text(
                        "\$${post.price}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Text(post.title!,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.roofing_rounded,
                      size: 30,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      post.flatSpecs!.space!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.emoji_people_sharp,
                      size: 30,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      post.flatSpecs!.flatType!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.meeting_room,
                      size: 30,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      post.flatSpecs!.numberOfRooms!,
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
              height: 50,
              thickness: 1.5,
            )
          ],
        ),
      ),
    );
