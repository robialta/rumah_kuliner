import 'package:rumah_kuliner/data_source/chart_data_source.dart';
import 'package:rumah_kuliner/entities/chart_entity.dart';

class ChartUseCase {
  final ChartDataSource cHartDataSource = ChartDataSource();

  Future<List<ChartEntity>> getChartData(String userId) async {
    final List<ChartEntity> chartData =
        await cHartDataSource.getUserChart(userId);
    return chartData;
  }

  Future<bool> alreadyInchart(ChartEntity chartEntity) async {
    final List<ChartEntity> chartData = await getChartData(chartEntity.userId);

    final data = chartData
        .where((element) => element.productId == chartEntity.productId)
        .toList();
    return data.isNotEmpty;
  }

  Future<void> addChart(ChartEntity chartEntity) async {
    try {
      if (await alreadyInchart(chartEntity)) {
        await cHartDataSource.updateChart(chartEntity);
      } else {
        await cHartDataSource.addCartData(chartEntity);
      }
    } catch (e) {
      throw new Exception(e);
    }
  }
}
