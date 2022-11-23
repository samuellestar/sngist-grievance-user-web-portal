import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/size.dart';
import 'screen_login.dart';

class ScreenHistoty extends StatefulWidget {
  const ScreenHistoty({Key? key}) : super(key: key);

  @override
  State<ScreenHistoty> createState() => _ScreenHistotyState();
}

class _ScreenHistotyState extends State<ScreenHistoty> {
  final _grievance = FirebaseFirestore.instance
      .collection('grievance')
      .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  Future _update([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            child: ListView(
              children: [
                const Text(
                  'SUBJECT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                heit,
                Text(
                  documentSnapshot!['subject'],
                ),
                heit,
                heit,
                const Text(
                  'GRIEVANCE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                heit,
                Text(
                  documentSnapshot['grivence'],
                ),
                heit,
                heit,
                const Text(
                  'Resolution User Seeks',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                heit,
                Text(
                  documentSnapshot['resolution'],
                ),
                heit,
                heit,
                const Text(
                  'MORE INFORMATIONS ABOUT GRIEVANCE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                heit,
                Text(
                  documentSnapshot['moreInfo'],
                ),
                heit,
                heit,
                const Text(
                  'CURRENT STATUS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                heit,
                Text(
                  documentSnapshot['solution'],
                ),
                heit,
                const Text(
                  'COMMITTEE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                heit,
                Text(
                  documentSnapshot['solvedBy'],
                ),
                const Text(' '),
                Text(
                  documentSnapshot['solvedOn'],
                ),
                // const Text(' '),
                // Text(
                //   documentSnapshot['c3'],
                // ),
                heit,
                heit,
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //appbar

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
      ),
      body: StreamBuilder(
        stream: _grievance,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () {
                    _update(documentSnapshot);
                  },
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(
                        documentSnapshot['subject'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(documentSnapshot['grivence']),
                      trailing: Text(documentSnapshot['submittedAt']),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
