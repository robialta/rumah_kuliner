import 'package:rumah_kuliner/entities/user_entity.dart';
import 'package:rumah_kuliner/firebase.dart';

class UserDataSource {
  final db = DB();

  Future<UserEntity> getUser(String id) async {
    final snapshot = await db.userCollection.doc(id).get();
    try {
      final UserEntity userEntity = UserEntity(
          id: snapshot.id,
          name: snapshot.data()['name'],
          phone: snapshot.data()['phone'],
          location: snapshot.data()['location']);
      return userEntity;
    } catch (e) {
      throw new Exception(e);
    }
  }
}
