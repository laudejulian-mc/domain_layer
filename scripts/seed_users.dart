import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../firebase_options.dart';

Future<void> main() async {
  print('Initializing Firebase...');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firestore = FirebaseFirestore.instance;

  print('Seeding users...');

  final users = [
    {
      'name': 'Alice Admin',
      'email': 'alice.admin@example.com',
      'role': 'admin',
      'photoUrl': null,
      'createdAt': FieldValue.serverTimestamp(),
    },
    {
      'name': 'Bob Member',
      'email': 'bob.member@example.com',
      'role': 'member',
      'photoUrl': null,
      'createdAt': FieldValue.serverTimestamp(),
    },
  ];

  for (final u in users) {
    final docRef = firestore.collection('users').doc();
    final map = Map<String, dynamic>.from(u);
    map['id'] = docRef.id;
    await docRef.set(map);
    print('Wrote user ${map['email']} with id ${docRef.id}');
  }

  print('Users seeding complete.');
}
