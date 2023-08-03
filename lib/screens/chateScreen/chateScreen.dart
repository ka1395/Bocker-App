import 'package:brocker/appCubite/cubit.dart';
import 'package:brocker/appCubite/stats.dart';
import 'package:brocker/component/components.dart';
import 'package:brocker/screens/chatDetailsScreen/chatDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/getChatsModel.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetChatsSuccessStats) {
          return AppCubit.get(context).chats.length == 0
              ? Center(child: Text("NO Chats Yet"))
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return chatUsers(
                        context, AppCubit.get(context).chats[index]);
                  },
                  itemCount: AppCubit.get(context).chats.length,
                  separatorBuilder: (context, index) => Divider(),
                );
        } else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }

  chatUsers(BuildContext context, GetChatsModel chat) => InkWell(
        onTap: () {
          // navigateTo(
          //     context,
          //     ChatDetails(
          //       userModel: user,
          //     ));
          navigateTo(
              context,
              ChatDetails(
                chat: chat,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: chat.secondUser!.fullname ==
                        AppCubit.get(context).getUserModel!.fullname
                    ? chat.firstUser!.userType == "admin"
                        ? AssetImage("assets/images/admin.png")
                        : AssetImage("assets/images/profileImg.png")
                    : chat.secondUser!.userType == "admin"
                        ? AssetImage("assets/images/admin.png")
                        : AssetImage("assets/images/profileImg.png"),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${chat.secondUser!.fullname == AppCubit.get(context).getUserModel!.fullname ? chat.firstUser!.fullname : chat.secondUser!.fullname}",
                          style: Theme.of(context).textTheme.bodyLarge!,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    chat.messages!.length != 0
                        ? Text(
                            "${chat.messages![chat.messages!.length - 1].text}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.grey),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

// {
//     "otherUserId": "63b19fe53da24645c4e3f042",
//     "chatId": "63b2eb2bc49193151b18b81a",
//     "message": "How are you my friend?"
// }