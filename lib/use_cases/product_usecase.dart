import 'package:rumah_kuliner/data_source/product_data_source.dart';
import 'package:rumah_kuliner/entities/list_product_entity.dart';
import 'package:rumah_kuliner/entities/product_entity.dart';
import 'package:rumah_kuliner/entities/user_entity.dart';
import 'package:rumah_kuliner/entities/user_product_entity.dart';
import 'package:rumah_kuliner/use_cases/user_usecase.dart';

class ProductUsecase {
  final ProductDataSource productDataSource = ProductDataSource();
  final UserUsecase userUsecase = UserUsecase();
  Future<ListProductEntity> getProducts() async {
    final ListProductEntity listProductEntity =
        await productDataSource.getAllProducts();
    return listProductEntity;
  }

  Future<UserProductEntity> getDetailProduct(String id) async {
    final ProductEntity productEntity =
        await productDataSource.getProductDetail(id);
    final UserEntity userEntity =
        await userUsecase.getUser(productEntity.userId);

    final UserProductEntity userProductEntity =
        UserProductEntity(userEntity, productEntity);
    return userProductEntity;
  }
}
