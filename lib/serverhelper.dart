// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:attendanceapp/bloc/authbloc.dart';
// import 'package:attendanceapp/utils/helper.dart';
// import 'package:attendanceapp/utils/preference.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;

// class ServerHelper4466 {
//   static String? ip = 'https://wtiadmin.in';
//   // static String? ip = 'http://192.168.137.1:5050';
//   // static String? ip = 'http://192.168.53.11:5000';
//   // static String? ip = 'http://13.127.36.61';
//   // 251.154
//   //http://13.127.36.61
//   //192.168.137.1
//   static var imageip = '$ip/file/get/'; //
//   static Future<dynamic> uploadFile(
//       file, String? name, Map<String, String> data, dynamic route) async {
//     // try {
//     var token = await Preferene6644.getToken();
//     Map<String, String> headers = {
//       "Content-Type": "application/json",
//       "x-auth-token": token ?? ""
//     };
//     var uri = Uri.parse(ip! + route);
//     http.MultipartFile multipartFile;
//     var request = http.MultipartRequest('POST', uri);
//     // if (!Misc.isNull(file)) {
//     multipartFile = http.MultipartFile.fromBytes(
//         name!, File(file).readAsBytesSync(),
//         filename: File(file).path);
//     request.files.add(multipartFile);
//     // }
//     request.headers.addAll(headers);
//     request.fields.addAll(data);
//     http.Response response =
//         await http.Response.fromStream(await request.send());
//     if (jsonDecode(response.body)['status']) {
//       // log(jsonDecode(response.body).toString());
//       return jsonDecode(response.body);
//     } else {
//       return jsonDecode(response.body);
//     }
//     // } catch (e) {
//     //   log('File upload error: $e');
//     //   return {
//     //     'status': false,
//     //     'msg': 'Invalid Request',
//     //   };
//     // }
//   }

//   static Future<bool> isInternetConnectionGood() async {
//     try {
//       var response = await http.get(
//         Uri.parse('${ServerHelper4466.ip}/health'),
//         headers: {"Content-Type": "application/json", "x-auth-token": ""},
//       );
//       if (response.statusCode == 200) {
//         return true;
//       } else {
//         return false;
//       }

//       // bool trustSelfSigned = true;
//       // HttpClient httpClient = HttpClient()
//       //   ..badCertificateCallback =
//       //       ((X509Certificate cert, String host, int port) => trustSelfSigned);
//       // IOClient ioClient = IOClient(httpClient);

//       // final Stopwatch stopwatch = Stopwatch()..start();
//       // final response = await ioClient
//       //     .get(Uri.parse(ip!))
//       //     .timeout(const Duration(seconds: 10));
//       // stopwatch.stop();
//       // if (response.statusCode == 200) {
//       //   return true;
//       // } else {
//       //   return false;
//       // }
//     } catch (e) {
//       log('checking connection error $e');
//       return false;
//     }
//   }

//   static Future<dynamic> post(String url, Map data) async {
//     var token = await Preferene6644.getToken();
//     log(token ?? "");
//     log('${ip! + url} -- $data');
//     var body = json.encode(data);
//     dynamic response;
//     try {
//       // bool trustSelfSigned = true;
//       // HttpClient httpClient = HttpClient()
//       //   ..badCertificateCallback =
//       //       ((X509Certificate cert, String host, int port) => trustSelfSigned);
//       // IOClient ioClient = IOClient(httpClient);
//       response = await http
//           .post(Uri.parse(ip! + url),
//               headers: {
//                 "Content-Type": "application/json",
//                 "x-auth-token": token ?? ""
//               },
//               body: body)
//           .timeout(const Duration(seconds: 20));

//       if (response.statusCode == 200) {
//         Helper.showLog(response.body);
//         return jsonDecode(response.body);
//         // if (jsonDecode(response.body)['msg']
//         //     .contains("Your session has expired")) {
//         //   // await expireCall.makeExpire();
//         //   return {"status": false, "msg": "expired"};
//         // } else {

