import 'package:rumah_kuliner/entities/chart_entity.dart';

abstract class ChartEvent {
  final ChartEntity chartEntity;
  final String userId;
  final Function callback;

  ChartEvent({this.callback, this.userId, this.chartEntity});
}

class AddChartEvent extends ChartEvent {
  AddChartEvent(ChartEntity chartEntity, Function callback)
      : super(chartEntity: chartEntity, callback: callback);
}

class LoadChartData extends ChartEvent {
  LoadChartData(String id) : super(userId: id);
}
