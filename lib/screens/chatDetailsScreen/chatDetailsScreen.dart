import 'package:brocker/appCubite/cubit.dart';
import 'package:brocker/appCubite/stats.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../component/components.dart';

import '../../models/getChatsModel.dart';

class ChatDetails extends StatelessWidget {
  final GetChatsModel? chat;

  TextEditingController messageController = TextEditingController();

  ChatDetails({super.key, this.chat});
  ScrollController scrollController = ScrollController();

  scrollToBottom() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());
    return Builder(
      builder: (context) {
        AppCubit.get(context).GetMessage(ChatId: chat!.id!);

        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  elevation: 8,
                  titleSpacing: 0,
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                      onPressed: () {
                        AppCubit.get(context).getChats();
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: chat!.secondUser!.userType == "admin"
                            ? AssetImage("assets/images/admin.png")
                            : AssetImage("assets/images/profileImg.png"),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        AppCubit.get(context).getUserModel!.fullname ==
                                chat!.secondUser!.fullname!
                            ? chat!.firstUser!.fullname!
                            : chat!.secondUser!.fullname!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                        child: AppCubit.get(context).ListMessage != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: ListView.separated(
                                  // reverse: true,
                                  controller: scrollController,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    if (AppCubit.get(context)
                                            .ListMessage![index]
                                            .sender ==
                                        AppCubit.get(context)
                                            .getUserModel!
                                            .id) {
                                      return buildMyMessage(
                                          context,
                                          AppCubit.get(context)
                                              .ListMessage![index]);
                                    }
                                    return buildMessage(
                                        context,
                                        AppCubit.get(context)
                                            .ListMessage![index]);
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 20,
                                  ),
                                  itemCount: chat!.messages!.length,
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type your messege here",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: themAppColor1,
                            child: IconButton(
                              onPressed: () {
                                AppCubit.get(context).sendMessage(
                                  message: messageController.text,
                                  chat: chat!,
                                  chatId: chat!.id!,
                                  otherUserId: chat!.secondUser!.id!,
                                );
                                messageController.text = '';
                                WidgetsBinding.instance.addPostFrameCallback(
                                    (_) => scrollToBottom());
                              },
                              icon: Icon(
                                Icons.send,
                                color: themAppColorIcon,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ));
          },
        );
      },
    );
  }

  buildMessage(BuildContext context, MessageModel message) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Container(
        margin: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * .3, left: 15),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(17),
            bottomRight: Radius.circular(17),
            topRight: Radius.circular(17),
          ),
        ),
        child: Text(
          message.text!,
          style: TextStyle(overflow: TextOverflow.fade),
        ),
      ),
    );
  }

  buildMyMessage(BuildContext context, MessageModel message) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Container(
        margin: EdgeInsets.only(
            right: 15, left: MediaQuery.of(context).size.width * .3),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: themAppColor1,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(17),
            topLeft: Radius.circular(17),
            bottomRight: Radius.circular(17),
          ),
        ),
        child: Text(
          message.text!,
          style: TextStyle(overflow: TextOverflow.fade),
        ),
      ),
    );
  }
}
