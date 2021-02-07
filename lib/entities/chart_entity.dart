import 'package:rumah_kuliner/entities/product_entity.dart';

class ChartEntity {
  // final List<ProductEntity> chartItem;
  final String id;
  final int count;
  final String name;
  final int price;
  final String productId;
  final String userId;

  ChartEntity(
      // this.chartItem,

      this.count,
      this.productId,
      this.name,
      this.price,
      this.userId,
      {this.id});

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'name': name,
      'price': price,
      'productId': productId,
      'userId': userId
    };
  }
}
