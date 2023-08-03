import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

ThemeData themeData = ThemeData(
    // ignore: prefer_const_constructors
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 22,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontSize: 18,
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade400,
        fontSize: 12,
      ),
      // headline1: const TextStyle(
      //   fontWeight: FontWeight.w600,
      //   color: Colors.white,
      //   fontSize: 20,
      // ),
      // headline2: const TextStyle(
      //   color: Colors.white,
      //   fontSize: 17,
      // ),
    ),
    primarySwatch: Colors.grey,
    iconTheme: IconThemeData(
      color: themAppColorIcon,
      size: 25,
    ),
    appBarTheme: AppBarTheme(
      color: themAppColor1,
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 25,
      ),
      toolbarHeight: 80,
    ));

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmite,
  Function(String)? onChange,
  int? maxline = 1,
  VoidCallback? onTap,
  bool isPassword = false,
  validate,
  String? lable,
  IconData? prefx,
  IconData? suffix,
  VoidCallback? suffixPassword,
  Color? fillcolor,
  bool? Isfilled,
  double borderradius = 4.0,
  String hint = " ",
  Color? iconColor = Colors.black,
  Color? inputTextColor = Colors.black,
  Color? textColor = Colors.black,
  Color? lableColor = Colors.white,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onTap: onTap,
      onChanged: onChange,
      onFieldSubmitted: onSubmite,
      validator: validate,
      maxLines: maxline,
      style: TextStyle(color: inputTextColor),
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: textColor),
          fillColor: fillcolor,
          filled: Isfilled,
          labelText: lable,
          labelStyle: TextStyle(color: lableColor),
          prefixIcon: prefx == null
              ? null
              : Icon(
                  prefx,
                  color: iconColor,
                ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixPassword,
                  icon: Icon(suffix),
                )
              : null,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderradius)))),
    );

Widget button(
  String text,
  var fun, {
  required double h,
  required double w,
  required Color color,
  required Color colorborder,
  required Color colorText,
  required double borderradius,
  required double fontsize,
}) =>
    MaterialButton(
        height: h,
        minWidth: w,
        color: color,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: colorborder),
            borderRadius: BorderRadius.circular(borderradius)),
        onPressed: fun,
        child: Text(
          text,
          style: TextStyle(
            color: colorText,
            fontSize: fontsize,
          ),
        ));

navigateTo(BuildContext context, Widget page) => Navigator.push(
    context,
    PageTransition(
        child: page,
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: 500),
        reverseDuration: Duration(milliseconds: 500)));

navigateToWithRemplace(BuildContext context, Widget page) =>
    Navigator.pushReplacement(
        context,
        PageTransition(
            child: page,
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 500),
            reverseDuration: Duration(milliseconds: 500)));

Color themAppColor1 = Colors.black.withOpacity(.8);
Color? themAppColor2 = Colors.grey[700];
Color themAppColorIcon = Colors.white;

void showToast({
  required String text,
  required ToastColors color,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: setToastColor(color),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastColors {
  SUCCESS,
  ERROR,
  WARNING,
}

Color setToastColor(ToastColors color) {
  Color c;

  switch (color) {
    case ToastColors.ERROR:
      c = Colors.red;
      break;
    case ToastColors.SUCCESS:
      c = Colors.green;
      break;
    case ToastColors.WARNING:
      c = Colors.amber;
      break;
  }

  return c;
}
