import 'package:brocker/appCubite/cubit.dart';
import 'package:brocker/appCubite/stats.dart';
import 'package:brocker/models/favoriteModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: AppCubit.get(context).favorits!.isEmpty
                ? Center(
                    child: Text(
                      "Not Favorites Yet",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: Colors.grey),
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) => buildFavorite(
                        context, AppCubit.get(context).favorits![index]),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: AppCubit.get(context).favorits!.length));
      },
    );
  }

  Widget buildFavorite(BuildContext context, FavoriteModel fav) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 10,
          color: Colors.white,
          child: Container(
            height: MediaQuery.of(context).size.height * .18,
            child: Row(
              children: [
                Image(
                  image: NetworkImage(
                    "http://10.0.2.2:4000/uploads/${fav.images![0]}",
                  ),
                  height: MediaQuery.of(context).size.height * .18,
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width * .4,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                        child: Text(
                      "Image Not Found!",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ));
                  },
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return CircularProgressIndicator();
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.all(11),
                                color: Colors.black54,
                                child: Text(
                                  "\$${fav.price}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                )),
                            IconButton(
                                onPressed: () {
                                  AppCubit.get(context)
                                      .changeFavorites(fav.id!);
                                },
                                icon: CircleAvatar(
                                    backgroundColor: AppCubit.get(context)
                                            .isFavorites(fav.id!)
                                        ? Colors.red
                                        : Colors.grey,
                                    child: Icon(
                                      Icons.favorite_border,
                                      size: 17,
                                      color: Colors.white,
                                    )))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          child: Text("${fav.title}",
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(overflow: TextOverflow.ellipsis)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.roofing_rounded,
                                  size: 25,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "${fav.flatSpecs!.space}",
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
                                  size: 25,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "${fav.flatSpecs!.flatType}",
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
                                  size: 25,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "${fav.flatSpecs!.numberOfRooms}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
