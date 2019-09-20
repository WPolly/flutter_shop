import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../utils/screen_utils.dart' as sc_utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _generateSwiper() {
    List<String> imgList = [
      "https://www.itying.com/images/flutter/slide01.jpg",
      "https://www.itying.com/images/flutter/slide02.jpg",
      "https://www.itying.com/images/flutter/slide03.jpg",
    ];

    return Container(
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: Swiper(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              imgList[index],
              fit: BoxFit.cover,
            );
          },
          pagination: SwiperPagination(),
          autoplay: true,
          autoplayDelay: 5000,
        ),
      ),
    );
  }

  Widget _titleWidget(String value) {
    return Container(
      height: sc_utils.ScreenUtils.getHeight(52),
      margin: EdgeInsets.only(left: sc_utils.ScreenUtils.getWidth(25)),
      padding: EdgeInsets.only(left: sc_utils.ScreenUtils.getWidth(20)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: Colors.red,
                  width: sc_utils.ScreenUtils.getWidth(10)))),
      child: Text(
        value,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }

  Widget _likedProductList() {
    return Container(
        height: sc_utils.ScreenUtils.getHeight(240),
        padding: EdgeInsets.only(
            left: 10,
            right: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                Container(
                  width: sc_utils.ScreenUtils.getWidth(150),
                  height: sc_utils.ScreenUtils.getHeight(150),
                  margin:
                      EdgeInsets.only(right: sc_utils.ScreenUtils.getWidth(20)),
                  child: Image.network(
                    "https://www.itying.com/images/flutter/hot${index + 1}.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(sc_utils.ScreenUtils.getWidth(5)),
                  child: Text("第${index + 1}条"),
                )
              ],
            );
          },
          itemCount: 10,
        ));
  }

  Widget _hotRecItem() {
    double width = (sc_utils.ScreenUtils.getScreenWidth() - 30) / 2;
    return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black38,
          width: 2
        )
      ),
      child: Column(
        children: <Widget>[
          Image.network("https://www.itying.com/images/flutter/list1.jpg", fit: BoxFit.cover,)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    sc_utils.ScreenUtils.init(context);

    return ListView(
      children: <Widget>[
        _generateSwiper(),
        SizedBox(height: sc_utils.ScreenUtils.getHeight(20)),
        _titleWidget("猜你喜欢"),
        SizedBox(height: sc_utils.ScreenUtils.getHeight(20)),
        _likedProductList(),
        _titleWidget("热门推荐"),

        Padding(padding: EdgeInsets.all(10),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _hotRecItem(),
              _hotRecItem(),
              _hotRecItem(),
              _hotRecItem(),
              _hotRecItem(),
              _hotRecItem(),
              _hotRecItem(),
              _hotRecItem(),
              _hotRecItem(),
              _hotRecItem(),
              _hotRecItem(),
              _hotRecItem(),
            ],
          ),
        ),

      ],
    );
  }
}
