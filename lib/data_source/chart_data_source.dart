import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rumah_kuliner/entities/chart_entity.dart';
import 'package:rumah_kuliner/firebase.dart';
import 'package:rumah_kuliner/use_cases/product_usecase.dart';

class ChartDataSource {
  final db = DB();
  final productUsecase = ProductUsecase();
  Future<List<ChartEntity>> getUserChart(String userId) async {
    final List<ChartEntity> chartData = [];
    try {
      final QuerySnapshot querySnapshot =
          await db.chartCollection.where('userId', isEqualTo: userId).get();
      querySnapshot.docs.forEach((element) {
        chartData.add(ChartEntity(
            element.data()['count'],
            element.data()['productId'],
            element.data()['name'],
            element.data()['price'],
            element.data()['userId'],
            id: element.id));
      });
      return chartData;
    } catch (e) {
      throw new Exception(e);
    }
  }

  Future<void> addCartData(ChartEntity chartEntity) async {
    try {
      await db.chartCollection.add(chartEntity.toJson());
    } catch (e) {
      throw new Exception(e);
    }
  }

  Future<void> updateChart(ChartEntity chartEntity) async {
    try {
      await db.chartCollection
          .doc(chartEntity.id)
          .update({'count': chartEntity.count + 1});
    } catch (e) {
      throw new Exception(e);
    }
  }
}
