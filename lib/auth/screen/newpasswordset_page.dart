
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../services/api_services_page.dart';


class NewPasswordSetPage extends StatefulWidget {
  String email;
  String otp;
  NewPasswordSetPage({  super.key,required this.email,required this.otp});

  @override
  State<NewPasswordSetPage> createState() => _NewPasswordSetPageState();
}

class _NewPasswordSetPageState extends State<NewPasswordSetPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final validatePassword =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  String? passwordValidation(String value) {
    if (value.isEmpty) {
      return 'Please enter a password';
    } else if (!validatePassword.hasMatch(value)) {
      return 'Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a number, and a special character.';
    }
    return null;
  }
  String? confirmPasswordValidation(String value) {
    if (value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
  void submitPasswordReset() {
    if (_formKey.currentState!.validate()) {
      ApiServices().resetPassword(
          context,
          newPasswordController.text,
          confirmPasswordController.text,
          widget.email,
          widget.otp

      );
    }
  }
  bool a=false;
  bool b=false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key:_formKey,
          child: Padding(
            padding:  EdgeInsets.only(top: w*0.15),
            child: Column(
              children: [
                Center(
                    child: Text(
                      "Create New Password",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: w * 0.06),
                    )),
                Center(
                    child: Text(
                      "Please enter and confirm your new password.",
                      style: TextStyle( fontSize: w * 0.03),
                    )),
                Center(
                    child: Text(
                      "You will need to login after you reset.",
                      style: TextStyle( fontSize: w * 0.03),
                    )),
                SizedBox(height: h*0.09,),
                Container(
                  width: w * 0.9,
                  height: h*0.65,
                  child: Column(

                    children: [

                      Column(
                        children: [

                          Container(
                            height: h * 0.07,
                            width: w * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(w * 0.01),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: w * 0.01,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: newPasswordController,
                              validator: (value) => passwordValidation(value!),
                              obscureText: a,
                              style:  const TextStyle(color: Colors.black),
                              decoration:  InputDecoration(
                                suffixIcon:InkWell(
                                    onTap: () {
                                      a=!a;
                                      setState(() {

                                      });
                                    },
                                    child: Icon(a?Icons.visibility:Icons.visibility_off)),
                                hintText: ("Enter your password"),
                                label: Padding(
                                  padding: EdgeInsets.all(w*0.03),
                                  child: const Text("Password"),
                                ),
                                labelStyle: const TextStyle(color: Colors.grey),

                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const Row(
                            children: [
                              Text(
                                "Must contain 8 char.",
                                style: TextStyle(fontWeight: FontWeight.w400,color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: h*0.03,),
                      Column(
                        children: [

                          Container(
                            height: h * 0.07,
                            width: w * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(w * 0.01),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: w * 0.01,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: confirmPasswordController,
                              validator: (value) => confirmPasswordValidation(value!),
                              obscureText: b,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                suffixIcon:InkWell(
                                    onTap: () {
                                      b=!b;
                                      setState(() {

                                      });
                                    },
                                    child: Icon(b?Icons.visibility:Icons.visibility_off)),
                                hintText: "Confirm your password",
                                label:  Padding(
                                  padding:  EdgeInsets.all(w*0.03),
                                  child: Text("ConfirmPassword"),
                                ),
                                labelStyle: const TextStyle(color: Colors.grey),
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: InputBorder.none, // Removes the underline
                              ),
                            ),
                          ),

                        ],
                      ),

                      SizedBox(
                        height: h*0.05,
                      ),
                      GestureDetector(
                        onTap: () {
                          submitPasswordReset();


                        },
                        child: Container(

                            height: h*0.07,
                            width: w*0.8,

                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(w*0.03),color: Colors.indigo,),


                            child: Center(
                            child: Text("Reset Password",style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
