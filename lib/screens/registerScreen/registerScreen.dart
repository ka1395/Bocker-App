import 'package:brocker/screens/registerScreen/cubite/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../component/components.dart';
import '../layoutScreen/HomeLayoutScreen.dart';
import 'cubite/cubite.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController nameRegisteController = TextEditingController();
  TextEditingController usernameRegisteController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  TextEditingController emailRegisterController = TextEditingController();
  TextEditingController passwordRegisterController = TextEditingController();
  TextEditingController ConfirmPasswordRegisterController =
      TextEditingController();

  TextEditingController ageController = TextEditingController();
  var globalkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStats>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (RegisterCubit.get(context).registerModel! != null &&
                RegisterCubit.get(context).registerModel!.error == null) {
              print("register success");
              showToast(
                  text: RegisterCubit.get(context).registerModel!.message,
                  color: ToastColors.SUCCESS);
            } else {
              showToast(
                  text: RegisterCubit.get(context)
                          .registerModel!
                          .message
                          .field +
                      ' ' +
                      RegisterCubit.get(context).registerModel!.message.reason,
                  color: ToastColors.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Container(
              color: themAppColor2,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: globalkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("REGISTER",
                              style: TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            inputTextColor: Colors.white,
                            controller: nameRegisteController,
                            type: TextInputType.name,
                            Isfilled: true,
                            fillcolor: Color.fromRGBO(31, 32, 41, .9),
                            prefx: Icons.person_outline_rounded,
                            iconColor: Color.fromRGBO(255, 235, 167, 1),
                            textColor: Colors.grey,
                            hint: "Your Full Name",
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Your Full Name must not empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            inputTextColor: Colors.white,
                            controller: usernameRegisteController,
                            type: TextInputType.name,
                            Isfilled: true,
                            fillcolor: Color.fromRGBO(31, 32, 41, .9),
                            prefx: Icons.person_outline_rounded,
                            iconColor: Color.fromRGBO(255, 235, 167, 1),
                            textColor: Colors.grey,
                            hint: "Your user Name",
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Your user Name must not empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            inputTextColor: Colors.white,
                            controller: ageController,
                            type: TextInputType.number,
                            Isfilled: true,
                            fillcolor: Color.fromRGBO(31, 32, 41, .9),
                            prefx: Icons.date_range_outlined,
                            iconColor: Color.fromRGBO(255, 235, 167, 1),
                            textColor: Colors.grey,
                            hint: "Your Age",
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Age must not empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            inputTextColor: Colors.white,
                            controller: nationalIdController,
                            type: TextInputType.number,
                            Isfilled: true,
                            fillcolor: Color.fromRGBO(31, 32, 41, .9),
                            prefx: Icons.numbers,
                            iconColor: Color.fromRGBO(255, 235, 167, 1),
                            textColor: Colors.grey,
                            hint: "Your NationalId",
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'NationalId must not empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            inputTextColor: Colors.white,
                            controller: emailRegisterController,
                            type: TextInputType.name,
                            Isfilled: true,
                            fillcolor: Color.fromRGBO(31, 32, 41, .9),
                            prefx: Icons.email,
                            iconColor: Color.fromRGBO(255, 235, 167, 1),
                            textColor: Colors.grey,
                            hint: "Your Email",
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Your Email must not empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            controller: passwordRegisterController,
                            type: TextInputType.visiblePassword,
                            Isfilled: true,
                            fillcolor: Color.fromRGBO(31, 32, 41, .9),
                            prefx: Icons.lock_open,
                            iconColor: Color.fromRGBO(255, 235, 167, 1),
                            textColor: Colors.grey,
                            hint: "Your password",
                            inputTextColor: Colors.white,
                            isPassword:
                                RegisterCubit.get(context).isVisibalPassword,
                            suffix:
                                RegisterCubit.get(context).iconStatePassword,
                            suffixPassword: () {
                              RegisterCubit.get(context)
                                  .changeVisibalPassword();
                            },
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Your password must not empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                              controller: ConfirmPasswordRegisterController,
                              type: TextInputType.visiblePassword,
                              Isfilled: true,
                              fillcolor: Color.fromRGBO(31, 32, 41, .9),
                              prefx: Icons.lock_open_outlined,
                              iconColor: Color.fromRGBO(255, 235, 167, 1),
                              textColor: Colors.grey,
                              hint: "Confirm Your password",
                              inputTextColor: Colors.white,
                              isPassword: RegisterCubit.get(context)
                                  .isVisibalPasswordConfirem,
                              suffix: RegisterCubit.get(context)
                                  .iconStatePasswordConfirem,
                              suffixPassword: () {
                                RegisterCubit.get(context)
                                    .changeVisibalPasswordConfirem();
                              },
                              validate: (String? value) {
                                if (value != passwordRegisterController.text ||
                                    value!.isEmpty) {
                                  return "password wrong";
                                }
                                return null;
                              }),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: state is RegisterLoadingState
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Center(
                                    child: button("SUBMIT", () {
                                      if (globalkey.currentState!.validate()) {
                                        RegisterCubit.get(context).postData(
                                            fullname:
                                                nameRegisteController.text,
                                            age: int.parse(ageController.text),
                                            nationalId:
                                                nationalIdController.text,
                                            username:
                                                usernameRegisteController.text,
                                            password:
                                                passwordRegisterController.text,
                                            confirmPassword:
                                                ConfirmPasswordRegisterController
                                                    .text,
                                            email:
                                                emailRegisterController.text);
                                      }
                                    },
                                        h: 50,
                                        w: 100,
                                        color: Color.fromRGBO(255, 235, 167, 1),
                                        colorborder:
                                            Color.fromRGBO(255, 235, 167, 1),
                                        colorText:
                                            Color.fromRGBO(16, 39, 112, 1),
                                        borderradius: 5,
                                        fontsize: 15),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
