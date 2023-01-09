// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:willmod3/configs/constant.dart' as c;
import 'package:willmod3/configs/myapp.dart';
import 'package:willmod3/willmod3_platform_interface.dart';

class WillMod3 {
  static init({
    String? apiUrl,
    String? txtNamaAplikasi,
    String? picBgBottomOnly,
    String? picBgDrawer,
    String? picBgDrawerHeader,
    String? picBg,
    String? pathLogo,
    String? logo,
    String? logoKecil,
    String? logoRokok,
    MaterialColor? colorPrimary,
    MaterialColor? colorSecondary,
  }) {
    /*******************/

    MyApp myApp = Get.put(MyApp());
    myApp.apiUrl = apiUrl!;

    /*variable provider*/
    c.WiljosConstant constant = Get.put(c.WiljosConstant());

    /*text*/
    constant.txtNamaAplikasi = txtNamaAplikasi ?? constant.txtNamaAplikasi;

    /*image*/
    constant.picBgBottomOnly = picBgBottomOnly ?? constant.picBgBottomOnly;
    constant.picBgDrawer = picBgDrawer ?? constant.picBgDrawer;
    constant.picBgDrawerHeader =
        picBgDrawerHeader ?? constant.picBgDrawerHeader;
    constant.picBg = picBg ?? constant.picBg;
    constant.pathLogo = pathLogo ?? constant.pathLogo;
    constant.logo = logo ?? constant.logo;
    constant.logoKecil = logoKecil ?? constant.logoKecil;
    constant.logoRokok = logoRokok ?? constant.logoRokok;

    /*color*/
    constant.colorPrimary = colorPrimary ?? constant.colorPrimary;
    constant.colorSecondary = colorSecondary ?? constant.colorSecondary;
  }

  Future<String?> getPlatformVersion() {
    return Willmod3Platform.instance.getPlatformVersion();
  }
}
