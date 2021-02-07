import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rumah_kuliner/entities/list_product_entity.dart';
import 'package:rumah_kuliner/entities/product_entity.dart';
import 'package:rumah_kuliner/entities/user_entity.dart';
import 'package:rumah_kuliner/firebase.dart';
import 'package:rumah_kuliner/use_cases/user_usecase.dart';

class ProductDataSource {
  final db = DB();
  final UserUsecase userUsecase = UserUsecase();
  Future<ListProductEntity> getAllProducts() async {
    List<ProductEntity> productEntity = [];
    try {
      final QuerySnapshot product = await db.productCollection.get();

      product.docs.forEach((element) async {
        productEntity.add(ProductEntity(
            id: element.id,
            name: element.data()['name'],
            price: element.data()['price'],
            userId: element.data()['userId'],
            category: element.data()['category'],
            imagePath: element.data()['imagePath'],
            rating: element.data()['rating'],
            description: element.data()['description']
            // owner: await userUsecase.getUser(element.data()['userId'])
            ));
      });
      return ListProductEntity(products: productEntity);
    } catch (e) {
      throw new Exception(e);
    }
  }

  Future<ProductEntity> getProductDetail(String id) async {
    try {
      final snapShot = await db.productCollection.doc(id).get();
      final ProductEntity productEntity = ProductEntity(
          id: snapShot.id,
          name: snapShot.data()['name'],
          price: snapShot.data()['price'],
          category: snapShot.data()['category'],
          rating: snapShot.data()['rating'],
          imagePath: snapShot.data()['imagePath'],
          userId: snapShot.data()['userId'],
          description: snapShot.data()['description']
          // owner: await userUsecase.getUser(snapShot.data()['userId'])
          );
      return productEntity;
    } catch (e) {
      throw new Exception(e);
    }
  }
}
