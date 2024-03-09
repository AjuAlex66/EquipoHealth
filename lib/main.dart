import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:equipohealth/health/bloc/healthbloc.dart';
import 'package:equipohealth/health/healthhome/auth/healthlogin.dart';
import 'package:equipohealth/health/healthhome/healthhome.dart';
import 'package:equipohealth/offlinenotes/bloc/mainbloc.dart';
import 'package:equipohealth/firebase_options.dart';
import 'package:equipohealth/offlinenotes/home/homepage.dart';
import 'package:equipohealth/offlinenotes/home/loginscreen.dart';
import 'package:equipohealth/utils/changer.dart';
import 'package:equipohealth/utils/helper.dart';
import 'package:equipohealth/utils/initializer.dart';
import 'package:equipohealth/utils/localstorage.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // var deviceId = ['BC89BF38193DAFC816151EF7D1615FEB'];
  // MobileAds.instance.initialize();
  // RequestConfiguration requestConfiguration =
  //     RequestConfiguration(testDeviceIds: deviceId);
  // MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  // await DatabaseHelper.openDB();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);

  // final todoref = FirebaseFirestore.instance.collection('rapidtodo');
  // Helper.showLog(todoref);
  dynamic page = await decidePage();
  FlutterNativeSplash.remove();
  runApp(MyApp(page: page));
}

dynamic decidePage() async {
  var userId = await LocalStorage.getUserId();
  if (userId != null) {
    Helper.showLog(userId);
    Initializer.userId = userId;
    return const HealthHome();
  } else {
    return const HealthLoginPage();
  }
}

class MyApp extends StatelessWidget {
  final dynamic page;
  const MyApp({super.key, required this.page});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Changer(),
      child: MultiBlocProvider(
        providers: [
          //HealthBloc
          BlocProvider<HealthBloc>(
            create: (context) => HealthBloc(),
          ),
          BlocProvider<MainBloc>(
            create: (context) => MainBloc(),
          )
        ],
        child: SafeArea(
          child: MaterialApp(
              navigatorKey: NavigationService.navigatorKey,
              debugShowCheckedModeBanner: false,
              title: 'Key Away',
              theme: ThemeData(
                scaffoldBackgroundColor: HexColor("#f4efe9"),
                appBarTheme: const AppBarTheme(
                    color: Colors.transparent,
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                    iconTheme: IconThemeData(color: Colors.black)),
                primaryColor: Colors.green[400],
                primaryColorDark: Colors.green[600],
                fontFamily: 'Ubuntu',
                useMaterial3: false,
              ),
              // home: const MyHomePage(title: 'SimpleLog'),
              home: page),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // checkThenPush();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text(
        "Simple Log",
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w500,
        ),
      ),
    ));
  }

  void pushAfter3(dynamic route, String name) async =>
      await Future.delayed(const Duration(seconds: 2))
          .then((value) => Helper.pushReplacement(route, name));

  Future<void> checkThenPush() async {
    Initializer.userId = await LocalStorage.getUserId();
    if (Initializer.userId!.isNotEmpty) {
      pushAfter3(const HomePage(), 'home');
    } else {
      pushAfter3(const LoginScreen(), 'login');
    }
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
