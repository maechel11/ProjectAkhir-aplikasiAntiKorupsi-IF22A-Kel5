import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/text_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int selectedIndex = 0;
  bool showOption = false;

  String defaultImagePath = "../asset/images/bg1.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 49,
        width: double.infinity,
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(defaultImagePath),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                height: 400,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black.withOpacity(0.3), 
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Center(child: TextUtil(text: "Login", weight: true, size: 30)),
                          const Spacer(),
                          TextUtil(text: "Email"),
                          Container(
                            height: 35,
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.mail, color: Color.fromARGB(255, 255, 255, 255)),
                                fillColor: Colors.white,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const Spacer(),
                          TextUtil(text: "Password"),
                          Container(
                            height: 35,
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.lock, color: Colors.white),
                                fillColor: Colors.white,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(child: Container()), 
                              Expanded(
                                child: TextUtil(
                                  text: "FORGET PASSWORD",
                                  size: 12,
                                  weight: true,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            child: TextUtil(text: "Log In", color: Colors.black),
                          ),
                          const Spacer(),
                          Center(child: TextUtil(text: "Don't have a account REGISTER", size: 12, weight: true)),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 250 + 400 + 20, // Menyesuaikan posisi dengan tinggi kotak blur dan tambahkan jarak
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Tambahkan logika untuk login dengan Google di sini
                },
                icon: Icon(
                  Icons.login,
                  color: Colors.white,
                ),
                label: Text(
                  "Login dengan Google",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Ayo cek Kasus Korupsi Di Indonesia",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30, 
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
