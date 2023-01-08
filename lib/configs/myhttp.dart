import 'package:shared_preferences/shared_preferences.dart';

class MyHttp {
  static String token = "";

  static String getRequestUriTxt( String suffix ){
    // return 'http://192.168.0.144:3100/${suffix}';
    // return 'http://10.0.2.2:3100/${suffix}';
    return 'http://103.247.10.76:3100/${suffix}';
  }

  static Uri getRequestUri( String suffix ) {
    return Uri.parse(getRequestUriTxt(suffix));
  }

  static Future<String> getToken() async {
    if( MyHttp.token.isNotEmpty )
      return MyHttp.token;
    else{
      SharedPreferences prefs2 = await SharedPreferences.getInstance();
      String token = prefs2.getString("token") ?? "";
      return token;
    }
  }

  static saveTokenLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", '${MyHttp.token}');
  }
}