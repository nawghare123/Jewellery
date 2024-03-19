import 'package:get/get.dart';
import 'package:jewellery/view/Allapiclass/apihelper.dart';
import 'package:jewellery/view/home/jewellerydetailsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JwelleryPageController extends GetxController {
  List<String> selectedOptionsBrandList = []; // List to store selected options

  List<String> stringListDropDownBrandList = [];

  void replaceBrandList(List<String> list) {
    stringListDropDownBrandList = list;
    update();
  }

  void addSelectedOptionBrandList(String item) {
    selectedOptionsBrandList.add(item);
    update();
  }

  void removeSelectedOptionBrandList(String item) {
    selectedOptionsBrandList.remove(item);
    update();
  }

  // karat
  List<String> selectedOptionsKtList = []; // List to store selected options

  List<String> stringListDropDownKtList = [];

  void replaceKtList(List<String> list) {
    stringListDropDownKtList = list;
    update();
  }

  void addSelectedOptionKtList(String item) {
    selectedOptionsKtList.add(item);
    update();
  }

  void removeSelectedOptionKtList(String item) {
    selectedOptionsKtList.remove(item);
    update();
  }

  @override
  void onClose() {
    selectedOptionsKtList = [];
    stringListDropDownKtList = [];
    selectedOptionsBrandList = [];
    stringListDropDownBrandList = [];
    update();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
