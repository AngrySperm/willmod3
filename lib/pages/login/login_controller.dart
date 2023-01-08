import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:willmod3/configs/myapp.dart';
import 'package:willmod3/configs/mydio.dart';
import 'package:willmod3/globals/globalwidget.dart';
import 'package:willmod3/models/appuser.dart';

class WiljosLoginController extends GetxController {
  String userId = "";

  String password = "";
  RxBool passwordVisible = RxBool(false);

  TextEditingController phoneCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  LocalAuthentication auth = LocalAuthentication();
  _SupportState supportState = _SupportState.unknown;
  bool? canCheckBiometrics;
  List<BiometricType>? availableBiometrics;
  String authorized = "Not Authorized";
  bool isAuthenticating = false;

  String? apiUrl;

  @override
  void onInit() {
    passwordVisible.value = false;

    super.onInit();
  }

  @override
  void onReady() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String stringDataUser = preferences.getString("datauser") ?? "";
    if (stringDataUser != "") {
      Map<String, dynamic> datauser = jsonDecode(stringDataUser);
      userId = datauser['username'];
      phoneCon.text = userId;
    }

    // phoneFocusNode.requestFocus();
    super.onReady();
  }

  @override
  void onClose() {
    phoneCon.dispose();
    passwordCon.dispose();

    super.onClose();
  }

  switchPasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  login(VoidCallback _onSuccess) async {
    if (userId.isEmpty) {
      showMessage("User id is empty");
    } else if (password.isEmpty) {
      showMessage("Password is empty");
    } else {
      try {
        EasyLoading.show(status: 'Loading...');

        onBeforeLogin();

        var myDio = Get.put(MyDio());
        var myApp = Get.put(MyApp());

        final body = {'username': '$userId', 'password': '$password'};
        final response = await myDio
            .request(MyDio.REQ_POST_NO_AUTH, getApiUrl(), body: body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> data = response.data;
          var token = data['access_token'];
          var userRawData = data['user'];
          var user = AppUser.fromJson(data['user']);

          Map<String, dynamic> userData = {
            'username': user.userId,
            'password': user.password,
          };

          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString("datauser", jsonEncode(body));

          myDio.successLogin(token);
          myApp.appUser = user;
          myApp.appUser!.userData = userRawData;

          _onSuccess();
          onLoginSuccess();
          EasyLoading.dismiss();
        } else {
          showMessage("User id and password do not match");
          EasyLoading.dismiss();
        }
      } on TimeoutException catch (_) {
        showMessage("Could not connect to server");
        EasyLoading.dismiss();
      }
    }
  }

  Future biometricAuthentication() async {
    if (supportState == _SupportState.unknown) {
      auth.isDeviceSupported().then((bool isSupported) => supportState =
          isSupported ? _SupportState.supported : _SupportState.unsupported);
    }

    if (supportState == _SupportState.unsupported) {
      showMessage("Biometric authentication is not available");
      return;
    }

    if (supportState == _SupportState.supported) {
      biometricLogin();
    }
  }

  Future biometricLogin() async {
    bool authenticated = false;
    try {
      isAuthenticating = true;
      authorized = "Authenticating";
      authenticated = await auth.authenticate(
        localizedReason: "Scan your fingerprint to authenticate",
        options: const AuthenticationOptions(
            useErrorDialogs: true, stickyAuth: true, biometricOnly: true),
      );
      isAuthenticating = false;
      authorized = "Authenticating";
    } on PlatformException catch (e) {
      print(e);
      isAuthenticating = false;
      authorized = "Error - ${e.message} ";
    }

    if (authenticated) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String stringDataUser = preferences.getString("datauser") ?? "";
      if (stringDataUser != "") {
        Map<String, dynamic> datauser = jsonDecode(stringDataUser);
        password = datauser['password'];
        passwordCon.text = password;

        login(() {
          userId = "";
          password = "";
          phoneCon.text = "";
          passwordCon.text = "";
        });
      }
    }
  }

  // methods to overwrite

  void onBeforeLogin() {}

  void onLoginSuccess() {}

  String getApiUrl() {
    return 'login';
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
