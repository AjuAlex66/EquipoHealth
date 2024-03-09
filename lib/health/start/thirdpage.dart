import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:equipohealth/health/start/fourthpage.dart';
import 'package:equipohealth/utils/helper.dart';
import 'package:equipohealth/utils/initializer.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController calorieRate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding:
            const EdgeInsetsDirectional.symmetric(vertical: 36, horizontal: 36),
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              Initializer.dashboardInputModel.calorieRate =
                  int.parse(calorieRate.text);
              Helper.push(const FourthPage(), "name");
            }
          },
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(
                vertical: 18, horizontal: 18),
            width: Helper.width(),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              "Next",
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
        child: Form(
          key: _formKey,
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
                "What's about calories 💪,",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Helper.allowHeight(40),
              const Text(
                "Just type some random numbers",
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Helper.allowHeight(30),
              const Text(
                "Calorie Rate",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Helper.allowHeight(15),
              TextFormField(
                controller: calorieRate,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  filled: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
