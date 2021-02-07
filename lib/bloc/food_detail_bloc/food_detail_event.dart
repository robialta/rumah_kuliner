import 'package:flutter/cupertino.dart';

abstract class FoodDetailEvent {
  final id;

  FoodDetailEvent({this.id});
}

class LoadFoodDetailEvent extends FoodDetailEvent {
  LoadFoodDetailEvent({@required String id}) : super(id: id);
}
