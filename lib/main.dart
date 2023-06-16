// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:chat_app_flutter_firestore/ChatSelectorScreen.dart';
import 'package:chat_app_flutter_firestore/SplashScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'Constants.dart';
import 'Login2.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var dir = await getExternalStorageDirectory();
  Hive.init(dir!.path);
  await Hive.openBox("LoginDetails");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget buildStartingPage = const SplashScreen();
  String? phone;
  List phoneList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phone = Hive.box("LoginDetails").get("Phone No");
    if (phone != null) {
      recheckLogin();
      setState(() {});
    } else {
      buildStartingPage = const LoginScreen();
      setState(() {});
    }
  }

  Future<void> recheckLogin() async {
    await FirebaseFirestore.instance
        .collection("USERS")
        .get()
        .then((value) => value.docs.forEach((element) {
              phoneList.add(element.get("Phone No"));
            }));
    if (phoneList.contains(phone)) {
      buildStartingPage = const ChatSelectorScreen();
      setState(() {});
    } else {
      buildStartingPage = const LoginScreen();
      setState(() {});
    }
  }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         elevatedButtonTheme: ElevatedButtonThemeData(
//             style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.amberAccent,
//                 side: const BorderSide(color: Colors.deepOrange))),
//         inputDecorationTheme: InputDecorationTheme(
//             enabledBorder: inputBorder,
//             focusedBorder: inputBorder,
//             errorBorder: inputBorder),
//         primaryColor: Colors.amber,
//         appBarTheme: const AppBarTheme(backgroundColor: Colors.amber),
//         useMaterial3: true,
//       ),
//       home: phone != null ? const ChatSelectorScreen() : const LoginScreen(),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder()
          }),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
                  side: const BorderSide(color: Colors.deepOrange))),
          inputDecorationTheme: InputDecorationTheme(
              enabledBorder: inputBorder,
              focusedBorder: inputBorder,
              errorBorder: inputBorder),
          primaryColor: Colors.amber,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.amber),
          useMaterial3: true,
        ),
        home: buildStartingPage);
  }
}
