import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../config/constants.dart';
import '../../model/left_cate_model.dart';
import '../../model/right_cate_model.dart';
import '../../utils/screen_utils.dart' as sc_utils;

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin{
  int _currentSelectedIndex = 0;
  List<LeftCateResultModel> _leftCateModeResult = [];
  List<RightCateResultModel> _rightCateResultModel = [];

  @override
  void initState() {
    super.initState();
    _getCateLeftData();
  }

  void _getCateLeftData() async {
    String url = Constants.ROOT_URL + "api/pcate";
    var result = await Dio().get(url);
    setState(() {
      this._leftCateModeResult = LeftCateModel.fromJson(result.data).result;
      _getCateRightData(this._leftCateModeResult[0].sId.toString());
    });
  }

  void _getCateRightData(String id) async {
    String url = Constants.ROOT_URL + "api/pcate" + "?pid=${id}";
    var result = await Dio().get(url);
    setState(() {
      this._rightCateResultModel = RightCateModel.fromJson(result.data).result;
    });
  }

  @override
  Widget build(BuildContext context) {
    sc_utils.ScreenUtils.init(context);

    var leftWidth = sc_utils.ScreenUtils.getScreenWidth() / 4;
    return Container(
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Container(
              width: leftWidth,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          color: this._currentSelectedIndex == index
                              ? Color.fromRGBO(240, 246, 246, 0.9)
                              : Colors.white,
                          alignment: Alignment.center,
                          height: 60,
                          child: Text(
                            this._leftCateModeResult[index].title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: _currentSelectedIndex == index
                                    ? Colors.redAccent
                                    : Colors.black),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            this._currentSelectedIndex = index;
                            this._getCateRightData(
                                this._leftCateModeResult[index].sId.toString());
                          });
                        },
                      ),
                      Divider(
                        height: 1,
                      ),
                    ],
                  );
                },
                itemCount: this._leftCateModeResult.length,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  color: Color.fromRGBO(240, 246, 246, 0.9),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 3/4,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 15),
                      itemBuilder: (context, index) {
                        String picUrl = Constants.ROOT_URL +
                            this
                                ._rightCateResultModel[index]
                                .pic
                                .replaceAll("\\", "/");
                        return Container(
                          child: Column(
                            children: <Widget>[
                              Image.network(
                                picUrl,
                                fit: BoxFit.cover,
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    _rightCateResultModel[index].title,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          color: Colors.white,
                        );
                      },
                      itemCount: this._rightCateResultModel.length,
                    ),
                  )),
            ),
          ],
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
