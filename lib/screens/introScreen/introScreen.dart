import 'package:brocker/appCubite/cubit.dart';
import 'package:brocker/appCubite/stats.dart';
import 'package:brocker/screens/loginScreen/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../component/components.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  double h = 20;
  late Animation animation;
  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1500),
        upperBound: 1,
        lowerBound: .4);
    controller.reverse(from: 70);
    animation =
        CurvedAnimation(curve: Curves.easeInOutBack, parent: controller);
    controller.addListener(() {
      setState(() {
        if (animation.value == 0.1419594287872315) h = 50;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 94, 212, 233),
          body: Center(
              child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "WELCOME IN",
                  style: TextStyle(
                      letterSpacing: animation.value * 15,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                animation.value == 0.1419594287872315
                    ? Text("BROKER WEBSITE WE CAN HELP YOU",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold))
                    : Container(),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    child: Text(
                      'HOME PAGE',
                      style: TextStyle(
                        letterSpacing: animation.value * 15,
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 94, 212, 233)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          side: BorderSide(width: 2),
                        ))),
                    onPressed: () {
                      navigateToWithRemplace(context, LoginScreen());
                    })
              ],
            ),
          )),
        );
      },
    );
  }
}
