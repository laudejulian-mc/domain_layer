import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../firebase_options.dart';

Future<void> main() async {
  print('Initializing Firebase...');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firestore = FirebaseFirestore.instance;

  print('Seeding club_info...');

  final clubInfo = {
    'id': 'main',
    'name': 'HoopHub Community Club',
    'mission': 'Connect local players and hobbyists',
    'contactEmail': 'contact@hoophub.example',
    'rules': 'Be respectful. Play fair. Have fun.',
    'createdAt': FieldValue.serverTimestamp(),
  };

  await firestore.collection('club_info').doc('main').set(clubInfo);
  print('Wrote club_info/main');

  print('Club info seeding complete.');
}
