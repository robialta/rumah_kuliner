import 'package:rumah_kuliner/data_source/user_data_source.dart';
import 'package:rumah_kuliner/entities/user_entity.dart';

class UserUsecase {
  final UserDataSource userDataSource = UserDataSource();

  Future<UserEntity> getUser(String id) async {
    return await userDataSource.getUser(id);
  }
}
