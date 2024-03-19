import 'package:get/get.dart';

class MyHomeController extends GetxController {
  bool isVerified = true;

  // Getter for productid
  // int? get productId => _productId.value;

  // Updater for productid
  void updateVerification(bool value) {
    isVerified = value;
    update();
  }
}