//         // }
//       } else {
//         var error = {
//           "status": false,
//           "msg": "${response.statusCode} - ${response.reasonPhrase}"
//         };
//         return error;
//       }
//     } on Exception catch (e) {
//       log(e.toString());
//       // Helper.showToast(msg: e.toString());
//       // throw NoHostException();
//     }
//   }

//   static Future<dynamic> get(String url) async {
//     try {
//       var token = await Preferene6644.getToken();
//       // bool trustSelfSigned = true;
//       // HttpClient httpClient = HttpClient()
//       //   ..badCertificateCallback =
//       //       ((X509Certificate cert, String host, int port) => trustSelfSigned);
//       // IOClient ioClient = IOClient(httpClient);
//       var response = await http.get(
//         Uri.parse(ip! + url),
//         headers: {
//           "Content-Type": "application/json",
//           "x-auth-token": token ?? ""
//         },
//       );
//       log(ip! + url);
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//         // if (jsonDecode(response.body)['msg']
//         //     .contains("Your session has expired")) {
//         //   // await expireCall.makeExpire();
//         //   return {"status": false, "msg": "expired"};
//         // } else {
//         //   return response.body;
//         // }
//       } else {
//         var error = {
//           "status": false,
//           "msg": "${response.statusCode} - ${response.reasonPhrase}"
//         };
//         return error;
//       }
//     } on Exception catch (e) {
//       // Helper.showToast(msg: e.toString());
//       log(e.toString());
//       // throw NoHostException();
//     }
//   }

//   static Future<dynamic> getDownload(String url) async {
//     try {
//       var token = await Preferene6644.getToken();
//       // bool trustSelfSigned = true;
//       // HttpClient httpClient = HttpClient()
//       //   ..badCertificateCallback =
//       //       ((X509Certificate cert, String host, int port) => trustSelfSigned);
//       // IOClient ioClient = IOClient(httpClient);
//       var response = await http.get(
//         Uri.parse(ip! + url),
//         headers: {
//           "Content-Type": "application/json",
//           "x-auth-token": token ?? ""
//         },
//       );
//       log(ip! + url);
//       if (response.statusCode == 200) {
//         return response.bodyBytes;
//       } else {
//         // var error = {
//         //   "status": false,
//         //   "msg": "${response.statusCode} - ${response.reasonPhrase}"
//         // };
//         // return error;
//         return null;
//       }
//     } on Exception catch (e) {
//       // Helper.showToast(msg: e.toString());
//       log(e.toString());
//       // throw NoHostException();
//     }
//   }

//   static authenticateGet(String url) async {
//     try {
//       var token = await Preferene6644.getToken();
//       // bool trustSelfSigned = true;
//       // HttpClient httpClient = HttpClient()
//       //   ..badCertificateCallback =
//       //       ((X509Certificate cert, String host, int port) => trustSelfSigned);
//       // IOClient ioClient = IOClient(httpClient);
//       var response = await http.get(
//         Uri.parse(ip! + '/attendance/authenticate'),
//         headers: {
//           "Content-Type": "application/json",
//           "x-auth-token": token ?? ""
//         },
//       );
//       log(ip! + '/attendance/authenticate');
//       if (response.statusCode == 200) {
//         if (jsonDecode(response.body)['status']) {
//           return get(url);
//         } else {
//           BuildContext context = Helper.getContext();
//           context.read<AuthBloc>().add(DoLogout());
//           var error = {"status": false, "msg": "expired"};
//           return error;
//         }
//       } else {
//         var error = {
//           "status": false,
//           "msg": "${response.statusCode} - ${response.reasonPhrase}"
//         };
//         return error;
//       }
//     } on Exception catch (e) {
//       Helper.showLog("AuthenticationError $e");
//     }
//   }

