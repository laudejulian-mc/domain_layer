import '../models/club_info_model.dart';

abstract class ClubInfoRemoteDataSource {
  Future<ClubInfoModel> getClubInfo();
}
