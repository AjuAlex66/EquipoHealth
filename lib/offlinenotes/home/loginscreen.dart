import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:equipohealth/offlinenotes/bloc/mainbloc.dart';
import 'package:equipohealth/offlinenotes/home/homepage.dart';
import 'package:equipohealth/utils/helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth? authX;
  bool isUserSignedIn = false;
  @override
  void initState() {
    super.initState();
    initApp();
  }

  void initApp() async {
    FirebaseApp defaultApp = await Firebase.initializeApp();
    authX = FirebaseAuth.instanceFor(app: defaultApp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      extendBodyBehindAppBar: false,
      body: BlocListener<MainBloc, MainState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Helper.pushReplacement(const HomePage(), 'home');
          }
        },
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                SizedBox(
                    height: Helper.height() / 2,
                    child: const Center(child: Text('Authenticate Yourself'))),
                Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                      controller: emailController,
                    ),
                    Helper.allowHeight(10),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                      controller: passController,
                    ),
                    Helper.allowHeight(15),
                    SizedBox(
                      width: Helper.width(),
                      child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.purple[200])),
                          onPressed: () async => context.read<MainBloc>().add(
                              DoSignup(
                                  email: emailController.text,
                                  pass: passController.text)),
                          child: const Text(
                            'Signup',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    Helper.allowHeight(5),
                    SizedBox(
                      width: Helper.width(),
                      child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.purple[200])),
                          onPressed: () async => context.read<MainBloc>().add(
                              DoLogin(
                                  email: emailController.text,
                                  pass: passController.text)),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void checkIfUserIsSignedIn() {}

  // onGoogleSignIn(BuildContext context) async {
  //   User user = await _handleSignIn();
  //   Helper.showLog(user);
  // }

  // _handleSignIn() async {
  //   User user;
  //   // flag to check whether we're signed in already
  //   bool isSignedIn = await googleSignIn.isSignedIn();
  //   if (isSignedIn) {
  //     // if so, return the current user
  //     user = authX!.currentUser!;
  //   } else {
  //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser!.authentication;
  //     // get the credentials to (access / id token)
  //     // to sign in via Firebase Authentication
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
  //     user = (await authX!.signInWithCredential(credential)).user!;
  //     // userSignedIn = await _googleSignIn.isSignedIn();
  //     // setState(() {
  //     //    isUserSignedIn = userSignedIn;
  //     // });
  //   }

  //   return user;
  // }
}
