import 'package:flutter/cupertino.dart';
import 'package:rumah_kuliner/entities/user_entity.dart';

class ProductEntity {
  final String id;
  final String name;
  final int price;
  final String category;
  final String rating;
  final String imagePath;
  final String userId;
  final String description;
  // final UserEntity owner;

  ProductEntity(
      {@required this.description,
      @required this.userId,
      @required this.imagePath,
      @required this.rating,
      @required this.category,
      // @required this.owner,
      @required this.id,
      @required this.name,
      @required this.price});
}
