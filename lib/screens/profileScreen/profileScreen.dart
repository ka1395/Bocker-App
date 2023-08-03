import 'package:brocker/appCubite/stats.dart';
import 'package:brocker/component/components.dart';
import 'package:brocker/models/getChatsModel.dart';
import 'package:brocker/screens/settingScreen/settingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:timelines/timelines.dart';

import '../../appCubite/cubit.dart';
import '../../component/post.dart';
import '../../models/getUserData.dart';
import '../addposts/Newpost.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        GetUserModel userData = AppCubit.get(context).getUserModel!;
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .3,
                  child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * .25,
                            color: Colors.grey,
                            child: Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 30),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                            // decoration: BoxDecoration(
                            //     image: DecorationImage(
                            //   fit: BoxFit.cover,
                            //   image: NetworkImage(
                            //     "${userModel!.coverImage}",
                            //   ),

                            // )
                            // ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage: userData.userType == "admin"
                                  ? AssetImage("assets/images/admin.png")
                                  : AssetImage("assets/images/profileImg.png"),
                            ),
                          ),
                        ),
                      ]),
                ),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Text(
                      "${userData.fullname}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 25),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Text(
                      "${userData.username}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          navigateTo(context, NewPost());
                        },
                        child: Text("Add Post"),
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        // navigateTo(context, EditScreen());
                        navigateTo(context, SettingScreen());
                      },
                      child: Icon(
                        Icons.edit,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children:
                        AppCubit.get(context).ListPosts!.posts!.map((element) {
                      if (element.seller!.id ==
                          AppCubit.get(context).getUserModel!.id) {
                        String date = element.createdAt!;
                        DateTime parseDate =
                            new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                .parse(date);
                        var inputDate = DateTime.parse(parseDate.toString());
                        var outputFormat = DateFormat('MMM d hh:mm a');
                        var outputDate = outputFormat.format(inputDate);
                        return TimelineTile(
                          nodeAlign: TimelineNodeAlign.start,
                          contents: Container(
                            child: buildPost(context, element),
                          ),
                          node: TimelineNode(
                            indicatorPosition: .1,
                            indicator: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.grey,
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Colors.grey.shade900,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RotatedBox(
                                    quarterTurns: 1,
                                    child: RichText(
                                      text: TextSpan(
                                          text: outputDate,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: Colors.black)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            startConnector:
                                SolidLineConnector(color: Colors.grey),
                            endConnector:
                                SolidLineConnector(color: Colors.grey),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


///"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc faucibus turpis quis tincidunt luctus. Nam sagittis dui in nunc consequat, in imperdiet nunc sagittis."
///"assets/images/dp.jpg"