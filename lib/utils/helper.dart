import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:equipohealth/main.dart';
import 'package:page_transition/page_transition.dart';

class Helper {
  static showSnack(String? text) {
    ScaffoldMessenger.of(getContext()).hideCurrentSnackBar();
    ScaffoldMessenger.of(getContext()).showSnackBar(
        SnackBar(duration: const Duration(seconds: 5), content: Text(text!)));
  }

  static Future<void> makeADelay({required int delayInMilliseconds}) async {
    return Future.delayed(Duration(milliseconds: delayInMilliseconds));
  }

  static RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static bool validateEmail(String email) {
    // Regular expression for email validation

    // Check if the email matches the regular expression
    return emailRegExp.hasMatch(email);
  }

  static pushReplacementRemove(dynamic namedRoute, String? name) {
    Navigator.of(Helper.getContext()).pushAndRemoveUntil(
        PageTransition(
            type: PageTransitionType.fade, isIos: true, child: namedRoute),
        (Route<dynamic> route) => false);
  }

  static GlobalKey key = NavigationService.navigatorKey;
  static height() {
    return MediaQuery.of(getContext()).size.height;
  }

  static void showLoading() => showDialog(
        barrierColor: Colors.white70,
        barrierDismissible: false,
        context: Helper.getContext(),
        builder: (context) => const CupertinoActivityIndicator(),
      );

  static shrink() {
    return const SizedBox.shrink();
  }

  static setDateFormat({String? format, DateTime? dateTime}) =>
      DateFormat(format ?? "yyyy-MM-dd").format(dateTime ?? DateTime.now());

  static BuildContext getContext() => key.currentContext!;

  static pop() {
    return Navigator.pop(getContext());
  }

  static width() {
    return MediaQuery.of(getContext()).size.width;
  }

  static allowHeight(double height) {
    return SizedBox(height: height);
  }

  static allowWidth(double width) {
    return SizedBox(width: width);
  }

  static showToast({required msg}) {
    Fluttertoast.cancel(); // for immediate stopping
    return Fluttertoast.showToast(msg: msg);
  }

  static showLog(msg) {
    return log('${(msg)} ');
    //- ${DateTime.now().difference(Initializer.logTime!).inHours}h:${DateTime.now().difference(Initializer.logTime!).inMinutes}m ~ ${DateTime.now().difference(Initializer.logTime!).inSeconds}
  }

  static push(dynamic route, String name) {
    return Navigator.push(
      getContext(),
      PageTransition(type: PageTransitionType.fade, child: route),
      // MaterialPageRoute(
      //     settings: RouteSettings(arguments: name),
      //     builder: ((context) => route)),
    );
  }

  static pushReplacement(dynamic route, String? name) {
    return Navigator.pushReplacement(
        getContext(),
        MaterialPageRoute(
            settings: RouteSettings(arguments: name),
            builder: ((context) => route)));
  }
}
