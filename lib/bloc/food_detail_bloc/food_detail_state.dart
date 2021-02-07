import 'package:flutter/cupertino.dart';
import 'package:rumah_kuliner/entities/product_entity.dart';
import 'package:rumah_kuliner/entities/user_product_entity.dart';

abstract class FoodDetailState {
  final UserProductEntity productEntity;
  final String error;

  FoodDetailState({this.productEntity, this.error});
}

class FoodDetailInitialState extends FoodDetailState {}

class FoodDetailLoadingState extends FoodDetailState {}

class FoodDetailLoadedState extends FoodDetailState {
  FoodDetailLoadedState({@required UserProductEntity productEntity})
      : super(productEntity: productEntity);
}

class FoodDetailErrorStatetate extends FoodDetailState {
  FoodDetailErrorStatetate({@required String error}) : super(error: error);
}
