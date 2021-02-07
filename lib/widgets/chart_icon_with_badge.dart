import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rumah_kuliner/bloc/chart_bloc/chart_bloc.dart';
import 'package:rumah_kuliner/bloc/chart_bloc/chart_event.dart';
import 'package:rumah_kuliner/bloc/chart_bloc/chart_state.dart';

class CartIconWithBadge extends StatefulWidget {
  @override
  _CartIconWithBadgeState createState() => _CartIconWithBadgeState();
}

class _CartIconWithBadgeState extends State<CartIconWithBadge> {
  int counter = 0;
  ChartBloc _chartBloc;

  @override
  void initState() {
    super.initState();
    _chartBloc = ChartBloc()..add(LoadChartData('4oN76bM4lMQrrqX5yT0m'));
  }

  @override
  void dispose() {
    super.dispose();
    _chartBloc?.close();
  }

  Widget _buildData() {
    return BlocProvider<ChartBloc>(
      create: (context) => _chartBloc,
      child: BlocBuilder<ChartBloc, ChartState>(
        builder: (context, state) {
          if (state is ChartLoadedState) {
            counter = state.chartItem.length;
            return _buildLoaded();
          }
          return _buildLoaded();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildData();
  }

  Widget _buildLoaded() => Stack(
        children: <Widget>[
          IconButton(
              icon: Icon(
                FontAwesomeIcons.shoppingCart,
                color: Colors.white,
              ),
              onPressed: () {}),
          counter != 0
              ? Positioned(
                  right: 11,
                  top: 11,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Text(
                      '$counter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Container()
        ],
      );
}
