
import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../appCubite/cubit.dart';
import '../appCubite/stats.dart';
import 'components.dart';

class NavigationBottomBar extends StatelessWidget {
  const NavigationBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);

          return FancyBottomNavigation(
            tabs: [
              TabData(
                iconData: Icons.house_outlined,
                title: "Home",
              ),
              TabData(
                iconData: Icons.favorite,
                title: "Favorite",
              ),
              TabData(iconData: Icons.chat, title: "chat"),
              TabData(iconData: Icons.exit_to_app_rounded, title: "LOGOUT"),
            ],
            activeIconColor: Colors.white,
            textColor: Colors.white,
            barBackgroundColor: themAppColor1,
            initialSelection: 0,
            onTabChangedListener: (position) {
              cubit.changePage(position, context);
            },
          );
        });
  }
}
