import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../utils/screen_utils.dart' as sc_utils;
import '../../config/constants.dart';
import '../../model/banner_list_model.dart' as banner;
import '../../model/hot_product_list_model.dart' as product;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{

  List<banner.Result> _bannerList = [];
  List<product.Result> _hotProductList = [];
  List<product.Result> _bestProductList = [];

  @override
  void initState() {
    super.initState();
    _getBannerList();
    _getHotProductList();
    _getBestProductList();
  }

  void _getBannerList() async {
    String url = "${Constants.ROOT_URL}api/focus";
    var result = await Dio().get(url);
    var bannerList = banner.BannerListModel.fromJson(result.data);
    setState(() {
      this._bannerList = bannerList.result;
    });
  }

  void _getHotProductList() async {
    String  url = Constants.ROOT_URL+"api/plist?is_hot=1";
    var result = await Dio().get(url);
    var hotProductList = product.HotProductListModel.fromJson(result.data);
    setState(() {
      this._hotProductList = hotProductList.result;
    });
  }

  void _getBestProductList() async {
    String  url = Constants.ROOT_URL+"api/plist?is_best=1";
    var result = await Dio().get(url);
    var bestProductList = product.HotProductListModel.fromJson(result.data);
    setState(() {
      this._bestProductList = bestProductList.result;
    });
  }

  Widget _generateSwiper() {

    return Container(
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: Swiper(
          itemCount: this._bannerList.length,
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              Constants.ROOT_URL+this._bannerList[index].pic.replaceAll("\\", "/"),
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
        padding: EdgeInsets.only(left: 10, right: 10),
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
                    Constants.ROOT_URL+this._hotProductList[index].sPic.replaceAll("\\", "/"),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.all(sc_utils.ScreenUtils.getWidth(7)),
                  child: Text("¥"+this._hotProductList[index].price.toString(), style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 12,
                  ),),
                ),
              ],
            );
          },
          itemCount: this._hotProductList.length,
        ));
  }

  Widget _hotRecItem(product.Result product) {
    double width = (sc_utils.ScreenUtils.getScreenWidth() - 30) / 2;
    return Container(
      width: width,
      padding: EdgeInsets.all(5),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black26, width: 0.5)),
      child: Column(
        children: <Widget>[
          Image.network(
            Constants.ROOT_URL+product.pic.replaceAll("\\", "/"),
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 12
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("¥"+ product.price.toString(), style: TextStyle(
                        color: Colors.red,
                        fontSize: 12
                    ),),
                    Text("¥"+ product.oldPrice, style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                    ),),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _hotRecItems() {
    List<Widget> result = [];
    for (var value in this._bestProductList) {
      result.add(_hotRecItem(value));
    }
    return result;
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
        Padding(
          padding: EdgeInsets.all(10),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: this._hotRecItems(),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
