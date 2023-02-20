import 'package:flutter/material.dart';
import 'package:flutter_mongodb/auth/auth_service.dart';
import 'package:flutter_mongodb/auth/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../commons/global-variables.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  void login() {
    authService.login(
        context: context,
        email: emailController.text,
        password: passwordController.text);
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
                'Giriş Yap',
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                )),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.03,
                  height: 40,
                  decoration: BoxDecoration(
                    color: GlobalVariables.myBlueColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          MdiIcons.facebook,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Facebook ile Giriş Yap',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.03,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.transparent,
                          child: Image.asset('assets/googleicon.png'),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Google ile Giriş Yap',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.03,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          MdiIcons.apple,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Apple ile Giriş Yap',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 20),
                      child: const Divider(
                        color: Colors.black,
                        height: 36,
                      ),
                    ),
                  ),
                  Text(
                    'veya',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 10),
                      child: const Divider(
                        color: Colors.black,
                        height: 36,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Form(
                key: _signInFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'ornek@gmail.com',
                        hintStyle: GoogleFonts.poppins(),
                      ),
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
                        ),
                      ),
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Şifre',
                        hintStyle: GoogleFonts.poppins(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Şifremi Unuttum',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  if (_signInFormKey.currentState!.validate()) {
                    login();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    prefs.setString('isLogged', 'yes');
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
                        'Giriş Yap',
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Üye değil misin?',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()));
                    },
                    child: Text(
                      'Buradan kayıt olabilirsin!',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          color: GlobalVariables.myBlueColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