//   static authenticatePost(String url, Map<dynamic, dynamic> data) async {
//     try {
//       var token = await Preferene6644.getToken();
//       // bool trustSelfSigned = true;
//       // HttpClient httpClient = HttpClient()
//       //   ..badCertificateCallback =
//       //       ((X509Certificate cert, String host, int port) => trustSelfSigned);
//       // IOClient ioClient = IOClient(httpClient);
//       var response = await http.get(
//         Uri.parse(ip! + '/attendance/authenticate'),
//         headers: {
//           "Content-Type": "application/json",
//           "x-auth-token": token ?? ""
//         },
//       );
//       log(ip! + url);
//       if (response.statusCode == 200) {
//         if (jsonDecode(response.body)['status']) {
//           return post(url, data);
//         } else {
//           BuildContext context = Helper.getContext();
//           context.read<AuthBloc>().add(DoLogout());
//           var error = {"status": false, "msg": "expired"};
//           return error;
//         }
//       } else {
//         var error = {
//           "status": false,
//           "msg": "${response.statusCode} - ${response.reasonPhrase}"
//         };
//         return error;
//       }
//     } on Exception catch (e) {
//       Helper.showLog("AuthenticationError $e");
//     }
//   }

//   // static uploadMulipleFilesWithStream(dynamic route, List<PlatformFile> files,
//   //     String? name, Map<String, String>? data) async {
//   //   var token = await LocalStorage.getToken();
//   //   Map<String, String> headers = {
//   //     "Content-Type": "application/json",
//   //     "token": token ?? ""
//   //   };
//   //   var uri = Uri.parse(ip! + route);
//   //   http.MultipartFile multipartFile;
//   // }

//   // static uploadMulipleFiles(dynamic route, List<PlatformFile> files,
//   //     String? name, Map<String, String>? data) async {
//   //   try {
//   //     var token = await LocalStorage.getToken();
//   //     Map<String, String> headers = {
//   //       "Content-Type": "application/json",
//   //       "token": token ?? ""
//   //     };
//   //     var uri = Uri.parse(ip! + route);
//   //     http.MultipartFile multipartFile;
//   //     var request = http.MultipartRequest('POST', uri);
//   //     // if (!Misc.isNull(file)) {
//   //     for (var e in files) {
//   //       multipartFile = http.MultipartFile.fromBytes(
//   //           name!, File(e.path!).readAsBytesSync(),
//   //           filename: File(e.path!).path);
//   //       request.files.add(multipartFile);
//   //       // }
//   //       request.headers.addAll(headers);
//   //     }
//   //     request.fields.addAll(data!);
//   //     http.Response response =
//   //         await http.Response.fromStream(await request.send());
//   //     if (jsonDecode(response.body)['status']) {
//   //       return jsonDecode(response.body);
//   //     } else {
//   //       return jsonDecode(response.body);
//   //     }
//   //   } catch (e) {
//   //     log('File upload error: $e');
//   //     return {
//   //       'status': false,
//   //       'msg': 'Invalid Request',
//   //     };
//   //   }
//   // }
// }

//     // static uploadMultipleFiles(
//     //     List<FilesModel> files, String route, Map<String, String> data) async {
//     //   // try {
//     //   var token = await LocalStorage.getToken();
//     //   Map<String, String> headers = {
//     //     "Content-Type": "application/json",
//     //     "token": token ?? ""
//     //   };
//     //   var uri = Uri.parse(ip + route);
//     //   http.MultipartFile multipartFile;
//     //   var request = http.MultipartRequest('POST', uri);
//     //   for (var e in files) {
//     //     if (!Misc.isNull(e.path)) {
//     //       multipartFile = http.MultipartFile.fromBytes(
//     //           e.name!, File(e.path!).readAsBytesSync(),
//     //           filename: e.path!.split('/').last);
//     //       request.files.add(multipartFile);
//     //     }
//     //   }

//     //   request.headers.addAll(headers);
//     //   request.fields.addAll(data);
//     //   http.Response response =
//     //       await http.Response.fromStream(await request.send());
//     //   if (jsonDecode(response.body)['status']) {
//     //     log(jsonDecode(response.body).toString());
//     //     return jsonDecode(response.body);
//     //   } else {
//     //     return jsonDecode(response.body);
//     //   }
//     //   // } catch (e) {
//     //   //   log('File upload error: $e');
//     //   //   return {
//     //   //     'status': false,
//     //   //     'msg': 'Invalid Request',
//     //   //   };
//     //   // }
//     // }
