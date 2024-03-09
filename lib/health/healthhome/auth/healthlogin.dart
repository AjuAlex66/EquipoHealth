import 'package:equipohealth/health/bloc/healthbloc.dart';
import 'package:equipohealth/health/healthhome/auth/signup.dart';
import 'package:equipohealth/health/healthhome/healthhome.dart';
import 'package:equipohealth/utils/changer.dart';
import 'package:equipohealth/utils/helper.dart';
import 'package:equipohealth/utils/initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HealthLoginPage extends StatefulWidget {
  const HealthLoginPage({super.key});

  @override
  State<HealthLoginPage> createState() => _HealthLoginPageState();
}

class _HealthLoginPageState extends State<HealthLoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HealthBloc, HealthState>(
        listener: (context, state) {
          if (state is LoggingSuccess) {
            Helper.pushReplacement(const HealthHome(), '');
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
                        "Login",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
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
                      "Email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Helper.allowHeight(10),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
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
                      "Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Helper.allowHeight(10),
                    Consumer<Changer>(
                      builder: (context, value, child) => TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        obscureText: Initializer.openEye!,
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
                            context.read<HealthBloc>().add(DoLogin(data: {
                                  "email": emailController.text,
                                  "password": passwordController.text,
                                }));
                          }
                        },
                        child: const Text(
                          "Login",
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
                          Helper.pushReplacement(const HealthSignup(), ''),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? Register",
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
