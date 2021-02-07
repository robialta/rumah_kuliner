import 'package:rumah_kuliner/entities/chart_entity.dart';

abstract class ChartState {
  final List<ChartEntity> chartItem;
  final String error;

  ChartState({this.error, this.chartItem});
}

class ChartInitialState extends ChartState {}

class ChartLoadingState extends ChartState {}

class ChartLoadedState extends ChartState {
  ChartLoadedState(List<ChartEntity> chartEntity)
      : super(chartItem: chartEntity);
}

class ChartErrorState extends ChartState {
  ChartErrorState(String error) : super(error: error);
}
