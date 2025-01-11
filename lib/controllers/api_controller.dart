import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hicom_partner_admin/pages/sample_page.dart';
import 'package:http/http.dart' as http;
import '../auth/login_page.dart';
import '../auth/verify_page_number.dart';
import '../companents/instrument/instrument_components.dart';
import '../models/auth/countries_model.dart';
import '../models/auth/send_code_model.dart';
import '../models/sample/categories.dart';
import '../models/sample/profile_info_model.dart';
import '../models/sample/reviews_model.dart';
import '../models/sample/sorted_pay_transactions.dart';
import '../not_connection.dart';
import '../resource/colors.dart';
import 'get_controller.dart';
import 'package:http_parser/http_parser.dart';

class ApiController extends GetxController {
  final GetController _getController = Get.put(GetController());

  final  baseUrl = 'http://185.196.213.76:8080/api';

  //return header function
  Map<String, String> headersBearer() {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_getController.token}',
      'Lang': _getController.headerLanguage
    };
  }

  Map<String, String> headerBearer() => {'Authorization': 'Bearer ${_getController.token}'};

  Map<String, String> header() => {'Content': 'application/json'};

  Map<String, String> multipartHeaderBearer() {
    return {
      'Authorization': 'Bearer ${_getController.token}',
      'Content-Type': 'multipart/form-data',
      'Lang': _getController.headerLanguage
    };
  }

  //Auth
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> sendCode() async {
    _getController.sendParam(false);
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/users/login'));
    request.fields['phone'] = _getController.code.value + _getController.phoneController.text;
    request.fields['password'] = '';
    request.fields['restore'] = '0';
    request.headers.addAll(header());

    try {
      var response = await request.send();
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        _getController.sendParam(true);
        var data = jsonDecode(await response.stream.bytesToString());
        if (data['status'] == 0) {
          _getController.changeSendCodeModel(SendCodeModel.fromJson(data));
          _getController.startTimer();
          Get.to(() => const VerifyPageNumber(), transition: Transition.fadeIn);
        } else if (data['status'] == 3){
          //sendCodeRegister();
        }
        else {
          _getController.shakeKey[8].currentState?.shake();
          InstrumentComponents().showToast('Ehhh nimadir xato ketdi'.tr, color: AppColors.red, textColor: AppColors.white);
          debugPrint('Xatolik: ${data['message']}');
        }
      } else {
        _getController.sendParam(true);
        debugPrint('Xatolik: Serverga ulanishda muammo');
      }
    } catch (e, stacktrace) {
      _getController.sendParam(true);
      debugPrint('Xatolik: Serverga ulanishda muammo00');
      debugPrint(stacktrace.toString());
    }
  }

  Future<void> verifyPhone() async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/users/code/confirm'));
    request.headers.addAll(header());
    request.fields['confirmation_id'] = _getController.sendCodeModel.value.result?.confirmationId.toString() ?? '';
    request.fields['code'] = _getController.verifyCodeControllers.text;
    var response = await request.send();
    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      if (data['status'] == 0) {
        _getController.saveToken(data['result']['token']);
        _getController.savePhoneNumber(_getController.code.value + _getController.phoneController.text);
        _getController.errorFieldOk.value = true;
        _getController.errorField.value = true;
        _getController.tapTimes((){
          _getController.errorFieldOk.value = false;
          _getController.errorField.value = false;
          _getController.verifyCodeControllers.clear();
          getProfile();
        }, 1);
        debugPrint('Telefon tasdiqlandi va token olindi: ${data['result']['token']}');
      } else {
        _getController.shakeKey[7].currentState?.shake();
        debugPrint('Xatolik: ${data['message']}');
        _getController.changeErrorInput(0, true);
        _getController.errorField.value = true;
        debugPrint('Xatolik: xaaa0');
        _getController.tapTimes((){debugPrint('Xatolik: xaaa1');_getController.errorField.value = false;_getController.verifyCodeControllers.clear();_getController.changeErrorInput(0, false);}, 1);
      }
    }
  }

  Future<void> getCountries({bool me = false}) async {
    final response = await http.get(Uri.parse('$baseUrl/place/countries'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      debugPrint(response.statusCode.toString());
      if (data['status'] == 0) {
        _getController.changeCountriesModel(CountriesModel.fromJson(data));
        if (me == false) {
          getRegions(_getController.countriesModel.value.countries!.first.id != null ? _getController.countriesModel.value.countries!.first.id! : data['result'].first['id']);
        } else {
          getRegions(_getController.profileInfoModel.value.result!.first.countryId!, me: true);
        }
      } else {
        debugPrint('Xatolik countries 1: ${data['message']}');
      }
    } else {
      debugPrint('Xatolik countries 2: Serverga ulanishda muammo');
    }
  }

  Future<void> getRegions(int countryId, {bool? me = false}) async {
    final response = await http.get(Uri.parse('$baseUrl/place/regions?country_id=$countryId'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 0) {
        _getController.changeRegionsModel(CountriesModel.fromJson(data));
        if (me == false) {
          getCities(_getController.regionsModel.value.regions![_getController.dropDownItems[2]].id != null ? _getController.regionsModel.value.regions![_getController.dropDownItems[2]].id! : data['result'].first['id']);
        } else {
          getCities(_getController.profileInfoModel.value.result!.first.regionId!);
        }
      } else {
        _getController.clearRegionsModel();
        debugPrint('Xatolik region 1: ${data['message']}');
      }
    } else {
      _getController.clearRegionsModel();
      debugPrint('Xatolik region 2: Serverga ulanishda muammo');
    }
  }

  Future<void> getCities(int regionId) async {
    final response = await http.get(Uri.parse('$baseUrl/place/cities?region_id=$regionId'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 0) {
        _getController.dropDownItemsCities.clear();
        _getController.changeCitiesModel(CountriesModel.fromJson(data));
      } else {
        _getController.clearCitiesModel();
        debugPrint('Xatolik cities 1: ${data['message']}');
      }
    } else {
      _getController.clearCitiesModel();
      debugPrint('Xatolik cities 2: Serverga ulanishda muammo');
    }
  }

  Future<void> logout() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users/logout'), headers: headersBearer());
      debugPrint(response.body.toString());
      debugPrint(response.statusCode.toString());
    } catch (e, stacktrace) {
      debugPrint('Xatolik: $e');
      debugPrint(stacktrace.toString());
    }
  }

  //Profile
  Future<void> getProfile({bool isWorker = true}) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users/profile'), headers: headersBearer());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        //debugPrint(data.toString());
        if (data['status'] == 0) {
          _getController.changeProfileInfoModel(ProfileInfoModel.fromJson(data));
          if (isWorker && _getController.profileInfoModel.value.result?.first.firstName == null || _getController.profileInfoModel.value.result?.first.lastName == '') {
            getCountries();
            _getController.updateSelectedDate(DateTime(DateTime.now().year - 18, DateTime.now().month, DateTime.now().day));
            //Get.to(() => const RegisterPage());
          } else if (isWorker) {
            getCountries(me: true);
            //Get.offAll(() => _getController.getPassCode() != '' ? PasscodePage() : CreatePasscodePage());
            Get.offAll(() => SamplePage());
          }
        }
        else if (data['status'] == 4) {
          logout();
          _getController.logout();
          Get.offAll(() => const LoginPage(), transition: Transition.fadeIn);
        }}
      else if (response.statusCode == 401) {
        logout();
        _getController.logout();
        Get.offAll(() => const LoginPage(), transition: Transition.fadeIn);
        return;
      }
      else if (response.statusCode == 404) {
        Get.offAll(() => const NotConnection(), transition: Transition.fadeIn);
        return;
      }
      else {
        Get.offAll(const NotConnection(), transition: Transition.fadeIn);
      }
    } catch(e, stacktrace) {
      debugPrint('bilmasam endi: $e');
      debugPrint(stacktrace.toString());
      Get.offAll(const NotConnection(), transition: Transition.fadeIn);
    }
  }


