import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rumah_kuliner/bloc/home_page_bloc/home_page_event.dart';
import 'package:rumah_kuliner/bloc/home_page_bloc/home_page_state.dart';
import 'package:rumah_kuliner/entities/list_product_entity.dart';
import 'package:rumah_kuliner/use_cases/product_usecase.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final ProductUsecase productUseCase = ProductUsecase();

  @override
  HomePageState get initialState => HomePageInitialState();

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    // if (event is LoadDataHomePageEvent) {
    yield HomePageLoadingState();
    try {
      final ListProductEntity listProductEntity =
          await productUseCase.getProducts();

      yield HomePageLoadedState(listProductEntity: listProductEntity);
    } catch (e) {
      print(e.runtimeType);
      yield HomePageErrorState(error: e.toString() ?? 'Something went wrong');
    }
    // }
  }
}
