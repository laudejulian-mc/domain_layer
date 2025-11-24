import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/club_info_model.dart';
import 'club_info_remote_data_source.dart';

class ClubInfoRemoteDataSourceImpl implements ClubInfoRemoteDataSource {
  final FirebaseFirestore firestore;

  ClubInfoRemoteDataSourceImpl({required this.firestore});

  @override
  Future<ClubInfoModel> getClubInfo() async {
    final doc = await firestore.collection('club_info').doc('main').get();
    if (!doc.exists) {
      throw Exception('Club info not found');
    }
    return ClubInfoModel.fromJson(doc.data()!);
  }
}
