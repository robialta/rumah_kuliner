import 'package:flutter/material.dart';
import 'package:rumah_kuliner/common/app_color.dart';

class TopMenus extends StatefulWidget {
  @override
  _TopMenusState createState() => _TopMenusState();
}

class _TopMenusState extends State<TopMenus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColor.primaryColor,
      padding: EdgeInsets.all(5),
      // height: 100,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // scrollDirection: Axis.horizontal,
        children: <Widget>[
          // Expanded(
          //     flex: 1,
          //     child:
          TopMenuTiles(name: "Makanan", imageUrl: "makanan.jpg", slug: ""),
          //         ),
          // Expanded(
          //     flex: 1,
          //     child:
          TopMenuTiles(name: "Minuman", imageUrl: "minuman.jpg", slug: ""),
          //         ),
          // Expanded(
          //     flex: 1,
          //     child:
          TopMenuTiles(
              name: "Makanan khas", imageUrl: "makanan_khas.png", slug: ""),
          // ),
          // Expanded(
          //     flex: 1,
          //     child:
          TopMenuTiles(
              name: "Minuman khas", imageUrl: "minuman_khas.png", slug: ""),
          // ),
        ],
      ),
    );
  }
}

class TopMenuTiles extends StatelessWidget {
  String name;
  String imageUrl;
  String slug;

  TopMenuTiles(
      {Key key,
      @required this.name,
      @required this.imageUrl,
      @required this.slug})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Container(
            height: 70,
            child: Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              // child:

              // Container(
              //   alignment: Alignment.center,
              //   padding: EdgeInsets.all(10),
              //   child: Container(
              //     width: 50,
              //     // height: 50,
              //     child: Center(
              //         child: Image.asset(
              //       "assets/images/menus/minuman.jpg",
              //       width: 24,
              //       height: 24,
              //     )),
              //   ),
              // )
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(
                "assets/images/menus/$imageUrl",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              name,
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.clip,
            ),
          )
        ],
      ),
    );
  }
}
