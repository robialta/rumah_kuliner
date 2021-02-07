import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rumah_kuliner/animation/ScaleRoute.dart';
import 'package:rumah_kuliner/entities/list_product_entity.dart';
import 'package:rumah_kuliner/pages/FoodDetailsPage.dart';

class PopularFoodsWidget extends StatefulWidget {
  final ListProductEntity listProductEntity;

  PopularFoodsWidget({Key key, this.listProductEntity}) : super(key: key);
  @override
  _PopularFoodsWidgetState createState() =>
      _PopularFoodsWidgetState(listProductEntity);
}

class _PopularFoodsWidgetState extends State<PopularFoodsWidget> {
  final ListProductEntity _listProductEntity;

  _PopularFoodsWidgetState(this._listProductEntity);
  @override
  Widget build(BuildContext context) {
    return Container(
        child:
            //   // height: 700,
            //   width: double.infinity,
            //   child: Column(
            //     children: <Widget>[
            //       PopularFoodTitle(),
            //       Expanded(
            //         child:

            PopularFoodItems(
      listProductEntity: _listProductEntity,
    )
        //     )
        //   ],
        // ),
        );
  }
}

class PopularFoodItems extends StatelessWidget {
  final ListProductEntity listProductEntity;

  const PopularFoodItems({Key key, this.listProductEntity}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: _buildData(listProductEntity),
      // children: <Widget>[
      //   PopularFoodTiles(
      //       name: "Fried Egg",
      //       imageUrl: "ic_popular_food_1",
      //       rating: '4.9',
      //       numberOfRating: '200',
      //       price: '15.06',
      //       slug: "fried_egg"),
      //   PopularFoodTiles(
      //       name: "Mixed Vegetable",
      //       imageUrl: "ic_popular_food_3",
      //       rating: "4.9",
      //       numberOfRating: "100",
      //       price: "17.03",
      //       slug: ""),
      //   PopularFoodTiles(
      //       name: "Salad With Chicken",
      //       imageUrl: "ic_popular_food_4",
      //       rating: "4.0",
      //       numberOfRating: "50",
      //       price: "11.00",
      //       slug: ""),

      // ],
    );
  }
}

List<Widget> _buildData(ListProductEntity listProductEntity) {
  List<Widget> dataList = [];
  for (final data in listProductEntity.products) {
    dataList.add(PopularFoodTiles(
        category: data.category,
        id: data.id,
        name: data.name,
        imageUrl: data.imagePath,
        rating: '4,0',
        numberOfRating: '50',
        price: data.price,
        slug: ''));
  }

  return dataList;
}

class PopularFoodTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Popluar Foods",
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.w300),
          ),
          Text(
            "See all",
            style: TextStyle(
                fontSize: 16, color: Colors.blue, fontWeight: FontWeight.w100),
          )
        ],
      ),
    );
  }
}

class PopularFoodTiles extends StatelessWidget {
  final String category;
  final String id;
  String name;
  String imageUrl;
  String rating;
  String numberOfRating;
  final int price;
  String slug;

  PopularFoodTiles({
    Key key,
    @required this.name,
    @required this.imageUrl,
    @required this.rating,
    @required this.numberOfRating,
    @required this.price,
    @required this.slug,
    @required this.id,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            ScaleRoute(
                page: FoodDetailsPage(
              id: id,
            )));
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
            decoration: BoxDecoration(boxShadow: [
              /* BoxShadow(
                color: Color(0xFFfae3e2),
                blurRadius: 15.0,
                offset: Offset(0, 0.75),
              ),*/
            ]),
            child: Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Container(
                  width: 170,
                  height: 210,
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          // Align(
                          //   alignment: Alignment.topRight,
                          //   child: Container(
                          //     alignment: Alignment.topRight,
                          //     width: double.infinity,
                          //     padding: EdgeInsets.only(right: 5, top: 5),
                          //     child: Container(
                          //       height: 28,
                          //       width: 28,
                          //       decoration: BoxDecoration(
                          //           shape: BoxShape.circle,
                          //           color: Colors.white70,
                          //           boxShadow: [
                          //             BoxShadow(
                          //               color: Color(0xFFfae3e2),
                          //               blurRadius: 25.0,
                          //               offset: Offset(0.0, 0.75),
                          //             ),
                          //           ]),
                          //       child: Icon(
                          //         Icons.favorite,
                          //         color: Color(0xFFfb3132),
                          //         size: 16,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Center(
                                child: Image.asset(
                              'assets/images/popular_foods/' +
                                  imageUrl +
                                  ".png",
                              width: 130,
                              height: 140,
                            )),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(left: 5, top: 5),
                            child: Text(name,
                                style: TextStyle(
                                    color: Color(0xFF6e6e71),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                          ),
                          // Container(
                          //   alignment: Alignment.topRight,
                          //   padding: EdgeInsets.only(right: 5),
                          //   child: Container(
                          //     height: 28,
                          //     width: 28,
                          //     decoration: BoxDecoration(
                          //         shape: BoxShape.circle,
                          //         color: Colors.white70,
                          //         boxShadow: [
                          //           BoxShadow(
                          //             color: Color(0xFFfae3e2),
                          //             blurRadius: 25.0,
                          //             offset: Offset(0.0, 0.75),
                          //           ),
                          //         ]),
                          //     child: Icon(
                          //       Icons.near_me,
                          //       color: Color(0xFFfb3132),
                          //       size: 16,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(left: 5, top: 5),
                            child: Text(category,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                            child: Text(
                                NumberFormat.currency(
                                        locale: 'id',
                                        symbol: 'Rp ',
                                        decimalDigits: 0)
                                    .format(price),
                                style: TextStyle(
                                    color: Color(0xFF6e6e71),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
