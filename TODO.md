# TODO: Create Data Layer Components for Club Information Hub

- [x] Create ClubInfoModel in lib/data/models/club_info_model.dart extending ClubInfo with fromJson/toJson methods
- [x] Create ClubInfoRemoteDataSource interface in lib/data/datasources/club_info_remote_data_source.dart with Future<ClubInfoModel> getClubInfo()
- [x] Create ClubInfoRemoteDataSourceImpl in lib/data/datasources/club_info_remote_data_source_impl.dart implementing the interface using Firebase Firestore
- [x] Create ClubInfoRepositoryImpl in lib/data/repositories/club_info_repository_impl.dart implementing ClubInfoRepository using the data source
