import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../companents/instrument/shake_widget.dart';
import '../drawers/comments_page.dart';
import '../drawers/payment_page.dart';
import '../drawers/products_page.dart';
import '../drawers/send_notification.dart';
import '../models/auth/countries_model.dart';
import '../models/auth/send_code_model.dart';
import '../models/sample/cards_model.dart';
import '../models/sample/categories.dart';
import '../models/sample/profile_info_model.dart';
import '../models/sample/reviews_model.dart';
import '../models/sample/sorted_pay_transactions.dart';
import '../models/sample/warranty_model.dart';

class GetController extends GetxController {

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Variables
  var fullName = 'Dilshodjon Haydarov'.obs;
  RxString countryCode = ''.obs;
  var code = '+998'.obs;
  RxInt index = 0.obs;
  RxList<bool> errorInput = <bool>[false, false, false, false, false, false, false].obs;
  RxBool send = false.obs;
  Timer? _timerTap;
  Timer? _timer;
  var height = 0.0.obs;
  var width = 0.0.obs;
  RxBool errorField = false.obs;
  RxBool errorFieldOk = false.obs;
  var selectedDate = DateTime.now().obs;
  var formattedDate = ''.obs;
  RxBool fullText = true.obs;
  RxBool allComments = false.obs;
  RxList<bool> isExpandedList = RxList<bool>();
  RxList<int> dropDownItems = <int>[0, 0, 0, 0, 0, 0].obs;
  RxList<String> dropDownItemsCountries = <String>[].obs;
  RxList<String> dropDownItemsRegions = <String>[].obs;
  RxList<String> dropDownItemsCities = <String>[].obs;
  RxList<String> dropDownItem = <String>['Sotuvchi'.tr, 'O‘rnatuvchi'.tr, 'Buyurtmachi'.tr].obs;
  RxList<String> dropDownItemNotify = <String>['Qurilmalar bo‘yicha'.tr, 'Foydalanuvchilar turi bo‘yicha'.tr, 'Joylashuvlar bo‘yicha'.tr].obs;
  RxList<String> dropDownItemCategory = <String>[].obs;
  var widgetOptions = <Widget>[];
  Rx<Uint8List> imagePath = Rx<Uint8List>(Uint8List(0));

