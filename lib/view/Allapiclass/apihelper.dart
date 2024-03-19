import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jewellery/baseurl/baseurl.dart';
import 'package:jewellery/otp.dart';
import 'package:jewellery/until/app_constant.dart';
import 'package:jewellery/view/ContactusModel.dart';
import 'package:jewellery/view/Login/Login.dart';
import 'package:jewellery/view/Login/LoginModel.dart';
import 'package:jewellery/view/Signup/Signupmodel.dart';
import 'package:jewellery/view/Signup/cityModel.dart';
import 'package:jewellery/view/Signup/createprofilesecond.dart';
import 'package:jewellery/view/Signup/stateModel.dart';
import 'package:jewellery/view/blogModel.dart';
import 'package:jewellery/view/getCartModel.dart';
import 'package:jewellery/view/home/BannerModel.dart';
import 'package:jewellery/view/home/UpdateProfileModel.dart';
import 'package:jewellery/view/home/addToCartModel.dart';
import 'package:jewellery/view/home/brandModel.dart';
import 'package:jewellery/view/home/catalogueModel.dart';
import 'package:jewellery/view/home/categoriesModel.dart';
import 'package:jewellery/view/home/jewellerydetailsModel.dart';
import 'package:jewellery/view/home/latestModel.dart';
import 'package:jewellery/view/home/notificationModel.dart';
import 'package:jewellery/view/orderModel.dart';
import 'package:jewellery/view/orderModelList.dart';
import 'package:jewellery/view/rooturl.dart';
import 'package:jewellery/view/wishlistModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {
  static Future<CategoryModel?> categoreyclass(int id) async {
    var url = "$Baseurl/api/v1/categories/childes/$id";
    var request = http.Request('GET', Uri.parse(url));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final jsonStudent = jsonDecode(await response.stream.bytesToString());
      // print(await response.stream.bytesToString());
      return CategoryModel.fromJson(jsonStudent);
    } else {
      return CategoryModel();
      //  print(response.reasonPhrase);
    }
  }

  static Future<LoginModel?> userlogin(
      String mobile, String password, BuildContext context) async {
    Map fields = {'phone': mobile, 'password': password};
    print(fields);
    var url = "$Baseurl/api/v1/auth/login?phone=$mobile&password=$password";
    var request = await http.post(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Content-type": "application/json"
      },
      // body: jsonEncode(fields),
    );
    // var request = await http.Request(
    //     'POST',
    //     Uri.parse(
    //         'https://veejayjewels.com/api/v1/auth/login?phone=$mobile&password=$password'));

    var b = jsonDecode(request.body);
    LoginModel? loginModel;
    loginModel = LoginModel.fromJson(b);
    if (request.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('login', 'Success');

      print(request.body);

      await prefs.setInt('id', loginModel.data!.id ?? 1);
      await prefs.setString('first_name', loginModel.data!.fName ?? "Guest");
      await prefs.setString('last_name', loginModel.data!.lName ?? "Guest");
      await prefs.setString(
          'email', loginModel.data!.email ?? "guest@gmail.com");
      await prefs.setString('image', loginModel.data!.image ?? "Guest");
      await prefs.setString('address', loginModel.data!.address ?? "Guest");
      print("======>>>>> address : ${loginModel.data!.address}");
      await prefs.setInt(
          'is_phone_verified', loginModel.data!.isPhoneVerified ?? 0);
      await prefs.setString('phone', loginModel.data!.phone ?? "Guest");
      await prefs.setString('role', loginModel.data!.role ?? "Guest");
      await prefs.setString('status', loginModel.data!.status ?? "Guest");
      print("======>>>>> Login Success : ${loginModel}");
      Navigator.push(context, MaterialPageRoute(builder: (context) => Otp()));

      print("login");

      // print(jsonStudent);
      return LoginModel.fromJson(b);
    } else {
      final snack = SnackBar(content: Text(b['errors'][0]["message"]));
      ScaffoldMessenger.of(context).showSnackBar(snack);
      print(request.body);
    }
  }

  static Future<void> placeOrder(
    String userId,
    String address,
    List<dynamic> cart,
  ) async {
    // "cart": [
    //     {"product_id": 1, "quantity": 3, "variantion": "13"},
    //     {"product_id": 1, "quantity": 3, "variantion": "80"}
    //   ]
    var headers = {'Content-Type': 'application/json'};
    var body = {"user_id": userId, "delivery_address": address, "cart": cart};
    print("body: ===>>>> ${body}");
    var request = http.Request(
        'POST', Uri.parse('https://veejayjewels.com/api/v1/products/place'));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("Response : ====>>>> " + await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<OrderModel?> getOrdersList(String userId) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://veejayjewels.com/api/v1/products/list'));
    var body = {"id": "$userId"};
    print(body);
    request.body = json.encode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    print(res);
    if (response.statusCode == 200) {
      OrderModel orderModel = OrderModel.fromJson(json.decode(res));

      return orderModel;
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<BrandModel?> brandclass() async {
    var url = "http://veejayjewels.com/api/v1/categories";
    final response = await http.get(
      Uri.parse(url),
    );
    print("brand====");
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      final jsonStudent = jsonDecode(response.body);
      return BrandModel.fromJson(jsonStudent);
    } else if (response.statusCode == 404) {
      return BrandModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      return BrandModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      return BrandModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }

  static Future<JewelleryDetailsModel> jewellerydetailsclass(int id) async {
    var url = "$Baseurl/api/v1/products/details/$id";

    final response = await http.get(
      Uri.parse(url),
    );

    print(
        "Url (${url}) ====>>>>> Product Details Response ${jsonDecode(response.body)}");
    if (response.statusCode == 200) {
      final jsonStudent = jsonDecode(response.body);
      return JewelleryDetailsModel.fromJson(jsonStudent);
    } else if (response.statusCode == 404) {
      return JewelleryDetailsModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      return JewelleryDetailsModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      return JewelleryDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }

  static Future<LatestModel?> latestclass() async {
    var url = "$Baseurl/api/v1/products/latest";
    final response = await http.get(
      Uri.parse(url),
    );

    // print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      final jsonStudent = jsonDecode(response.body);
      return LatestModel.fromJson(jsonStudent);
    } else if (response.statusCode == 404) {
      return LatestModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      return LatestModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      return LatestModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }

  static Future<AddToCardModel?> addToCart(dynamic data) async {
    var request = http.MultipartRequest('POST',
        Uri.parse('https://veejayjewels.com/api/v1/products/add_to_card'));
    var body = {
      'user_id': '${data["data"]["user-id"]}',
      'product_id': '${data["data"]["product-id"]}',
      'product_name': '${data["data"]["product-name"]}',
      'variant': '${data["variants"]}',
      'image': '${data["data"]["product-image"]}'
    };
    print(body);
    request.fields.addAll(body);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<GetCardModel?> getCartList() async {
    var request = http.Request(
        'GET', Uri.parse('https://veejayjewels.com/api/v1/products/card'));

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      // print();
      GetCardModel? getCardModel = GetCardModel.fromJson(json.decode(res));
      return getCardModel;
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<OrderModelList?> getOrderList(String orderId) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET', Uri.parse('https://veejayjewels.com/api/v1/products/details'));
    request.body = json.encode({"id": "$orderId"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      // print();
      OrderModelList orderModelList = OrderModelList.fromJson(json.decode(res));
      return orderModelList;
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<CatalogueModel?> getCatList() async {
    var request = http.Request(
        'GET', Uri.parse('https://veejayjewels.com/api/v1/auth/catalogue'));

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      CatalogueModel catalogueModel = CatalogueModel.fromJson(json.decode(res));
      return catalogueModel;
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<BannerModel?> bannerclass() async {
    var url = "$Baseurl/api/v1/banners1";
    final response = await http.get(
      Uri.parse(url),
    );

    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      final jsonStudent = jsonDecode(response.body);
      return BannerModel.fromJson(jsonStudent);
    } else if (response.statusCode == 404) {
      return BannerModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      return BannerModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      return BannerModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }

  static Future<CityModel?> cityclass(
      String state, BuildContext context) async {
    Map fields = {
      'state': state,
    };
    print(fields);
    // String token = pref.getString('token')??'';

    var url = "$Baseurl/api/v1/auth/city";
    var request = await http.post(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-type": "application/json"
        },
        body: jsonEncode(fields));

    var b = jsonDecode(request.body);
    if (request.statusCode == 200) {
      CityModel? cityModel;

      print(request.body);
      cityModel = CityModel.fromJson(b);
      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));

      print("city***");

      return CityModel.fromJson(b);
    } else {
      final snack = SnackBar(content: Text(b['errors'][0]["message"]));
      ScaffoldMessenger.of(context).showSnackBar(snack);
      print(request.body);
    }
  }

  static Future<StateListModel?> stateclass() async {
    var url = "$Baseurl/api/v1/auth/state";
    var response = await http.get(
      Uri.parse(url),
    );

    var b = jsonDecode(response.body);
    if (response.statusCode == 200) {
      StateListModel? stateModel;

      print(response.body);
      stateModel = StateListModel.fromJson(b);

      print("state");
      // print(jsonStudent);
      return StateListModel.fromJson(b);
    } else {
      final snack = SnackBar(content: Text(b['errors'][0]["message"]));

      print(response.body);
    }
  }

  static Future<void> updateProfile(
    String fName,
    String lName,
    String email,
    String phone,
    String state,
    String city,
    String address,
    String pincode,
    var imagePath,
    String id,
  ) async {
    var request = http.MultipartRequest('POST',
        Uri.parse('https://veejayjewels.com/api/v1/customer/update-profile'));
    var body = {
      'f_name': '$fName',
      'l_name': '$lName',
      'email': '$email',
      'phone': '$phone',
      'state': '$state',
      'city': '$city',
      'address': '$address',
      'pincode': '$pincode',
      'id': '$id'
    };
    print(body);
    print(imagePath);
    request.fields.addAll(body);
    request.files.add(await http.MultipartFile.fromPath('image', '$imagePath'));

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    print(res);
    if (response.statusCode == 200) {
      UpdateProfileModel userModel =
          UpdateProfileModel.fromJson(json.decode(res));

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // await prefs.setInt('id', userModel.data!.id ?? 1);
      await prefs.setString('first_name', userModel.data!.fName ?? "Guest");
      await prefs.setString('last_name', userModel.data!.lName ?? "Guest");
      await prefs.setString(
          'email', userModel.data!.email ?? "guest@gmail.com");
      await prefs.setString('image', userModel.data!.image ?? "Guest");
      await prefs.setString('state', userModel.data!.state ?? "");
      await prefs.setString('city', userModel.data!.city ?? "");
      await prefs.setString('address', userModel.data!.address ?? "");
      await prefs.setString('pincode', userModel.data!.pincode ?? "");
      await prefs.setString('phone', userModel.data!.phone ?? "Guest");
      // await prefs.setString('role', userModel.data!.role ?? "Guest");
      print(await prefs.getString('address'));
    } else {
      print(response.reasonPhrase);
    }
  }


  static Future<void> updateProfileAdd(
    String fName,
    String lName,
    String email,
    String phone,
    String state,
    String city,
    String address,
    String pincode,
    // String imagePath,
    String id,
  ) async {
    var request = http.MultipartRequest('POST',
        Uri.parse('https://veejayjewels.com/api/v1/customer/update-profile'));
    var body = {
      'f_name': '$fName',
      'l_name': '$lName',
      'email': '$email',
      'phone': '$phone',
      'state': '$state',
      'city': '$city',
      'address': '$address',
      'pincode': '$pincode',
      'id': '$id'
    };
    print(body);
    // print(imagePath);
    request.fields.addAll(body);
    // request.files.add(await http.MultipartFile.fromPath('image', '$imagePath'));

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    print(res);
    if (response.statusCode == 200) {
      UpdateProfileModel userModel =
          UpdateProfileModel.fromJson(json.decode(res));

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // await prefs.setInt('id', userModel.data!.id ?? 1);
      await prefs.setString('first_name', userModel.data!.fName ?? "Guest");
      await prefs.setString('last_name', userModel.data!.lName ?? "Guest");
      await prefs.setString(
          'email', userModel.data!.email ?? "guest@gmail.com");
      await prefs.setString('image', userModel.data!.image ?? "Guest");
      await prefs.setString('state', userModel.data!.state ?? "");
      await prefs.setString('city', userModel.data!.city ?? "");
      await prefs.setString('address', userModel.data!.address ?? "");
      await prefs.setString('pincode', userModel.data!.pincode ?? "");
      await prefs.setString('phone', userModel.data!.phone ?? "Guest");
      // await prefs.setString('role', userModel.data!.role ?? "Guest");
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<void> customOrder({
    required String title,
    required String size,
    required String quantity,
    required String date,
    required String description,
    required String userId,
    required String imagePath,
  }) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://veejayjewels.com/api/v1/auth/custom_order'));
    request.fields.addAll({
      'title': '$title',
      'size': '$size',
      'quantity': '$quantity',
      'need_product': '$date',
      'description': '$description',
      'user_id': '$userId'
    });
    request.files.add(await http.MultipartFile.fromPath('image', '$imagePath'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<String> addToWishList(String? userId, String? productId) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://veejayjewels.com/api/v1/customer/wish-list/add-to-wishlist'));
    request.fields.addAll({'product_id': '$productId', 'id': '$userId'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return "Item added in your wishlist";
    } else if (response.statusCode == 409) {
      print(await response.stream.bytesToString());
      return "Already in your wishlist";
    } else {
      return "Something went Wrong";
      print(response.reasonPhrase);
    }
  }

  static Future<WishlistModel?> getWishList(String userId) async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://veejayjewels.com/api/v1/customer/wish-list/wishlist/$userId'));

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      print(userId);
      // print(res);
      // print(await response.stream.bytesToString());
      WishlistModel wishlistModel = WishlistModel();
      wishlistModel = WishlistModel.fromJson(json.decode(res));
      // print(wishlistModel);
      // wishlistModel.wishlist![0].forEach((element) {
      //   print(element.id);
      // });
      return wishlistModel;
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<void> removeFromWishList(String itemId) async {
    var request = http.Request(
        'DELETE',
        Uri.parse(
            'https://veejayjewels.com/api/v1/customer/wish-list/remove-wishlist/$itemId'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<NotificationModel?> getNotifications() async {
    var request = http.Request(
        'GET', Uri.parse('https://veejayjewels.com/api/v1/notifications'));

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      NotificationModel notificationModel =
          NotificationModel.fromJson(json.decode(res));
      notificationModel!.data!
          .map((e) => print("====== notification >>>>>>>> ${e.title!}"));
      return notificationModel;
      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<BlogModel?> getBlogs() async {
    var request = http.Request(
        'GET', Uri.parse('https://veejayjewels.com/api/v1/auth/blog'));

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      BlogModel? blogModel = BlogModel.fromJson(json.decode(res));
      return blogModel;
      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<SignUpModel?> usersignup(
      String firstname,
      String lastname,
      String email,
      String mobile,
      String role,
      String password,
      String token,
      String companyname,
      String foundationdate,
      String state,
      String city,
      String address,
      String pincode,
      String gstnumber,
      String upload1,
      String upload2,
      BuildContext context) async {
    //  (role =='user')?

    // if(role == "user"){
    // Map fields = {
    //   'f_name': firstname,
    //   'l_name': lastname,
    //   'email': email,
    //   'phone': mobile,
    //   'role': "seller",
    //   'password': password,
    //   'temporary_token': token,
    //   'company_name': companyname,
    //   'foundation_date': foundationdate,
    //   'state': state,
    //   'city': city,
    //   'address': address,
    //   'pincode': pincode,
    //   'gst_number': gstnumber,
    //   'upload1': upload1,
    //   'upload2': upload2
    // };
    // // }

    // // else{
    // //    Map fields = {
    // //     'f_name': firstname,
    // // 'l_name': lastname,
    // // 'email': email,
    // // 'phone': mobile,
    // // 'role': "seller",
    // // 'password': password,

    // // 'temporary_token':token,
    // // 'company_name':companyname,
    // // 'foundation_date': foundationdate,
    // // 'state':state,
    // // 'city':city,
    // // 'pincode':pincode,
    // // 'gst_number': gstnumber,
    // // 'upload1':upload1,
    // // 'upload2':upload2

    // //   };

    // // }
    // const url = "$Baseurl/api/v1/auth/registration";
    // print(fields);

    // var request = await http.post(Uri.parse(url),
    //     headers: {
    //       "Accept": "application/json",
    //       "Content-type": "application/json"
    //     },
    //     body: jsonEncode(fields));

    // var b = jsonDecode(request.body);
    // print("=========");
    // print(b);

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://veejayjewels.com/api/v1/auth/registration'));
    request.fields.addAll({
      'f_name': firstname,
      'l_name': lastname,
      'email': email,
      'phone': mobile,
      'role': "seller",
      'password': password,
      'temporary_token': token,
      'company_name': companyname,
      'foundation_date': foundationdate,
      'state': state,
      'city': city,
      'address': address,
      'pincode': pincode,
      'gst_number': gstnumber,
    });
    request.files.add(await http.MultipartFile.fromPath('upload1', '$upload1'));
    request.files.add(await http.MultipartFile.fromPath('upload2', '$upload1'));

    http.StreamedResponse response = await request.send();

    var res = jsonDecode(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      SignUpModel? signupmodel;
      print(res);
      signupmodel = SignUpModel.fromJson(res);
      print(role);
      print("ROlE===");

      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));

      // if(role == "user"){
      //   Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
      // }
      // else{

      //   Navigator.push(context, MaterialPageRoute(builder: (context)=> Createprofilesecond()));
      // }
      //  (role == "seller")?
      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Login())):
      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Createprofilesecond()));

      print("Signup");

      return SignUpModel.fromJson(res);
    } else {
      final snack = SnackBar(content: Text(res['errors'][0]["message"]));
      ScaffoldMessenger.of(context).showSnackBar(snack);
      print(res);
    }
  }

  static Future<ContactUsModel?> getcontact() async {
    var request = http.Request('GET',
        Uri.parse('https://veejayjewels.com/api/v1/products/contact_detail'));

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      ContactUsModel? contactusModel =
          ContactUsModel.fromJson(json.decode(res));
      return contactusModel;
      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
