import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:snow_login/event/event_db.dart';
import 'package:snow_login/screens/login_screen.dart';
import 'package:snow_login/widget/text_utils.dart';

class AddRegister extends StatefulWidget {
  const AddRegister({super.key});

  @override
  State<AddRegister> createState() => _AddRegisterState();
}

class _AddRegisterState extends State<AddRegister> {
  int selectedIndex = 0;
  bool showOption = false;

  String defaultImagePath = "../asset/images/bg1.png";
  
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
  
  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      String username = _usernameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      String confirmPassword = _confirmPasswordController.text;
      
      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      String response = await EventDb.adduser(username, email, password);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response)),
      );

      if (response == 'Registrasi Berhasil') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,233, 246, 255),
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 49,
        width: double.infinity,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
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
                    height: constraints.maxHeight * 0.6,
                    width: constraints.maxWidth * 0.8,
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
                                Center(child: TextUtil(text: "REGISTER", weight: true, size: 30)),
                                const Spacer(),
                                TextUtil(text: "Username"),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
                                  child: TextFormField(
                                    controller: _usernameController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your username';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const Spacer(),
                                TextUtil(text: "Email"),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
                                  child: TextFormField(
                                    controller: _emailController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const Spacer(),
                                TextUtil(text: "Password"),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
                                  child: TextFormField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const Spacer(),
                                TextUtil(text: "Confirm Password"),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
                                  child: TextFormField(
                                    controller: _confirmPasswordController,
                                    obscureText: true,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please confirm your password';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: _register,
                                  child: Container(
                                    height: 40,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.center,
                                    child: TextUtil(text: "Confirm", color: Colors.black),
                                  ),
                                ),
                                const Spacer(),
                            GestureDetector(
                              onTap: _navigateToLogin,
                              child: Center(
                                child: TextUtil(
                                  text: "Kembali ke Login",
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
          );
        },
      ),
    );
  }
}