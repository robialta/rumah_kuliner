import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rumah_kuliner/animation/ScaleRoute.dart';
import 'package:rumah_kuliner/bloc/chart_bloc/chart_bloc.dart';
import 'package:rumah_kuliner/bloc/chart_bloc/chart_event.dart';
import 'package:rumah_kuliner/bloc/chart_bloc/chart_state.dart';
import 'package:rumah_kuliner/common/app_color.dart';
import 'package:rumah_kuliner/entities/chart_entity.dart';
import 'package:rumah_kuliner/pages/HomePage.dart';
import 'package:rumah_kuliner/pages/account_page.dart';
import 'package:rumah_kuliner/pages/chart_page.dart';
import 'package:rumah_kuliner/pages/order_page.dart';

class BottomNavBarWidget extends StatefulWidget {
  final Function ontap;

  const BottomNavBarWidget({Key key, this.ontap}) : super(key: key);
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int _selectedIndex = 0;
  ChartBloc _chartBloc;
  int _chartCount = 0;
  List<ChartEntity> _chartEntity;

  @override
  void initState() {
    super.initState();
    _chartBloc = ChartBloc()..add(LoadChartData('4oN76bM4lMQrrqX5yT0m'));
  }

  void disopose() {
    super.dispose();
    _chartBloc?.close();
  }

  Widget _buildData({Widget child}) {
    return BlocProvider<ChartBloc>(
      create: (context) => _chartBloc,
      child: BlocBuilder<ChartBloc, ChartState>(
        builder: (context, state) {
          if (state is ChartLoadedState) {
            _chartCount = state.chartItem.length;
            _chartEntity = state.chartItem;
            return _renderLoadedData(state.chartItem.length);
          }
          return _renderLoadedData(_chartCount);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildData();
  }

  _renderLoadedData(int cartCount) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.utensils,
            // color: Colors.blueGrey,
          ),
          title: Text(
            'kuliner',
            style: TextStyle(color: Colors.blueGrey),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.shoppingCart,
            // color: Colors.blueGrey,
          ),
          title: Text(
            'Keranjang',
            style: TextStyle(color: Colors.blueGrey),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.shoppingBag,
            // color: Colors.blueGrey
          ),
          title: Text(
            'Pesanan',
            style: TextStyle(color: Colors.blueGrey),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.userAlt,
            // color: Colors.blueGrey,
          ),
          title: Text(
            'Akun',
            style: TextStyle(color: Colors.blueGrey),
          ),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: AppColor.primaryColor,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
        widget.ontap(index, _chartEntity);
      },
      unselectedItemColor: Colors.blueGrey,
    );
  }
}
