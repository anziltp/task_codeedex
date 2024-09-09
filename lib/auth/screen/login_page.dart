

import 'package:flutter/material.dart';
import 'package:task_codeedex/auth/screen/passwordreset_page.dart';

import '../../main.dart';
import '../../services/api_services_page.dart';


class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({super.key});

  @override
  State<LoginScreenPage> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final validatePassword =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final validateEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  String? passwordValidation(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    } else if (!validatePassword.hasMatch(value)) {
      return 'Password must contain at least 8 characters, including:\n- One uppercase letter\n- One lowercase letter\n- One number\n- One special character';
    }
    return null;
  }

  String? emailValidation(String value) {
    if (value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

bool a=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back,color: Colors.white,)),
          backgroundColor: Colors.indigo,
          toolbarHeight: h * 0.17,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(w * 0.3),
                bottomRight: Radius.circular(w * 0.3)),
          ),
          title:Padding(
            padding:  EdgeInsets.all(w*0.2),
            child: Text("Login",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white,fontSize: w*0.09),),
          )
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding:  EdgeInsets.only(top: w*0.3),
            child: Column(
              children: [

                Center(
                  child: Container(
                    width: w * 0.9,
                    height: h*0.5,
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
                                controller: emailController,
                                validator:  (value) => emailValidation(value!),
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: w * 0.03),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(w * 0.02),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(w * 0.02),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: "Enter your email",
                                  labelText: "Email",
                                  hintStyle: const TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
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
                                controller: passwordController,
                                validator:  (value) => passwordValidation(value!),
                                obscureText: a,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  suffixIcon:InkWell(
                                      onTap: () {
                                        a=!a;
                                        setState(() {

                                        });
                                      },
                                      child: Icon(a?Icons.visibility:Icons.visibility_off)),
                                  contentPadding: EdgeInsets.symmetric(horizontal: w * 0.03),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(w * 0.02),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(w * 0.02),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: "Enter your Password",
                                  labelText: "Password",
                                  hintStyle: const TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: h*0.01,),
                        Row( mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordResetScreen(),));
                                },
                                child: Text("Forgot Password?",style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline,decorationColor: Colors.blue),)),
                          ],
                        ),
SizedBox(height: h*0.04,),
                        GestureDetector(
                          onTap: () {
                            ApiServices().loginUser(emailController.text, passwordController.text,context);
                          },
                          child: Container(
                            height: h*0.07,
                            width: w*0.8,

                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(w*0.03),color: Colors.indigo,),

                            child: Center(
                              child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: w*0.05),),
                            ),
                          ),
                        )
                      ],
                    ),
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