  Locale get language => Locale(GetStorage().read('language') ?? 'uz_UZ');
  get token => GetStorage().read('token');
  String get headerLanguage => language.languageCode == 'uz_UZ' ? 'uz' : language.languageCode == 'oz_OZ' ? 'oz' : language.languageCode == 'ru_RU' ? 'ru' : 'en';
  final List locale = [{'name':'O‘zbekcha','locale': const Locale('uz','UZ')},{'name':'Ўзбекча','locale': const Locale('oz','OZ')}, {'name':'Русский','locale': const Locale('ru','RU')}, {'name':'English','locale': const Locale('en','US')}].obs;
  void savePhoneNumber(String phoneNumber) => GetStorage().write('phoneNumber', phoneNumber);
  void saveToken(String token) => GetStorage().write('token', token);
  void deletePassCode() => GetStorage().remove('passCode');
  var mackFormater = MaskTextInputFormatter(mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

  void saveLanguage(Locale locale) {
    debugPrint(locale.languageCode.toString());
    GetStorage().write('language', '${locale.languageCode}_${locale.countryCode}');
    Get.updateLocale(locale);
  }

  String maskPhoneNumber(String phoneNumber) {
    const int minimumLength = 12;
    const String maskedPart = '*****';
    if (phoneNumber.length < minimumLength) return phoneNumber;
    String prefix = phoneNumber.substring(0, 7);
    String suffix = phoneNumber.length > 7 ? phoneNumber.substring(phoneNumber.length - 1) : '';
    return '$prefix$maskedPart$suffix';
  }


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Model

  var countriesModel = CountriesModel().obs;
  var regionsModel = CountriesModel().obs;
  var citiesModel = CountriesModel().obs;
  var profileInfoModel = ProfileInfoModel().obs;
  var categoriesModel = CategoriesModel().obs;
  var productsModel = CategoriesModel().obs;
  var productsModelDetail = CategoriesModel().obs;
  var categoryProductsModel = CategoriesModel().obs;
  var categoriesProductsModel = CategoriesProductsModel().obs;
  var sendCodeModel = SendCodeModel().obs;
  var warrantyModel = WarrantyModel().obs;
  var sortedWarrantyModel = SortedWarrantyModel().obs;
  var reviewsModel = ReviewsModel().obs;
  var cardsModel = CardsModel().obs;
  var sortedTransactionsModel = SortedPayTransactions().obs;
  var twoList = TwoList().obs;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Model change
  void changeSendCodeModel(SendCodeModel sendCodeModels) => sendCodeModel.value = sendCodeModels;

  void changeCountriesModel(CountriesModel countriesModel) {
    try {
      this.countriesModel.value = countriesModel;
      dropDownItemsCountries.value = countriesModel.countries!.map((e) => e.name!).toList();

      int matchingIndex = countriesModel.countries!.indexWhere((country) => country.id == profileInfoModel.value.result!.first.countryId);
      if (matchingIndex != -1) {
        dropDownItems[1] = matchingIndex;
      }
    } catch (e) {
      debugPrint('Xatolik: $e');
    }
  }

  void changeRegionsModel(CountriesModel regionsModel) {
    try {
      this.regionsModel.value = regionsModel;
      dropDownItemsRegions.value = regionsModel.regions!.map((e) => e.name!).toList();

      int? profileRegionId = profileInfoModel.value.result!.first.regionId;
      int matchingIndex = regionsModel.regions!.indexWhere((region) => region.id == profileRegionId);
      if (matchingIndex != -1) {
        dropDownItems[2] = matchingIndex;
      }
    } catch (e) {
      debugPrint('Xatolik: $e');
    }
  }

  void changeCitiesModel(CountriesModel citiesModel) {
    try {
      this.citiesModel.value = citiesModel;
      if(citiesModel.cities != null && citiesModel.cities!.isEmpty){
        clearCitiesModel();
      }
      dropDownItemsCities.value = citiesModel.cities!.map((e) => e.name!).toList();
      int? profileCityId = profileInfoModel.value.result!.first.cityId;
      int matchingIndex = citiesModel.cities!.indexWhere((city) => city.id == profileCityId);
      if (matchingIndex != -1) {
        dropDownItems[3] = matchingIndex;
      }
    } catch (e) {
      debugPrint('Xatolik: $e');
    }
  }

  void changeCategories(CategoriesModel categories) {
    try {
      categoriesModel.value = categories;
      dropDownItemCategory.value = categories.result!.map((e) => e.name!).toList();
    } catch (e) {
      debugPrint('Xatolik: $e');
    }
  }

  void changeProfileInfoModel(ProfileInfoModel profileInfo) => profileInfoModel.value = profileInfo;

  void changeCategoriesModel(CategoriesModel categories) => categoriesModel.value = categories;

  void changeProductsModelDetail(CategoriesModel categoriesModel) => productsModelDetail.value = categoriesModel;

  void changeProductsModel(CategoriesModel categoriesModel) => productsModel.value = categoriesModel;

  void changeCatProductsModel(CategoriesModel categoriesModel) => categoryProductsModel.value = categoriesModel;

  void clearCategoriesProductsModel() => categoriesProductsModel.value = CategoriesProductsModel();

  void addCategoriesProductsModel(CategoriesModel categories) {
    categoriesProductsModel.value.all ??= <CategoriesModel>[];
    categoriesProductsModel.value.all!.add(categories);
    categoriesProductsModel.refresh();
  }

  void changeReviewsModel(ReviewsModel reviewsModels) => reviewsModel.value = reviewsModels;

  void changeSortedTransactionsModel(SortedPayTransactions sortedTransactionsModels, TwoList twoLists){
    sortedTransactionsModel.value = sortedTransactionsModels;
    twoList.value = twoLists;
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Model clear
  void clearCitiesModel() {
    citiesModel.value = CountriesModel();
    dropDownItemsCities.value = [];
    dropDownItems[3] = 0;
  }

  void clearRegionsModel() {
    regionsModel.value = CountriesModel();
    dropDownItemsRegions.value = [];
    dropDownItemsCities.value = [];
    dropDownItems[2] = 0;
    dropDownItems[3] = 0;
  }

  void clearProfileInfoModel() => profileInfoModel.value = ProfileInfoModel();

  void clearControllers() {
    cardNumberController.clear();
    nameController.clear();
    surNameController.clear();
    streetController.clear();
    codeController.clear();
    passwordProjectController.clear();
    verifyCodeControllers.clear();
    paymentController.clear();
    phoneController.clear();
  }

  void clearCategoryProductsModel () => categoryProductsModel.value = CategoriesModel();

  void clearCategoriesModel() => categoriesModel.value = CategoriesModel();

  void clearProductsModelDetail() => productsModelDetail.value = CategoriesModel();

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Controllers
  final TextEditingController searchController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surNameController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController passwordProjectController = TextEditingController();
  final TextEditingController verifyCodeControllers = TextEditingController();
  final TextEditingController paymentController = TextEditingController();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final TextEditingController tokenController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController cashbackController = TextEditingController();
  final TextEditingController warrantyController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  final ScrollController scrollControllerOk = ScrollController();

  List shakeKey = [
    GlobalKey<ShakeWidgetState>(), //0
    GlobalKey<ShakeWidgetState>(), //1
    GlobalKey<ShakeWidgetState>(), //2
    GlobalKey<ShakeWidgetState>(), //3
    GlobalKey<ShakeWidgetState>(), //4
    GlobalKey<ShakeWidgetState>(), //5
    GlobalKey<ShakeWidgetState>(), //6
    GlobalKey<ShakeWidgetState>(), //7
    GlobalKey<ShakeWidgetState>(), //8
    GlobalKey<ShakeWidgetState>()  //9
  ];

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function
  void changeWidgetOptions() {
    widgetOptions.add(PaymentPage());
    widgetOptions.add(ProductsPage());
    widgetOptions.add(SendNotification());
    widgetOptions.add(CommentsPage());
  }

  int getCrossAxisCount() => Get.width < 600 ? 2 : Get.width < 900 ? 3 : Get.width < 1000 ? 4 : Get.width < 1200 ? 5 : 6;

  //imagePath clear
  void clearImagePath() => imagePath.value = Uint8List(0);

  String getCategoryName(int id) => categoriesModel.value.result != null ? categoriesModel.value.result!.firstWhere((element) => element.id == id).name ?? '' : '';

  final countdownDuration = const Duration(minutes: 1, seconds: 59).obs;

  void tapTimes(Function onTap, int sec) {
    if (_timerTap != null) stopTimerTap();
    _timerTap = Timer(Duration(seconds: sec), () {
      onTap();
      _timerTap = null;
    });
  }

  void startTimer() {
    //if (_timer != null && _timer!.isActive) _timer!.cancel();
    if (_timer != null && _timer!.isActive) resetTimer();
    if (countdownDuration.value.inSeconds > 0) {
      const oneSec = Duration(seconds: 1);
      _timer = Timer.periodic(
        oneSec, (timer) {
        debugPrint(countdownDuration.value.inSeconds.toString());
        if (countdownDuration.value.inSeconds == 0) {
          timer.cancel();
        } else {
          countdownDuration.value = countdownDuration.value - oneSec;
        }
      },
      );
    }
  }

  void resetTimer() {
    if (_timer != null && _timer!.isActive) stopTimer();
    countdownDuration.value = const Duration(minutes: 1, seconds: 59);
    startTimer();
  }

  void stopTimer() => _timer?.cancel();

  void stopTimerTap() => _timerTap!.cancel();

  void changeErrorInput(int index, bool value) {
    errorInput[index] = value;
    update();
  }

  void sendParam(value)=> send.value = value;

  void setHeightWidth(BuildContext context) {
    height.value = MediaQuery.of(context).size.height;
    width.value = MediaQuery.of(context).size.width;
  }

  void updateSelectedDate(DateTime newDate) {
    selectedDate.value = newDate;
    formattedDate.value = DateFormat('dd.MM.yyyy').format(selectedDate.value);
    update();
  }

  void logout() {
    clearProfileInfoModel();
    clearControllers();
    deletePassCode();
    GetStorage().erase();
    Get.delete<GetController>();
  }

  void changeIndex(int value) => index.value = value;

  void changeDropDownItems(int index, int newValue) {
    if (index >= 0 && index < dropDownItems.length) dropDownItems[index] = newValue;
  }

  void initializeExpandedCommentList(int length) {
    if (isExpandedList.length != length) {
      isExpandedList = List<bool>.filled(length, true).obs;
    }
  }


}

