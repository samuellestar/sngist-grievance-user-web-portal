import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import '../constants/size.dart';
import 'screen_login.dart';
import 'screen_profile.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _subject = TextEditingController();
  final _discribe = TextEditingController();
  final _resolution = TextEditingController();
  final _moreinfo = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final datenow = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar

      appBar: AppBar(
        elevation: 25,
        backgroundColor: amb,
        title: Padding(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          child: Container(
            height: 50,
            width: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logo1.png'),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                Future.delayed(
                  Duration.zero,
                  (() {
                    setState(() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: ((context) => const ScreenProfile())),
                      );
                    });
                  }),
                );
              },
              child: const Icon(
                Icons.account_circle_rounded,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScreenLogin(),
                  ),
                );
              },
              child: const Icon(
                Icons.logout_rounded,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),

      //body

      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Flexible(
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: amb, borderRadius: BorderRadius.circular(5)),
                    child: const Center(
                      child: Text(
                        'GRIEVANCE FORM',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              heit,

              //

              Row(
                children: [
                  //subject

                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _subject,
                        decoration: InputDecoration(
                          hintText: 'Subject of your grievance. *',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
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
                    ),
                  ),

                  //
                ],
              ),

              //grievance

              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _discribe,
                    decoration: InputDecoration(
                      hintText: 'Discribe your grievance. *',
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 35,
                        horizontal: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
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
                ),
              ),

              //resolution

              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _resolution,
                    decoration: InputDecoration(
                      hintText: 'What resolution do you consider fair? *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
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
                ),
              ),

              //futher info

              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _moreinfo,
                    decoration: InputDecoration(
                        hintText: 'An other information you can provide.',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ),
              ),

              //

              const Flexible(
                child: SizedBox(
                  height: 150,
                ),
              ),

              //submit button

              Center(
                child: GestureDetector(
                  onTap: () {
                    try {
                      if (_formKey.currentState!.validate()) {
                        final User? user = _auth.currentUser;
                        final _uid = user!.uid;
                        FirebaseFirestore.instance.collection('grievance').add({
                          'id': _uid,
                          'subject': _subject.text,
                          'grivence': _discribe.text,
                          'resolution': _resolution.text,
                          'moreInfo': _moreinfo.text,
                          'submittedAt':
                              '${datenow.day}/${datenow.month}/${datenow.year}',
                          'status': '',
                          'usermail': FirebaseAuth.instance.currentUser!.email,
                          'solvedBy': '',
                          'solvedOn': '',
                          'solution': '',
                        });
                        openDialog();
                      }
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
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 25,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: amb,
                    ),
                    child: Text(
                      'SUBMIT',
                      style: GoogleFonts.ibarraRealNova(
                        fontWeight: FontWeight.bold,
                        color: bgcolor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),

              //

              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Your grievance has been submitted',
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Future.delayed(
                    Duration.zero,
                    (() {
                      setState(() {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: ((context) => const ScreenHome())),
                            (route) => false);
                      });
                    }),
                  );
                },
                child: const Text('Close'))
          ],
        ),
      );
}
