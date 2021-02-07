import 'package:rumah_kuliner/entities/product_entity.dart';
import 'package:rumah_kuliner/entities/user_entity.dart';

class UserProductEntity {
  final UserEntity userEntity;
  final ProductEntity productEntity;

  UserProductEntity(this.userEntity, this.productEntity);
}
