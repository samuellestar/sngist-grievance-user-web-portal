import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/size.dart';
import 'screen_history.dart';
import 'screen_login.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({Key? key}) : super(key: key);

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  String name = '';
  String email = '';
  String collegeId = '';
  String course = '';
  String stream = '';
  String batch = '';

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection('profile')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!["name"];
          email = snapshot.data()!["email"];
          collegeId = snapshot.data()!["id"];
          course = snapshot.data()!["course"];
          stream = snapshot.data()!["stream"];
          batch = snapshot.data()!["batch"];
        });
      }
    });
  }

  @override
  void initState() {
    _getDataFromDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        elevation: 25,
        backgroundColor: amb,
        title: Container(
          height: 50,
          width: 250,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/logo1.png'),
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
                          builder: ((context) => const ScreenHistoty()),
                        ),
                      );
                    });
                  }),
                );
              },
              child: const Icon(
                Icons.history_sharp,
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
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Center(
          child: Flexible(
            child: ListView(
              children: [
                heit,
                heit,
                heit,
                CircleAvatar(
                  child: const ClipOval(
                      // child: Image.asset(
                      //   'assets/images/user-512.webp',
                      //   fit: BoxFit.cover,
                      //   height: 70,
                      //   width: 70,
                      // ),
                      ),
                  foregroundColor: Colors.black.withOpacity(.6),
                  radius: 50,
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(
                  height: 30,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Signed in as',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    heit,
                    Text(
                      FirebaseAuth.instance.currentUser!.email!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Text(
                    //   '' + name,
                    //   style: const TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 25,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // heit,
                    // heit,
                    // heit,
                    // Text(
                    //   'E-mail: ' + email,
                    //   style: const TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.w300,
                    //   ),
                    // ),
                    // heit,
                    // Text(
                    //   'Id: ' + collegeId,
                    //   style: const TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.w300,
                    //   ),
                    // ),
                    // heit,
                    // Text(
                    //   'Course: ' + course,
                    //   style: const TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.w300,
                    //   ),
                    // ),
                    // heit,
                    // Text(
                    //   'Stream: ' + stream,
                    //   style: const TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.w300,
                    //   ),
                    // ),
                    // heit,
                    // Text(
                    //   'Batch: ' + batch,
                    //   style: const TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.w300,
                    //   ),
                    // ),
                  ],
                ),

                // ignore: prefer_const_constructors

                heit,
                heit,
                heit,
                heit,
                heit,

                Center(
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
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 35,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: amb,
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                      child: const Text(
                        'Sign-out',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: bgcolor,
                        ),
                      ),
                    ),
                  ),
                ),
                heit,
                heit,
                heit,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
