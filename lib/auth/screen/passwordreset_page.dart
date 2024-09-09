

import 'package:flutter/material.dart';

import '../../main.dart';
import '../../services/api_services_page.dart';
import 'otp_page.dart';

class PasswordResetScreen extends StatefulWidget {

  const PasswordResetScreen({super.key});

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  void handlePasswordReset() async {
    if (_formKey.currentState!.validate()) {

      ApiServices().requestPasswordReset(emailController.text);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OtpScreenPage(email:emailController.text ,),));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: h * 0.05,
              ),
              Text(
                'Enter your valid email to reset your password',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: h * 0.1),
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
                  controller: emailController,
                  decoration: InputDecoration(
                      border: InputBorder.none,

                      //labelText: 'Email',
                    label: Padding(
                      padding:  EdgeInsets.all(w*0.03),
                      child: const Text("  Enter your Email"),
                    )

                  ),
                  keyboardType: TextInputType.emailAddress,
style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },

                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(

                onTap: () {
                  handlePasswordReset();
                },
                child: const Text(
                  'Request Password Reset',
                  style: TextStyle(

                      decorationThickness: 2,
                      decorationColor: Colors.teal,
                      color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}