import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_image_api/helper/round_btn.dart';
import 'package:my_image_api/helper/utilis.dart';
import '../helper/text_form field.dart';
import 'package:uuid/uuid.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isloding = false;
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final conformpasscontroller = TextEditingController();
  var uuid = Uuid();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void SignUp() {
    setState(() => isloding = true);
    _firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailcontroller.text,
            password: passwordcontroller.text.toString())
        .then((value) {
      setState(() => isloding = false);
    }).onError((error, stackTrace) {
      Utilis().toastMessage(error.toString());
      setState(() => isloding = false);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign-Up"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      helperText: "Like 'abc12@xyz.com'",
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordcontroller,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: "Enter Password",
                        helperText: "Like'Ab1/C@2e'"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Password";
                      } else {
                        return null;
                      }
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            RoundButton(
              text: "Sign Up",
              onTap: () {
                if (_formkey.currentState!.validate()) {
                  SignUp();
                }
                String newUuid = uuid.v4();
                print(newUuid);
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an Account??"),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Login"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
