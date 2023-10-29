import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectivity {
  final Connectivity _connectivity;

  InternetConnectivity() : _connectivity = Connectivity();

  Future<bool> checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
