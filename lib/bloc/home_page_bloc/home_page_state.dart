import 'package:flutter/material.dart';
import 'package:rumah_kuliner/entities/list_product_entity.dart';

abstract class HomePageState {
  final ListProductEntity listProductEntity;
  final String error;

  HomePageState({this.error, this.listProductEntity});
}

class HomePageInitialState extends HomePageState {}

class HomePageLoadingState extends HomePageState {}

class HomePageLoadedState extends HomePageState {
  HomePageLoadedState({@required ListProductEntity listProductEntity})
      : super(listProductEntity: listProductEntity);
}

class HomePageErrorState extends HomePageState {
  HomePageErrorState({@required String error}) : super(error: error);
}
