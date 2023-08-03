import 'package:brocker/appCubite/cubit.dart';
import 'package:brocker/appCubite/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../component/components.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailrController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController nationalIdController = TextEditingController();

    var globalkey = GlobalKey<FormState>();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is PutUserDataSuccessStats) {
          
          showToast(text: "New data was saved successfully!", color: ToastColors.SUCCESS);
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        nameController.text = cubit.getUserModel!.fullname!;
        usernameController.text = cubit.getUserModel!.username!;
        emailrController.text = cubit.getUserModel!.email!;
        ageController.text = cubit.getUserModel!.age!;
        nationalIdController.text = cubit.getUserModel!.nationalId!;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Setting",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: globalkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is PutUserDataLoadingStats)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      inputTextColor: Colors.black,
                      lableColor: Colors.black,
                      lable: "Full Name",
                      prefx: Icons.person,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter Your Full Name";
                        }
                      },
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      controller: usernameController,
                      type: TextInputType.name,
                      inputTextColor: Colors.black,
                      lableColor: Colors.black,
                      lable: "User Name",
                      prefx: Icons.person,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter Your User Name";
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      controller: emailrController,
                      type: TextInputType.name,
                      inputTextColor: Colors.black,
                      lableColor: Colors.black,
                      lable: "Email",
                      prefx: Icons.email,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter Your Email";
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      controller: ageController,
                      type: TextInputType.number,
                      inputTextColor: Colors.black,
                      lableColor: Colors.black,
                      lable: "Age",
                      prefx: Icons.date_range_rounded,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter Your Age";
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      controller: nationalIdController,
                      type: TextInputType.number,
                      inputTextColor: Colors.black,
                      lableColor: Colors.black,
                      lable: "National Id",
                      prefx: Icons.date_range_rounded,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter Your National Id";
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    button("UPDATET", () {
                      if (globalkey.currentState!.validate()) {
                        cubit.putUserData(
                          name: nameController.text,
                          username: usernameController.text,
                          age: ageController.text,
                          email: emailrController.text,
                          nationalId: nationalIdController.text,
                        );
                      }
                    },
                        h: 50,
                        w: double.infinity,
                        borderradius: 3,
                        color: themAppColor1,
                        colorText: Colors.white,
                        colorborder: themAppColor1,
                        fontsize: 20),

                    SizedBox(
                      height: 15,
                    ),
                    // defaultButton(
                    //     function: () {
                    //       if (globalkey.currentState!.validate()) {
                    //         cubit.logOut(context);
                    //       }
                    //     },
                    //     text: "LOGOUT"),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
