

import 'package:flutter/material.dart';

import '../main.dart';
import '../services/api_services_page.dart';

import '../auth/screen/login_page.dart';
import '../auth/screen/otp_page.dart';

class RegisterScreenPage extends StatefulWidget {
  const RegisterScreenPage({super.key});

  @override
  State<RegisterScreenPage> createState() => _RegisterScreenPageState();
}

class _RegisterScreenPageState extends State<RegisterScreenPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final validatePassword =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final validateEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
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
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
  void submitForm() async {
    if (_formKey.currentState!.validate()) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registering...'), duration: Duration(seconds: 2)),
      );


      final response = await ApiServices().registerUser(
        nameController.text,
        emailController.text,
        passwordController.text,
      );

      if (response['message'] == "Email already registered") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email already registered, please login')),
        );
      } else if (response['status'] == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreenPage(email: emailController.text),
          ),
        );
      } else {
        // Show any other error messages
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? 'Registration failed')),
        );
      }
    }
  }
  bool a=false;
  bool b=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back,color: Colors.white,)),
          backgroundColor: Colors.indigo,
          toolbarHeight: h * 0.17,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(w * 0.3),
                bottomRight: Radius.circular(w * 0.3)),
          ),
          title:Padding(
            padding:  EdgeInsets.all(w*0.15),
            child: Text("Register",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white,fontSize: w*0.09),),
          )
      ),
      body: SingleChildScrollView(
        child: Form(
          key:_formKey,
          child: Padding(
            padding:  EdgeInsets.only(top: w*0.1),
            child: Column(
              children: [

                Center(
                  child: Container(
                    width: w * 0.9,
                    height: h*0.65,
                    child: Column( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                keyboardType: TextInputType.name,
                                controller: nameController,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: "Enter your Name",
                                  label: Padding(
                                    padding: EdgeInsets.all(w * 0.03),
                                    child: Text("Full Name"),
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                validator: (value) {
                                  if (validateEmail.hasMatch(value!)) {
                                    return null;
                                  } else {
                                    return "Enter a Valid Email";
                                  }
                                },
                                style: const TextStyle(color: Colors.black),
                                 decoration: InputDecoration(

                                  hintText: "Enter your Email",
                                  label: Padding(
                                    padding: EdgeInsets.all(w * 0.03),
                                    child: Text("Email"),
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                keyboardType: TextInputType.text,
                                controller: passwordController,
                                validator: (value) => passwordValidation(value!),
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
                                  hintText: "Enter your password",
                                  label: Padding(
                                    padding: EdgeInsets.all(w * 0.03),
                                    child: Text("Password"),
                                  ),
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
                                keyboardType: TextInputType.text,
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
                                  label: Padding(
                                    padding: EdgeInsets.all(w * 0.03),
                                    child: const Text("ConfirmPassword"),
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: InputBorder.none,
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
                            submitForm();

                          },
                          child: Container(
                            height: h*0.07,
                            width: w*0.8,

                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(w*0.03),color: Colors.indigo,),


                            child: const Center(
                              child: Text("Create Account",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900),),
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreenPage(),));
                            },
                            child: const Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have a account? "),
                                Text("Login here",style: TextStyle(color: Colors.blue),),
                              ],
                            ))
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
