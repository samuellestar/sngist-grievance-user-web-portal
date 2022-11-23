import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/size.dart';
import 'screen_forgot_password.dart';

class ScreenLoginSmall extends StatefulWidget {
  const ScreenLoginSmall({Key? key}) : super(key: key);

  @override
  State<ScreenLoginSmall> createState() => _ScreenLoginSmallState();
}

class _ScreenLoginSmallState extends State<ScreenLoginSmall> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isVisible = false;

  final _formKey = GlobalKey<FormState>();

  //signin method

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _idController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgcolor,
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              //logo image

              Flexible(
                child: Container(
                  width: 300,
                  height: 130,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.07,
                      left: 35,
                      right: 35),
                  child: const Image(
                    image: AssetImage('assets/images/logo1.png'),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2,
                    right: MediaQuery.of(context).size.width * .03,
                    left: MediaQuery.of(context).size.width * .03),
                child: Column(
                  children: [
                    //email field
                    TextFormField(
                      controller: _idController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Value empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    heit,

                    //password field

                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                          icon: _isVisible
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.black,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                        ),
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Value empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    heit,

                    //signin button

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signIn();
                        }
                      },
                      child: const Text('Sign-in'),
                      style: ElevatedButton.styleFrom(
                        elevation: 8,
                        primary: amb,
                        shadowColor: Colors.blueGrey,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 120,
                          vertical: 18,
                        ),
                        textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: bgcolor),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //forgot button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Future.delayed(
                              Duration.zero,
                              (() {
                                setState(() {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: ((context) =>
                                          const ScreenForgotPassword()),
                                    ),
                                  );
                                });
                              }),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
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
