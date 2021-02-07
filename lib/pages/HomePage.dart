import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rumah_kuliner/animation/ScaleRoute.dart';
import 'package:rumah_kuliner/bloc/home_page_bloc/home_page_bloc.dart';
import 'package:rumah_kuliner/bloc/home_page_bloc/home_page_event.dart';
import 'package:rumah_kuliner/bloc/home_page_bloc/home_page_state.dart';
import 'package:rumah_kuliner/common/app_color.dart';
import 'package:rumah_kuliner/entities/list_product_entity.dart';
import 'package:rumah_kuliner/pages/SignInPage.dart';
import 'package:rumah_kuliner/widgets/BestFoodWidget.dart';
import 'package:rumah_kuliner/widgets/BottomNavBarWidget.dart';
import 'package:rumah_kuliner/widgets/PopularFoodsWidget.dart';
import 'package:rumah_kuliner/widgets/TopMenus.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageBloc _homePageBloc;
  ListProductEntity _listProductEntity;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _homePageBloc = HomePageBloc();
  }

  @override
  void dispose() {
    _homePageBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _homePageBloc.add(LoadDataHomePageEvent());
    return SafeArea(
      child: BlocProvider<HomePageBloc>(
        create: (context) => _homePageBloc,
        child:
            BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
          switch (state.runtimeType) {
            case HomePageInitialState:
              return _renderLoading();
              break;
            case HomePageLoadingState:
              return _renderLoading();
              break;
            case HomePageErrorState:
              return _renderError(state.error);
            case HomePageLoadedState:
              _listProductEntity = state.listProductEntity;
              // return _renderLoaded(state.listProductEntity);
              break;
          }
          return _renderLoaded();
        }),
      ),
    );
  }

  Widget _renderLoaded() => ListView(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                padding: EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                child: BestFoodWidget(),
              ),
              Container(
                  child: Row(
                children: [
                  Expanded(
                    child: _renderSearchBox(),
                  ),
                  IconButton(
                      iconSize: 30,
                      icon: Icon(
                        CupertinoIcons.bell_solid,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(context, ScaleRoute(page: SignInPage()));
                      }),
                ],
              )),
            ],
          ),
          TopMenus(),
          PopularFoodsWidget(listProductEntity: _listProductEntity)
        ],
      );

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

  Widget _renderSearchBox() {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 8, right: 5, bottom: 5),
      child: Container(
        height: 50,
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 10),
            border: OutlineInputBorder(),
            filled: true,
            prefixIcon: Icon(
              Icons.search,
              color: AppColor.primaryColor,
            ),
            fillColor: Color(0xFFFAFAFA),
            hintStyle: new TextStyle(color: Color(0xFFd0cece), fontSize: 18),
            hintText: "Cari kelepon",
          ),
        ),
      ),
    );
  }
}
