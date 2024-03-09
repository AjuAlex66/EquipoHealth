import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:equipohealth/health/start/sixthpage.dart';
import 'package:equipohealth/utils/helper.dart';
import 'package:equipohealth/utils/initializer.dart';

class FifthPage extends StatefulWidget {
  const FifthPage({super.key});

  @override
  State<FifthPage> createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController one = TextEditingController();
  final TextEditingController two = TextEditingController();
  final TextEditingController three = TextEditingController();
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
              Initializer.dashboardInputModel.mediceName1 = one.text;
              Initializer.dashboardInputModel.mediceName2 = two.text;
              Initializer.dashboardInputModel.mediceName3 = three.text;
              Helper.push(const SixthPage(), "name");
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
                "Name some medicines 💊,",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Helper.allowHeight(40),
              const Text(
                "Just type some medicines names",
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Helper.allowHeight(30),
              const Text(
                "One",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Helper.allowHeight(15),
              TextFormField(
                controller: one,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
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
              Helper.allowHeight(10),
              const Text(
                "Two",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Helper.allowHeight(15),
              TextFormField(
                controller: two,
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
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
              Helper.allowHeight(10),
              const Text(
                "Three",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Helper.allowHeight(15),
              TextFormField(
                controller: three,
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textCapitalization: TextCapitalization.words,
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
              Helper.allowHeight(10),
            ],
          ),
        ),
      ),
    );
  }
}
