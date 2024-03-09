import 'package:equipohealth/health/bloc/healthbloc.dart';
import 'package:equipohealth/health/healthhome/healthhome.dart';
import 'package:equipohealth/utils/helper.dart';
import 'package:equipohealth/utils/initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class SixthPage extends StatefulWidget {
  const SixthPage({super.key});

  @override
  State<SixthPage> createState() => _SixthPageState();
}

class _SixthPageState extends State<SixthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController doctorName = TextEditingController();
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
              Initializer.dashboardInputModel.doctorName = doctorName.text;
              context.read<HealthBloc>().add(UpdateDashboard());
            }
          },
          // onTap: () => Helper.push(const SixthPage(), "name"),
          child: BlocListener<HealthBloc, HealthState>(
            listener: (context, state) {
              if (state is DashBoardUpdated) {
                Helper.pushReplacementRemove(const HealthHome(), '');
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
                "Name a doctor 👩‍⚕️,",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Helper.allowHeight(40),
              const Text(
                "So you can consult with them very next day",
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Helper.allowHeight(30),
              const Text(
                "Doctor Name",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Helper.allowHeight(15),
              TextFormField(
                controller: doctorName,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
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
            ],
          ),
        ),
      ),
    );
  }
}
