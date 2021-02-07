import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rumah_kuliner/bloc/food_detail_bloc/food_detail_event.dart';
import 'package:rumah_kuliner/bloc/food_detail_bloc/food_detail_state.dart';
import 'package:rumah_kuliner/entities/product_entity.dart';
import 'package:rumah_kuliner/entities/user_product_entity.dart';
import 'package:rumah_kuliner/use_cases/product_usecase.dart';

class FoodDetailBloc extends Bloc<FoodDetailEvent, FoodDetailState> {
  final ProductUsecase productUsecase = ProductUsecase();
  @override
  FoodDetailState get initialState => FoodDetailInitialState();

  @override
  Stream<FoodDetailState> mapEventToState(FoodDetailEvent event) async* {
    yield FoodDetailLoadingState();
    try {
      final UserProductEntity productEntity =
          await productUsecase.getDetailProduct(event.id);
      yield FoodDetailLoadedState(productEntity: productEntity);
    } catch (e) {
      yield FoodDetailErrorStatetate(error: e.toString());
    }
  }
}
