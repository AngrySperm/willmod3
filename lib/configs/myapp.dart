import 'package:intl/intl.dart';
import 'package:willmod3/models/appuser.dart';
import 'package:intl/intl.dart' as intl;

class MyApp {
  AppUser? appUser;
  static int TIMEOUT_DURATION_SECOND = 15;
  static intl.NumberFormat NUMBER_FORMAT = intl.NumberFormat.decimalPattern();
  String apiUrl = "";

  static DateFormat TIME_FORMAT = DateFormat("HH.mm");
  static DateFormat DATE_FORMAT = DateFormat("dd/MM/yyyy");
  static DateFormat DATE_TIME_FORMAT = DateFormat("dd/MM/yyyy  HH.mm");

  String getHostUrl() {
    return apiUrl.replaceAll("/api/", "");
  }

  Future<String> getApiUrl() async {
    // if (apiUrl.isEmpty) {
    //   await loadEnvFile();
    // }
    return apiUrl;
  }

  // Future<void> loadEnvFile() async {
  //   await dotenv.load(fileName: '.env');
  //   apiUrl = dotenv.get('API_URL');
  // }
}