//Notification
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<void> sendNotification() async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/messaging/notify'));
      request.headers.addAll(headerBearer());
      request.fields['title'] = _getController.titleController.text;
      request.fields['body'] = _getController.bodyController.text;
      if (_getController.dropDownItems[4] == 0) {
        request.fields['fcm_token'] = _getController.tokenController.text;
      }

      print(_getController.tokenController.text);
      if (_getController.dropDownItems[4] == 1) {
        request.fields['user_type'] = _getController.dropDownItems[0].toString();
      }
      if (_getController.dropDownItems[4] == 2) {
        request.fields['country_id'] = _getController.countriesModel.value.countries![_getController.dropDownItems[1]].id.toString();
        request.fields['region_id'] = _getController.regionsModel.value.regions![_getController.dropDownItems[2]].id.toString();
        request.fields['city_id'] = _getController.citiesModel.value.cities![_getController.dropDownItems[3]].id.toString();
      }

      var response = await request.send();
      debugPrint(response.statusCode.toString());
      var responseBody = await response.stream.bytesToString();
      debugPrint(responseBody.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(responseBody);
        if (data['status'] == 0) {
          InstrumentComponents().showToast('Ma\'lumotlar muvaffaqiyatli yuklandi'.tr, color: AppColors.green, textColor: AppColors.white);
        } else {
          _getController.shakeKey[8].currentState?.shake();
          InstrumentComponents().showToast('Ehhh nimadir xato ketdi'.tr, color: AppColors.red, textColor: AppColors.white);
          debugPrint('Xatolik: ${data['message']}');
        }
      }
    } catch (e, stacktrace) {
      debugPrint('Xatolik: $e');
      debugPrint(stacktrace.toString());
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Mahsulot kategoriyalari ro'yxatini olish
  Future<void> getCategories() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/catalog/categories'), headers: headersBearer());
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        debugPrint(data.toString());
        if (data['status'] == 0) {
          _getController.changeCategoriesModel(CategoriesModel.fromJson(data));
          _getController.changeCategories(CategoriesModel.fromJson(data));
          getProducts(0);
        } else {
          debugPrint('Xatolik: ${data['message']}');
        }
      } else {
        debugPrint('Xatolik: Serverga ulanishda muammo');
      }
    } catch (e, stacktrace) {
      debugPrint('Xatolik: $e');
      debugPrint(stacktrace.toString());
    }
  }

  Future<void> addCategory() async {
    try {
      var request = http.MultipartRequest('PUT', Uri.parse('$baseUrl/catalog/categories'));
      request.headers.addAll(multipartHeaderBearer());
      request.fields['name'] = _getController.titleController.text;
      if (_getController.descriptionController.text.isNotEmpty) {
        request.fields['description'] = _getController.descriptionController.text;
      }
      if (_getController.imagePath.value.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromBytes(
            'photo',
            _getController.imagePath.value,
            filename: 'image.png',
            contentType: MediaType('image', 'png')
        ));
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        var data = jsonDecode(await response.stream.bytesToString());
        if (data['status'] == 0) {
          _getController.clearImagePath();
          _getController.clearCategoriesModel();
          getCategories();
          Get.back();
        } else {
          _getController.shakeKey[8].currentState?.shake();
          InstrumentComponents().showToast('Ehhh nimadir xato ketdi'.tr, color: AppColors.red, textColor: AppColors.white);
          debugPrint('Xatolik: ${data['message']}');
        }
      }
    } catch (e, stacktrace) {
      debugPrint('Xatolik: $e');
      debugPrint(stacktrace.toString());
    }
  }

  Future<void> editCategory(int id) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/catalog/categories'));
      request.headers.addAll(multipartHeaderBearer());
      request.fields['id'] = id.toString();
      request.fields['name'] = _getController.titleController.text;
      if (_getController.descriptionController.text.isNotEmpty) {
        request.fields['description'] = _getController.descriptionController.text;
      }
      if (_getController.imagePath.value.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromBytes(
            'photo',
            _getController.imagePath.value,
            filename: 'image.png',
            contentType: MediaType('image', 'png')
        ));
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        var data = jsonDecode(await response.stream.bytesToString());
        if (data['status'] == 0) {
          //_getController.imagePath.value = Uint8List(0);
          _getController.clearImagePath();
          _getController.clearCategoriesModel();
          getCategories();
          Get.back();
        } else {
          _getController.shakeKey[8].currentState?.shake();
          InstrumentComponents().showToast('Ehhh nimadir xato ketdi'.tr, color: AppColors.red, textColor: AppColors.white);
          debugPrint('Xatolik: ${data['message']}');
        }
      }
    } catch (e, stacktrace) {
      debugPrint('Xatolik: $e');
      debugPrint(stacktrace.toString());
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/catalog/categories?id=$id'), headers: headersBearer());
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 0) {
          Get.back();
          getCategories();
        } else {
          debugPrint('Xatolik: ${data['message']}');
        }
      } else {
        debugPrint('Xatolik: Serverga ulanishda muammo');
      }
    } catch (e, stacktrace) {
      debugPrint('Xatolik: $e');
      debugPrint(stacktrace.toString());
    }
  }

  // Mahsulotlar ro'yxatini olish
  Future<void> getProducts(int categoryId, {bool isCategory = true, bool isFavorite = false, filter}) async {
    filter = filter ?? '';
    try {
      String encodedFilter = filter != null && filter.isNotEmpty ? Uri.encodeComponent(filter) : '';
      final response = await http.get(Uri.parse(isFavorite ? '$baseUrl/catalog/favorites${filter != '' ? '?filter=$encodedFilter' : ''}' : '$baseUrl/catalog/products?category_id=$categoryId${filter != '' ? '&filter=$encodedFilter' : ''}'), headers: headersBearer());
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 0) {
          if (isCategory == true) {
            _getController.changeProductsModel(CategoriesModel.fromJson(data));
            isFavorite ? _getController.changeCatProductsModel(CategoriesModel.fromJson(data)) : null;
          } else {
            _getController.changeCatProductsModel(CategoriesModel.fromJson(data));
          }
        } else {
          debugPrint('Xatolik: ${data['message']}');
        }
        if (categoryId == 0 && isFavorite == false) {
          if (filter != null && filter.isNotEmpty) {
            _getController.clearCategoriesProductsModel();
          }
          //getAllCatProducts(filter: encodedFilter != '' ? encodedFilter : null);
        }
      } else {
        debugPrint('Xatolik: Serverga ulanishda muammo');
      }
    } catch (e, stacktrace) {
      debugPrint('Xatolik: $e');
      debugPrint(stacktrace.toString());
    }
  }

  Future<void> getProduct(int categoryId, {bool isCategory = true, filter}) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/catalog/products${isCategory != true ? '?id=$categoryId' : '?category_id=$categoryId'}${filter != null && filter != '' ? '&filter=$filter' : ''}'), headers: headersBearer());
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 0 && data['result'] != null) {
          if (isCategory == true) {
            _getController.addCategoriesProductsModel(CategoriesModel.fromJson(data));
          } else {
            _getController.clearProductsModelDetail();
            _getController.changeProductsModelDetail(CategoriesModel.fromJson(data));
            getReviews(categoryId);
          }
        } else {
          debugPrint('Xatolik: ${data['message']}');
        }
      } else {
        debugPrint('Xatolik: Serverga ulanishda muammo');
      }
    } catch (e, stacktrace) {
      debugPrint('Xatolik: $e');
      debugPrint(stacktrace.toString());
    }
  }

  Future<void> addProduct() async {
    try {
      var request = http.MultipartRequest('PUT', Uri.parse('$baseUrl/catalog/products'));
      request.headers.addAll(multipartHeaderBearer());
      request.fields['name'] = _getController.titleController.text;
      request.fields['category_id'] = '${_getController.dropDownItems[4]+1}';
      request.fields['cashback'] = _getController.cashbackController.text;
      request.fields['warranty'] = _getController.warrantyController.text;
      request.fields['price'] = _getController.priceController.text;
      request.fields['discount'] = _getController.discountController.text;
      request.fields['description'] = _getController.descriptionController.text;
      if (_getController.imagePath.value.isNotEmpty) {
        request.files.add(http.MultipartFile.fromBytes('photo', _getController.imagePath.value, filename: 'image.png', contentType: MediaType('image', 'png')));
      }
      var response = await request.send();
      if (response.statusCode == 200) {
        var data = jsonDecode(await response.stream.bytesToString());
        if (data['status'] == 0) {
          _getController.clearImagePath();
          _getController.clearCategoriesProductsModel();
          getProducts(_getController.dropDownItems[0]);
          Get.back();
        } else {
          _getController.shakeKey[8].currentState?.shake();
          InstrumentComponents().showToast('Ehhh nimadir xato ketdi'.tr, color: AppColors.red, textColor: AppColors.white);
          debugPrint('Xatolik: ${data['message']}');
        }
      }
    } catch (e, stacktrace) {
      debugPrint('Xatolik: $e');
      debugPrint(stacktrace.toString());
    }
  }

  Future<void> editProduct(int id) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/catalog/products'));
      request.headers.addAll(multipartHeaderBearer());
      request.fields['id'] = id.toString();
      if (_getController.titleController.text.isNotEmpty) request.fields['name'] = _getController.titleController.text;
      request.fields['category_id'] = '${_getController.dropDownItems[4]+1}';
      if (_getController.cashbackController.text.isNotEmpty) request.fields['cashback'] = _getController.cashbackController.text;
      if (_getController.warrantyController.text.isNotEmpty) request.fields['warranty'] = _getController.warrantyController.text;
      if (_getController.priceController.text.isNotEmpty) request.fields['price'] = _getController.priceController.text;
      if (_getController.discountController.text.isNotEmpty) request.fields['discount'] = _getController.discountController.text;
      if (_getController.descriptionController.text.isNotEmpty) request.fields['description'] = _getController.descriptionController.text;
      if (_getController.imagePath.value.isNotEmpty) request.files.add(http.MultipartFile.fromBytes('photo', _getController.imagePath.value, filename: 'image.png', contentType: MediaType('image', 'png')));
      var response = await request.send();
      if (response.statusCode == 200) {
        var data = jsonDecode(await response.stream.bytesToString());
        if (data['status'] == 0) {
          _getController.clearImagePath();
          _getController.clearCategoriesProductsModel();
          getProducts(_getController.dropDownItems[0]);
          Get.back();
        } else {
          _getController.shakeKey[8].currentState?.shake();
          InstrumentComponents().showToast('Ehhh nimadir xato ketdi'.tr, color: AppColors.red, textColor: AppColors.white);
          debugPrint('Xatolik: ${data['message']}');
        }
      }
    } catch (e, stacktrace) {
      debugPrint('Xatolik: $e');
      debugPrint(stacktrace.toString());
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/catalog/products?id=$id'), headers: headersBearer());
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 0) {
          Get.back();
          getProducts(_getController.dropDownItems[0]);
        } else {
          debugPrint('Xatolik: ${data['message']}');
        }
      } else {
        debugPrint('Xatolik: Serverga ulanishda muammo');
      }
    } catch (e, stacktrace) {
      debugPrint('Xatolik: $e');
      debugPrint(stacktrace.toString());
    }
  }

  Future<void> getReviews(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/catalog/reviews?product_id=$id'), headers: headersBearer());
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        debugPrint(data.toString());
        if (data['status'] == 0) {
          _getController.changeReviewsModel(ReviewsModel.fromJson(data));
          _getController.initializeExpandedCommentList(data['result'].length);
        } else {
          debugPrint('Xatolik: ${data['message']}');
        }
      } else {
        debugPrint('Xatolik: Serverga ulanishda muammo');
      }
    } catch (e, stacktrace) {
      debugPrint('Xatolik: $e');
      debugPrint(stacktrace.toString());
    }
  }


// transaksiyalar ro'yxatini olish
  Future<void> getTransactions({String? filter}) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/payment/transactions${filter != '' ? '?filter=$filter' : ''}'), headers: headersBearer());
      debugPrint('$baseUrl/payment/transactions${filter != '' ? '?filter=$filter' : ''}');
      debugPrint(response.body.toString());
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == 0) {
          _getController.changeSortedTransactionsModel(
            SortedPayTransactions.fromJson({"status": jsonDecode(response.body)['status'], "message": jsonDecode(response.body)['message'], "result": List.from(jsonDecode(response.body)['result'][0])}),
            TwoList.fromJson({"status": jsonDecode(response.body)['status'], "message": jsonDecode(response.body)['message'], "result": List.from(jsonDecode(response.body)['result'][1])}),
          );
        } else {
          debugPrint('Error: ${jsonDecode(response.body)['message']}');
        }
      } else {
        debugPrint('Xatolik: Serverga ulanishda muammo');
      }
    } catch (e, stacktrace) {
      debugPrint('Xatolik: $e');
      debugPrint(stacktrace.toString());
    }
  }

}
