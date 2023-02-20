import 'package:flutter/material.dart';
import 'package:flutter_mongodb/auth/auth_service.dart';
import 'package:flutter_mongodb/auth/login_screen.dart';
import 'package:flutter_mongodb/commons/my_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../commons/global-variables.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _signupKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  void signup() {
    authService.signUp(
        context: context,
        email: emailController.text,
        password: passwordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 90, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kayıt Ol',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _signupKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ad',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    TextField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                          hintText: 'Adınız', hintStyle: GoogleFonts.poppins()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Soyad',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    TextField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                          hintText: 'Soyadınız',
                          hintStyle: GoogleFonts.poppins()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Email',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: 'Email', hintStyle: GoogleFonts.poppins()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Şifre',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                    TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: 'Şifre', hintStyle: GoogleFonts.poppins()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_signupKey.currentState!.validate()) {
                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              firstNameController.text.isEmpty ||
                              lastNameController.text.isEmpty) {
                            showSnackBar(
                                context, 'Lütfen tüm alanları doldurun');
                          } else if (passwordController.text.length < 6) {
                            showSnackBar(
                                context, 'Şifre en az 6 karakter olmalı!');
                          } else {
                            Future.delayed(const Duration(seconds: 1));
                            signup();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          }
                        }
                      },
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.4,
                          height: 60,
                          decoration: BoxDecoration(
                            color: GlobalVariables.myBlueColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              'Kayıt Ol',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
