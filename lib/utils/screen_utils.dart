import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtils {
    static void init(context) {
        ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    }


    static double getScreenWidth() {
        return ScreenUtil.screenWidthDp;
    }

    static double getScreenHeight() {
        return ScreenUtil.screenHeightDp;
    }

    static double getWidth(double width) {
        return ScreenUtil.getInstance().setWidth(width);
    }

    static double getHeight(double height) {
        return ScreenUtil.getInstance().setHeight(height);
    }
}