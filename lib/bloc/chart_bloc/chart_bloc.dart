import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rumah_kuliner/bloc/chart_bloc/chart_event.dart';
import 'package:rumah_kuliner/bloc/chart_bloc/chart_state.dart';
import 'package:rumah_kuliner/entities/chart_entity.dart';
import 'package:rumah_kuliner/use_cases/chart_usecase.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  final ChartUseCase chartUseCase = ChartUseCase();
  @override
  ChartState get initialState => ChartInitialState();

  @override
  Stream<ChartState> mapEventToState(ChartEvent event) async* {
    if (event is LoadChartData) {
      yield ChartLoadingState();
      try {
        final List<ChartEntity> chartData =
            await chartUseCase.getChartData(event.userId);
        yield ChartLoadedState(chartData);
      } catch (e) {
        yield ChartErrorState(e.toString());
      }
    }

    if (event is AddChartEvent) {
      try {
        await chartUseCase.addChart(event.chartEntity);
        event.callback('Berhasil');
      } catch (e) {
        event.callback(e.toString());
        yield ChartErrorState(e.toString());
      }
    }
  }
}
