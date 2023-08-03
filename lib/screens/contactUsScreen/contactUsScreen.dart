import 'package:brocker/screens/contactUsScreen/cubit/cubit.dart';
import 'package:brocker/screens/contactUsScreen/cubit/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../component/components.dart';

class ContactUs extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  var globalkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ContactCubit(),
        child: BlocConsumer<ContactCubit, ContactStats>(
          listener: (context, state) {
            if (state is ContactSuccessState) {
              if (ContactCubit.get(context).contactModel! != null &&
                  ContactCubit.get(context).contactModel!.message != null) {
                showToast(
                    text: ContactCubit.get(context).contactModel!.message!,
                    color: ToastColors.SUCCESS);
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: themAppColor2,
              appBar: AppBar(
                title: Text(
                  "CONTACTUS",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: globalkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: defaultFormField(
                                    controller: nameController,
                                    lable: "Your Name",
                                    type: TextInputType.name,
                                    fillcolor: Colors.black,
                                    inputTextColor: Colors.white,
                                    Isfilled: true,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Your Name must not empty';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Expanded(
                                  child: defaultFormField(
                                    controller: emailController,
                                    lable: "Your Email",
                                    type: TextInputType.emailAddress,
                                    fillcolor: Colors.black,
                                    Isfilled: true,
                                    inputTextColor: Colors.white,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Your Email must not empty';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            defaultFormField(
                              controller: messageController,
                              lable: "Your Message",
                              type: TextInputType.name,
                              fillcolor: Colors.black,
                              maxline: 6,
                              Isfilled: true,
                              inputTextColor: Colors.white,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Your Message must not empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            state is ContactLoadingState
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : button("SEND", () {
                                    if (globalkey.currentState!.validate()) {
                                      ContactCubit.get(context).postData(
                                        name: nameController.text,
                                        email: emailController.text,
                                        message: messageController.text,
                                      );
                                    }
                                  },
                                    h: 45,
                                    w: 100,
                                    color: Colors.blue,
                                    colorborder:
                                        Color.fromARGB(255, 23, 111, 183),
                                    fontsize: 20,
                                    borderradius: 5,
                                    colorText: Colors.white),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "broker, Cairo, Egybt",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.email_rounded,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "broker@gmail.com",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "01100000000",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_filled_outlined,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Sat - Fri 8:00 AM to 5:00 PM",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
