import 'package:chat_app_flutter_firestore/ChatSelectorScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:pinput/pinput.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool goBack = false,
      otpSent = false;
  String otp = "",
      verifyingOTP = "";
  TextEditingController phoneNo = TextEditingController(),
      userName = TextEditingController();

  String verId = "";

  static int id = 1;
  int? a;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await FirebaseFirestore.instance
        .collection("USERS")
        .get()
        .then((value) async {
      a = int.parse(await value.docs.last.id);
      if (a != null && a! >= id) {
        id = a! + 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LoginScreen"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          showDialog(
              context: context,
              builder: (context) =>
                  AlertDialog(
                    title: const Text("Are you sure you want to quite ? "),
                    actions: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              goBack = true;
                            });
                          },
                          child: const Text("YES")),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              goBack = false;
                            });
                          },
                          child: const Text("NO")),
                    ],
                  ));
          return goBack;
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 300,
                      child: Image.asset("assets/images/login0.png"),
                    ),
                    const Text("Enter Your Phone Number To Login / Register"),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: userName,
                      inputFormatters: [LengthLimitingTextInputFormatter(50)],
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                          labelText: "Username : ",
                          labelStyle: TextStyle(color: Colors.black)),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: phoneNo,
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      keyboardType: TextInputType.phone,
                      autofocus: true,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                          labelText: "Mobile No : ",
                          labelStyle: TextStyle(color: Colors.black)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Visibility(
                          visible: otpSent,
                          child: SizedBox(
                            height: 50,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 20,
                            child: Pinput(
                              keyboardType: TextInputType.phone,
                              pinAnimationType: PinAnimationType.slide,
                              autofocus: true,
                              hapticFeedbackType: HapticFeedbackType
                                  .lightImpact,
                              closeKeyboardWhenCompleted: true,
                              defaultPinTheme: PinTheme(
                                  textStyle: const TextStyle(fontSize: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.amber, width: 1))),
                              length: 6,
                              onCompleted: (pin) {
                                setState(() {
                                  otp = pin;
                                });
                              },
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 50,
                      width: 250,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (!otpSent) {
                              await FirebaseAuth.instance.verifyPhoneNumber(
                                timeout: Duration(seconds: 60),
                                phoneNumber: '+91' + phoneNo.text,
                                verificationCompleted:
                                    (PhoneAuthCredential credential) {},
                                verificationFailed: (FirebaseAuthException e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("${e.message}")));
                                  print("\n\n\n\n\n\n\n${e
                                      .message}\n\n\n\n\n\n\n");
                                },
                                codeSent: (String verificationId,
                                    int? resendToken) async {
                                  verId = verificationId;
                                },
                                codeAutoRetrievalTimeout:
                                    (String verificationId) {},
                              );
                            } else {
                              PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: verId, smsCode: otp);
                              await FirebaseAuth.instance
                                  .signInWithCredential(credential);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Login Success ")));
                              print("Login Success ");
                              DocumentReference dr = FirebaseFirestore.instance
                                  .collection("USERS")
                                  .doc("$id");
                              dr.set({
                                "Phone No": phoneNo.text,
                                "Name": userName.text
                              });
                              id++;
                              Box login = Hive.box("LoginDetails");
                              login.put("Phone No", phoneNo.text);
                              login.put("User Name", userName.text);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) =>
                                      ChatSelectorScreen()));
                            }
                            setState(() {
                              otpSent = !otpSent;
                            });
                          },
                          child: Text(
                            otpSent ? "Register / Log in" : "Get OTP",
                            style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                          )),
                    ),
                    const SizedBox(
                      height: 150,
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
