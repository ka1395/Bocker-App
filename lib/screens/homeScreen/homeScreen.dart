import 'package:brocker/appCubite/stats.dart';
import 'package:brocker/component/components.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';

import '../../appCubite/cubit.dart';
import '../../component/post.dart';
import '../../const.dart';
import '../../models/getPostsModel.dart';
import '../postDetailsScreen/postDetailsScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        print(token);
        return SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppCubit.get(context).ListPosts == null
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children:
                        AppCubit.get(context).ListPosts!.posts!.map((element) {
                      return buildPost(context, element);
                    }).toList(),
                  ),
          ],
        ));
      },
    );
  }
}
