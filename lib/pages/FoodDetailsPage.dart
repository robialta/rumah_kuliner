import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rumah_kuliner/animation/ScaleRoute.dart';
import 'package:rumah_kuliner/bloc/chart_bloc/chart_bloc.dart';
import 'package:rumah_kuliner/bloc/chart_bloc/chart_event.dart';
import 'package:rumah_kuliner/bloc/food_detail_bloc/food_detail_bloc.dart';
import 'package:rumah_kuliner/bloc/food_detail_bloc/food_detail_event.dart';
import 'package:rumah_kuliner/bloc/food_detail_bloc/food_detail_state.dart';
import 'package:rumah_kuliner/common/app_color.dart';
import 'package:rumah_kuliner/entities/chart_entity.dart';
import 'package:rumah_kuliner/entities/product_entity.dart';
import 'package:rumah_kuliner/entities/user_entity.dart';
import 'package:rumah_kuliner/entities/user_product_entity.dart';
import 'package:rumah_kuliner/pages/chart_page.dart';
import 'package:rumah_kuliner/widgets/chart_icon_with_badge.dart';
import 'package:toast/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FoodDetailsPage extends StatefulWidget {
  final String id;

  const FoodDetailsPage({Key key, this.id}) : super(key: key);
  @override
  _FoodDetailsPageState createState() => _FoodDetailsPageState(id);
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  final String id;
  FoodDetailBloc _foodDetailBloc;
  ChartBloc _chartBloc;
  UserProductEntity _userProductEntity;
  ChartEntity chartEntity;

  _FoodDetailsPageState(this.id);

  @override
  void initState() {
    super.initState();
    _foodDetailBloc = FoodDetailBloc()..add(LoadFoodDetailEvent(id: id));
    _chartBloc = ChartBloc();
  }

  @override
  void dispose() {
    _foodDetailBloc?.close();
    _chartBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Color(0xffff1f1f1),
          appBar: AppBar(
            centerTitle: true,
            title: Text('Detail Produk'),
            backgroundColor: AppColor.primaryColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            brightness: Brightness.light,
            actions: <Widget>[
              CartIconWithBadge(),
            ],
          ),
          body: BlocProvider<FoodDetailBloc>(
            create: (context) => _foodDetailBloc,
            child: BlocBuilder<FoodDetailBloc, FoodDetailState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case FoodDetailInitialState:
                    return _renderLoading();
                    break;
                  case FoodDetailLoadingState:
                    return _renderLoading();
                    break;
                  case FoodDetailLoadedState:
                    // _userEntity = state.productEntity.userEntity;
                    // _productEntity = state.productEntity.productEntity;

                    _userProductEntity = state.productEntity;
                    chartEntity = ChartEntity(
                        1,
                        _userProductEntity.productEntity.id,
                        _userProductEntity.productEntity.name,
                        _userProductEntity.productEntity.price,
                        id);
                    break;
                  case FoodDetailErrorStatetate:
                    _renderError(state.error);
                }
                return _renderLoaded();
              },
            ),
          )),
    );
  }

  Widget _renderLoading() => Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );

  Widget _renderError(String error) => Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: Text(
                'reload',
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
            )
          ],
        ),
      );

  Widget _renderLoaded() => SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _renderProductDetail(),
              _renderAddToChart(context),
              _renderSpacer(),
              _renderSellerInfo(),
              _renderSpacer(),
              _renderProdukInfo(),
              _renderSpacer(),
            ],
          ),
        ),
      );

  _renderProdukInfo() => Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                'Informasi Produk',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cara pembuatan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  _renderSpacer(),
                  Container(
                    child: VideoTutorial(),
                  ),
                  _renderSpacer(),
                  Text(
                    'Keterangan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  _renderSpacer(),
                  Container(
                      alignment: Alignment.topLeft,
                      child: _userProductEntity
                              .productEntity.description.isEmpty
                          ? Text('Tidak ada keterangan')
                          : Text(_userProductEntity.productEntity.description))
                ],
              ),
            ),
          ],
        ),
      );

  _renderSellerInfo() => Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                'Penjual',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(Icons.account_circle),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userProductEntity.userEntity.name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        _userProductEntity.userEntity.location,
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  _renderSpacer() => SizedBox(
        height: 10,
      );

  _renderProductDetail() => Container(
        alignment: Alignment.center,
        color: Colors.white,
        // height: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              child: Carousel(
                overlayShadow: false,
                overlayShadowSize: 12,
                dotBgColor: Colors.transparent,
                autoplay: false,
                boxFit: BoxFit.fitHeight,
                images: [
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset(
                      'assets/images/bestfood/' + 'ic_best_food_8' + ".jpeg",
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    elevation: 0,
                    margin: EdgeInsets.all(0),
                  ),
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset(
                      'assets/images/bestfood/' + 'ic_best_food_8' + ".jpeg",
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    elevation: 0,
                    margin: EdgeInsets.all(0),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                _userProductEntity.productEntity.name,
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF3a3a3b),
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 5),
              child: Text(
                NumberFormat.currency(
                        locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                    .format(_userProductEntity.productEntity.price),
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      );

  Widget _renderAddToChart(BuildContext context) => Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: 41,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.message),
                color: Colors.blueGrey,
                // iconSize: 30,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  // BlocProvider.of<ChartBloc>(context)
                  //     .add(AddChartEvent(chartEntity));
                  _chartBloc.add(AddChartEvent(chartEntity, (String message) {
                    Toast.show(message, context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  }));
                },
                child: Container(
                  // width: MediaQuery.of(context).size.width,
                  height: 45.0,
                  decoration: new BoxDecoration(
                    color: Color(0xFFfd2c2c),
                    border: Border.all(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      'Tambah Ke Keranjang',
                      style: new TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.add),
            //   color: Color(0xFFfd2c2c),
            //   iconSize: 30,
            // ),
          ],
        ),
      );
}

class VideoTutorial extends StatelessWidget {
  final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'pZLZIw451Uc',
      flags: YoutubePlayerFlags(autoPlay: false, mute: false));

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      showVideoProgressIndicator: true,
      controller: _controller,
      width: MediaQuery.of(context).size.width,
    );
  }
}
