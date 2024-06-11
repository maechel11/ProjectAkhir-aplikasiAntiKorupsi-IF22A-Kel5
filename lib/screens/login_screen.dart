import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:snow_login/event/event_db.dart';
import 'package:snow_login/model/user.dart';
import 'package:snow_login/screens/add_register.dart';
import 'package:snow_login/screens/dashboard.dart';
import '../widget/text_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int selectedIndex = 0;
  bool showOption = false;
  bool isLoading = false;

  String defaultImagePath = "../asset/images/bg1.png";

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddRegister()),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      String email = _emailController.text;
      String password = _passwordController.text;

      User? user = await EventDb.login(email, password);

      setState(() {
        isLoading = false;
      });

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard(currentUser: user)), 
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login gagal')),
        );
      }
    }
  }

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
                      child: Form(
                        key: _formKey,
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
                                controller: _emailController,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.person, color: Color.fromARGB(255, 255, 255, 255)),
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukkan email Anda';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const Spacer(),
                            TextUtil(text: "Kata Sandi"),
                            Container(
                              height: 35,
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.lock, color: Colors.white),
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukkan kata sandi Anda';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: _login,
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                alignment: Alignment.center,
                                child: isLoading
                                    ? const CircularProgressIndicator()
                                    : TextUtil(text: "Masuk", color: Colors.black),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: _navigateToRegister,
                              child: Center(
                                child: TextUtil(
                                  text: "Belum punya akun? DAFTAR",
                                  size: 16,
                                  weight: true,
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
