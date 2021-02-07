import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rumah_kuliner/animation/ScaleRoute.dart';
import 'package:rumah_kuliner/bloc/chart_bloc/chart_bloc.dart';
import 'package:rumah_kuliner/common/app_color.dart';
import 'package:rumah_kuliner/entities/chart_entity.dart';
import 'package:rumah_kuliner/pages/HomePage.dart';
import 'package:rumah_kuliner/pages/account_page.dart';
import 'package:rumah_kuliner/pages/chart_page.dart';
import 'package:rumah_kuliner/pages/order_page.dart';
import 'package:rumah_kuliner/widgets/BottomNavBarWidget.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  List<ChartEntity> _chartEntity;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Roboto', hintColor: Color(0xFFd0cece)),
        home: _renderPage());
  }

  Widget _renderPage() {
    List<Widget> _pageOptions = [
      HomePage(),
      ChartPage(chatyEntity: _chartEntity),
      OrderPage(),
      AccountPage()
    ];
    return Scaffold(
        body: _pageOptions[_selectedIndex],
        bottomNavigationBar: BottomNavBarWidget(
          ontap: _onItemTapped,
        ));
  }

  void _onItemTapped(int index, List<ChartEntity> chartEntity) {
    setState(() {
      _selectedIndex = index;
      _chartEntity = chartEntity;
      // Navigator.push(context, ScaleRoute(page: _pageOptions[index]));
    });
  }
}
