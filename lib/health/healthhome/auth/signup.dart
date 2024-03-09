import 'package:equipohealth/health/bloc/healthbloc.dart';
import 'package:equipohealth/health/healthhome/auth/healthlogin.dart';
import 'package:equipohealth/utils/changer.dart';
import 'package:equipohealth/utils/helper.dart';
import 'package:equipohealth/utils/initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HealthSignup extends StatefulWidget {
  const HealthSignup({super.key});

  @override
  State<HealthSignup> createState() => _HealthSignupState();
}

class _HealthSignupState extends State<HealthSignup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HealthBloc, HealthState>(
        listener: (context, state) {
          if (state is UserRegistered) {
            Helper.pushReplacement(const HealthLoginPage(), '');
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.symmetric(
              vertical: 18, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
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
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Helper.allowHeight(60),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Helper.allowHeight(10),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    Helper.allowHeight(15),
                    const Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Helper.allowHeight(10),
                    TextFormField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field is required";
                        } else if (!Initializer.emailRegExp.hasMatch(value)) {
                          return "Invalid Email Address";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        filled: true,
                      ),
                    ),
                    Helper.allowHeight(15),
                    const Text(
                      "Gender",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Helper.allowHeight(5),
                    Consumer<Changer>(
                      builder: (context, value, child) => Row(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                shape: const CircleBorder(),
                                value: Initializer.genderMale,
                                onChanged: (value) {
                                  Initializer.genderMale =
                                      Initializer.genderMale! ? false : true;
                                  context.read<Changer>().justChange();
                                },
                              ),
                              Text(
                                "Male",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[350],
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Helper.allowWidth(10),
                          Row(
                            children: [
                              Checkbox(
                                shape: const CircleBorder(),
                                value: !Initializer.genderMale!,
                                onChanged: (value) {
                                  Initializer.genderMale =
                                      Initializer.genderMale! ? false : true;
                                  context.read<Changer>().justChange();
                                },
                              ),
                              Text(
                                "Female",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[350],
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Helper.allowHeight(15),
                    const Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Helper.allowHeight(15),
                    Consumer<Changer>(
                      builder: (context, value, child) => TextFormField(
                        obscureText: Initializer.openEye!,
                        textInputAction: TextInputAction.done,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              Initializer.openEye = Initializer.openEye!
                                  ? Initializer.openEye = false
                                  : Initializer.openEye = true;
                              context.read<Changer>().justChange();
                            },
                            child: Icon(
                              Icons.remove_red_eye,
                              color: Initializer.openEye!
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(),
                          filled: true,
                        ),
                      ),
                    ),
                    Helper.allowHeight(30),
                    SizedBox(
                      width: Helper.width(),
                      height: Helper.height() / 16,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.blue[300],
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<HealthBloc>().add(DoRegister(data: {
                                  "name": nameController.text,
                                  "email": emailController.text,
                                  "password": passwordController.text,
                                  "gender": Initializer.genderMale
                                }));
                          }
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Helper.allowHeight(20),
                    InkWell(
                      onTap: () =>
                          Helper.pushReplacement(const HealthLoginPage(), ''),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Already Registered? Login",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
