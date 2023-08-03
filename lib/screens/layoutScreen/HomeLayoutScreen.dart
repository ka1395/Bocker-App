import 'package:brocker/screens/searchScreen/searchScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../appCubite/cubit.dart';
import '../../appCubite/stats.dart';
import '../../component/components.dart';
import '../../component/navigationBar.dart';
import '../../models/getUserData.dart';
import '../addposts/Newpost.dart';
import '../profileScreen/profileScreen.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    IconButton(
                      icon:
                          // CircleAvatar(
                          //   backgroundImage:
                          //       AppCubit.get(context).getUserModel!.userType ==
                          //               "admin"
                          //           ? AssetImage("assets/images/admin.png")
                          //           : AssetImage("assets/images/profileImg.png"),
                          // ),
                          CircleAvatar(child: Icon(Icons.person)),
                      color: themAppColorIcon,
                      onPressed: () {
                        navigateTo(context, ProfileScreen());
                      },
                    ),
                    Text(
                      "BROKER",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        navigateTo(context, NewPost());
                      },
                      icon: Icon(Icons.post_add_rounded)),
                  IconButton(
                      onPressed: () {
                        navigateTo(context, SearchScreen());
                      },
                      icon: Icon(Icons.search)),
                ],
              ),
              body: AppCubit.get(context)
                  .pageBottomNavigationPar[AppCubit.get(context).indexPage],
              bottomNavigationBar: NavigationBottomBar());
        });
  }
}
