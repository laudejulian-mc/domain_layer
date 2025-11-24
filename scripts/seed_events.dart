import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../firebase_options.dart';

Future<void> main() async {
  print('Initializing Firebase...');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firestore = FirebaseFirestore.instance;

  print('Seeding events...');

  final eventRef = firestore.collection('events').doc();
  final event = {
    'id': eventRef.id,
    'title': 'Sunday Practice',
    'description': 'Open practice for all members',
    'startsAt': Timestamp.fromDate(DateTime.now().add(Duration(days: 7))),
    'location': 'Community Court',
    'createdAt': FieldValue.serverTimestamp(),
  };

  await eventRef.set(event);
  print('Wrote event ${event['title']} with id ${eventRef.id}');

  print('Events seeding complete.');
}
