import 'package:get/get.dart';
import 'package:jewellery/view/Allapiclass/apihelper.dart';
import 'package:jewellery/view/home/jewellerydetailsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailsController extends GetxController {
  // Define your variables and properties here
  int? _productId;

  // Getter for productid
  int? get productId => _productId!;

  String dropdownvalue = '1';
  List<dynamic>? quantityList = [];
  List<bool>? isSelectedList = [];
  dynamic? listToSend = {};

  JewelleryDetailsModel? jewellerydetailsmodel;
  String? size;
  String? userId;

@override
  void onClose() {
    // Dispose of your variables here
    _productId = null;
    quantityList = null;
    isSelectedList = null;
    listToSend = null;
    jewellerydetailsmodel = null;
    size = null;
    userId = null;
    update();
    super.onClose();
  }
  // Updater for productid
  Future<void> updateProductId(int? value) async {
    isloading = true;
    _productId = value!;
    update();

    await jewellerydetailslist();
    await getUserDetails();
  }

  Future<bool> clearFields() async {
    // Dispose of your variables here
    _productId = null;
    quantityList = [];
    isSelectedList = [];
    listToSend = [];
    jewellerydetailsmodel = null;
    size = null;
    userId = null;
    update();
    return true;
  }

  Future<void> getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = await prefs.getInt('id').toString();
    update();
    print("user id : ====>>>> ${userId}");
    // setState(() {
    //   // isLoading = true;
    // });
  }

  Future<void> jewellerydetailslist() async {
    jewellerydetailsmodel =
        await ApiHelper.jewellerydetailsclass(_productId as int);
    jewellerydetailsmodel!.data!.variations!.forEach((element) {
      // {"variant": element.type, "quantity": 0}
      quantityList!.add(0);
      isSelectedList!.add(false);
    });
    isloading = false;
    update();
    // setState(() {
    //   isloading = false;
    // });
  }

  // List of items in our dropdown menu
  var items = [
    '1',
    '2',
    '3',
    '4',
    '5',
  ];
  bool isloading = false;
  int currentIndex = 0;
  void updateCurrentIndex(int index) {
    currentIndex = index;
  }

  void incrementVariant(var element) {
    quantityList![jewellerydetailsmodel!.data!.variations!.indexOf(element)]++;
    update();
  }

  void decrementVariant(var element) {
    if (quantityList![
            jewellerydetailsmodel!.data!.variations!.indexOf(element)] ==
        0) return;
    quantityList![jewellerydetailsmodel!.data!.variations!.indexOf(element)]--;
    update();
  }

  void updateVartionTrue(var element) {
    isSelectedList![jewellerydetailsmodel!.data!.variations!.indexOf(element)] =
        true;
    update();
  }

  void updateVartionFalse(var element) {
    isSelectedList![jewellerydetailsmodel!.data!.variations!.indexOf(element)] =
        false;
    update();
  }

  void updateLoading(bool val) {
    isloading = val;
    update();
  }

  @override
  void onInit() {
    //  _productId = null;
    // quantityList = null;
    // isSelectedList = null;
    // listToSend = null;
    // jewellerydetailsmodel = null;
    // size = null;
    // userId = null;
    update();
    // Called when the controller is initialized
    super.onInit();
    // Place your initialization logic here
  }
}
