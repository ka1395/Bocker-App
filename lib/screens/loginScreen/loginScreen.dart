import 'package:brocker/appCubite/cubit.dart';
import 'package:brocker/screens/loginScreen/cubit/cubit.dart';
import 'package:brocker/screens/loginScreen/cubit/stats.dart';
import 'package:brocker/screens/registerScreen/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Network/remote/webSocket.dart';
import '../../appCubite/stats.dart';
import '../../component/components.dart';
import '../contactUsScreen/contactUsScreen.dart';
import '../layoutScreen/HomeLayoutScreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController UserNameController = TextEditingController();
    var globalkey = GlobalKey<FormState>();

    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (LoginCubit.get(context).loginModel! != null &&
              LoginCubit.get(context).loginModel!.error == null) {
            showToast(
                text: LoginCubit.get(context).loginModel!.message,
                color: ToastColors.SUCCESS);

            AppCubit.get(context)..getUserData();
            AppCubit.get(context)..getPostData();

            AppCubit.get(context)..getFavoritiesData();

            AppCubit.get(context)..getChats();
  WebSocketHelper.initWebSocket();

            navigateTo(context, HomeLayoutScreen());
          } else {
            showToast(
                text: LoginCubit.get(context).loginModel!.message.field +
                    ' ' +
                    LoginCubit.get(context).loginModel!.message.reason,
                color: ToastColors.ERROR);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                Icon(
                  Icons.home_outlined,
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
              TextButton(
                  onPressed: () {
                    navigateTo(context, ContactUs());
                  },
                  child: Text(
                    "CONTACTUS",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ))
            ],
          ),
          body: Container(
            color: themAppColor2,
            child: Center(
              child: Container(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: globalkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("LOGIN",
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            controller: UserNameController,
                            type: TextInputType.name,
                            inputTextColor: Colors.white,
                            Isfilled: true,
                            fillcolor: Color.fromRGBO(31, 32, 41, .9),
                            prefx: Icons.person,
                            iconColor: Color.fromRGBO(255, 235, 167, 1),
                            textColor: Colors.grey,
                            hint: "User Name",
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Your User Name must not empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            inputTextColor: Colors.white,
                            controller: passwordController,
                            type: TextInputType.name,
                            Isfilled: true,
                            fillcolor: Color.fromRGBO(31, 32, 41, .9),
                            prefx: Icons.lock_outline_rounded,
                            iconColor: Color.fromRGBO(255, 235, 167, 1),
                            textColor: Colors.grey,
                            hint: "Your Password",
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'password must not empty';
                              }
                              return null;
                            },
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: state is LoginLoadingState
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : button("SUBMIT", () {
                                      if (globalkey.currentState!.validate()) {
                                        LoginCubit.get(context).postData(
                                            userName: UserNameController.text,
                                            password: passwordController.text);
                                      }
                                    },
                                      h: 50,
                                      w: 100,
                                      color: Color.fromRGBO(255, 235, 167, 1),
                                      colorborder:
                                          Color.fromRGBO(255, 235, 167, 1),
                                      colorText: Color.fromRGBO(16, 39, 112, 1),
                                      borderradius: 5,
                                      fontsize: 15),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? "),
                              TextButton(
                                  onPressed: () {
                                    navigateTo(context, RegisterScreen());
                                  },
                                  child: Text(
                                    "REGISTER",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.white),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
