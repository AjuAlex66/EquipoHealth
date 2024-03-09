import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:equipohealth/health/start/firstpage.dart';
import 'package:equipohealth/utils/helper.dart';

class StartingPage extends StatefulWidget {
  const StartingPage({super.key});

  @override
  State<StartingPage> createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding:
            const EdgeInsetsDirectional.symmetric(vertical: 36, horizontal: 36),
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Helper.push(const FirstPage(), ''),
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(
                vertical: 18, horizontal: 18),
            width: Helper.width(),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              "Go",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: HexColor("#f4efe9"),
      body: SingleChildScrollView(
        padding:
            const EdgeInsetsDirectional.symmetric(vertical: 18, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Helper.allowHeight(40),
            Text(
              "Equipo Health",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[350],
                fontWeight: FontWeight.w700,
              ),
            ),
            Helper.allowHeight(5),
            const Text(
              "Hey there 👋,",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
              ),
            ),
            Helper.allowHeight(40),
            const Text(
              "Welcome to the EUIPO Health App! This simple application is seamlessly integrated with Firebase. To ensure we provide the best experience, we kindly request your assistance in completing the following forms. Your input is vital as it enables us to gather necessary data. We are delighted to have you onboard!",
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
