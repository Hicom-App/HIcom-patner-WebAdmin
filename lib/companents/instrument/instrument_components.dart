import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import '../../auth/login_page.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import '../filds/text_large.dart';
import '../filds/text_small.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InstrumentComponents {
  final GetController _getController = Get.put(GetController());

  updateLanguage(Locale locale){Get.updateLocale(locale);_getController.saveLanguage(locale);}

  bottomSheetAccountsDelete(BuildContext context) => Get.bottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
      enableDrag: false,
      isScrollControlled: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0))),
                width: Get.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBar(
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
                          title: TextLarge(text: 'Hisobni o‘chirish'.tr, color: AppColors.black, fontWeight: FontWeight.w400),
                          centerTitle: false,
                          backgroundColor: Theme.of(context).colorScheme.surface,
                          elevation: 0,
                          leadingWidth: 0,
                          leading: Container(),
                          actions: [
                            IconButton(onPressed: () => Get.back(), icon: Icon(TablerIcons.x, color: Theme.of(context).colorScheme.onSurface, size: Theme.of(context).buttonTheme.height))
                          ]
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Container(
                          padding: EdgeInsets.only(left: Get.width * 0.035, right: Get.width * 0.035),
                          width: Get.width,
                          child: TextSmall(text: 'delete log', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w400,maxLines: 10)),
                      SizedBox(height: Get.height * 0.04),
                      Container(
                          padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                          child: Obx(() => _getController.countdownDuration.value.inSeconds == 0
                              ? ElevatedButton(
                              onPressed: () async {
                                //ApiController().deleteProfile();
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                              child:const Center(child: TextSmall(text: 'O‘chirishni tasdiqlang', color: AppColors.white, fontWeight: FontWeight.w400))
                          )
                              : ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.grey, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                              child: Center(child: TextSmall(text: '${'O‘chirishni tasdiqlang'.tr} (${(_getController.countdownDuration.value.inSeconds % 60).toString()})', color: AppColors.white, fontWeight: FontWeight.w400)))
                          )
                      )
                    ]
                )
            );
          }
      )
  );

  bottomSheetsCountries(BuildContext context,title,cat, {me = false}) => Get.bottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
                height: Get.height * 0.7,
                width: double.infinity,
                child: Column(
                    children: [
                      Container(height: Get.height * 0.005, width: Get.width * 0.2, margin: EdgeInsets.only(top: Get.height * 0.02, bottom: Get.height * 0.03), decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface, borderRadius: BorderRadius.circular(10.0))),
                      TextLarge(text: title.toString(), color: Theme.of(context).colorScheme.onSurface, fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize),
                      SizedBox(height: Get.height * 0.02),
                      if (cat == 0 && _getController.countriesModel.value.countries == null || cat == 1 && _getController.regionsModel.value.regions == null || cat == 2 && _getController.citiesModel.value.cities == null)
                        Expanded(child: TextSmall(text: '${'Yuklanmoqda'.tr}...', color: Theme.of(context).colorScheme.onSurface, maxLines: 3),)
                      else
                        Expanded(
                            child: ListView.builder(
                                itemCount: cat == 0 ? _getController.dropDownItemsCountries.length : cat == 1 ? _getController.dropDownItemsRegions.length : cat == 2 ? _getController.dropDownItemsCities.length : _getController.dropDownItemCategory.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      onTap: () {
                                        setState(() {
                                          Get.back();
                                          cat == 0 ? _getController.changeDropDownItems(1, index) : cat == 1 ? _getController.changeDropDownItems(2, index) : _getController.changeDropDownItems(3, index);
                                          if (cat == 0) {
                                            ApiController().getRegions(_getController.countriesModel.value.countries![index].id!);
                                            _getController.dropDownItemsCities.clear();
                                            _getController.clearCitiesModel();
                                          }
                                          if (cat == 1) {
                                            ApiController().getCities(_getController.regionsModel.value.regions![index].id!);
                                          }
                                        });
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                                          child: Column(
                                              children: [
                                                SizedBox(height: Get.height * 0.01),
                                                Container(
                                                    height: Get.height * 0.04,
                                                    width: Get.width,
                                                    margin: EdgeInsets.only(bottom: Get.height * 0.01),
                                                    child: Center(
                                                        child: Row(
                                                            children: [
                                                              TextSmall(text: cat == 0 ? _getController.dropDownItemsCountries[index].tr : cat == 1 ? _getController.dropDownItemsRegions[index].tr : _getController.dropDownItemsCities[index].tr, color: AppColors.black, fontWeight: FontWeight.w400),
                                                              const Spacer(),
                                                              if (_getController.dropDownItems[cat == 0 ? 1 : cat == 1 ? 2 : 3] == index)
                                                                Icon(TablerIcons.circle_check, color: Theme.of(context).colorScheme.onSurface)
                                                              else
                                                                Icon(TablerIcons.circle, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))
                                                            ]
                                                        )
                                                    )
                                                ),
                                                if (cat == 0 && _getController.dropDownItemsCountries.length - 1 != index || cat == 1 && _getController.dropDownItemsRegions.length - 1 != index || cat == 2 && _getController.dropDownItemsCities.length - 1 != index)
                                                  const Divider()
                                              ]
                                          )
                                      )
                                  );
                                }
                            )
                        )
                    ]
                )
            );
          })
  );

  bottomSheetsCat(BuildContext context,title, cat) => Get.bottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
                height: Get.height * 0.7,
                width: double.infinity,
                child: Column(
                    children: [
                      Container(height: Get.height * 0.005, width: Get.width * 0.2, margin: EdgeInsets.only(top: Get.height * 0.02, bottom: Get.height * 0.03), decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface, borderRadius: BorderRadius.circular(10.r))),
                      TextLarge(text: title.toString(), color: Theme.of(context).colorScheme.onSurface, fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize),
                      SizedBox(height: Get.height * 0.02),
                      if (_getController.categoriesModel.value.result == null)
                        Expanded(child: TextSmall(text: '${'Yuklanmoqda'.tr}...', color: Theme.of(context).colorScheme.onSurface, maxLines: 3),)
                      else
                        Expanded(
                            child: ListView.builder(
                                itemCount: _getController.dropDownItemCategory.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      onTap: () {
                                        setState(() {
                                          Get.back();
                                          _getController.changeDropDownItems(4, index);
                                        });
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                                          child: Column(
                                              children: [
                                                SizedBox(height: Get.height * 0.01),
                                                Container(
                                                    height: Get.height * 0.04,
                                                    width: Get.width,
                                                    margin: EdgeInsets.only(bottom: Get.height * 0.01),
                                                    child: Center(
                                                        child: Row(
                                                            children: [
                                                              TextSmall(text: _getController.dropDownItemCategory[index].tr, color: AppColors.black, fontWeight: FontWeight.w400),
                                                              const Spacer(),
                                                              if (_getController.dropDownItems[4] == index)
                                                                Icon(TablerIcons.circle_check, color: Theme.of(context).colorScheme.onSurface)
                                                              else
                                                                Icon(TablerIcons.circle, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))
                                                            ]
                                                        )
                                                    )
                                                ),
                                                if (_getController.dropDownItemCategory.length - 1 != index)
                                                  const Divider()
                                              ]
                                          )
                                      )
                                  );
                                }
                            )
                        )
                    ]
                )
            );
          })
  );

  bottomBuildLanguageDialog(BuildContext context,title,cat) => Get.bottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
                height: Get.height * 0.7,
                width: double.infinity,
                child: Column(
                    children: [
                      Container(height: Get.height * 0.005, width: Get.width * 0.2, margin: EdgeInsets.only(top: Get.height * 0.02, bottom: Get.height * 0.03), decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface, borderRadius: BorderRadius.circular(10.0))),
                      TextLarge(text: title.toString(), color: Theme.of(context).colorScheme.onSurface, fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize),
                      SizedBox(height: Get.height * 0.02),
                      Expanded(
                          child: ListView.builder(
                              itemCount: _getController.dropDownItem.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {setState(() {Get.back();_getController.changeDropDownItems(0, index);});},
                                    child: Padding(
                                        padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                                        child: Column(
                                            children: [
                                              SizedBox(height: Get.height * 0.01),
                                              Container(
                                                  height: Get.height * 0.04,
                                                  width: Get.width,
                                                  margin: EdgeInsets.only(bottom: Get.height * 0.01),
                                                  child: Center(
                                                      child: Row(
                                                          children: [
                                                            TextSmall(text: _getController.dropDownItem[index].tr, color: AppColors.black, fontWeight: FontWeight.w400),
                                                            const Spacer(),
                                                            if (_getController.dropDownItems[0] == index)
                                                              Icon(TablerIcons.circle_check, color: Theme.of(context).colorScheme.onSurface)
                                                            else
                                                              Icon(TablerIcons.circle, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))
                                                          ]
                                                      )
                                                  )
                                              ),
                                              if (_getController.dropDownItem.length - 1 != index)
                                                const Divider()
                                            ]
                                        )
                                    )
                                );
                              }
                          )
                      )
                    ]
                )
            );
          })
  );

  bottomBuildNotifyTypeDialog(BuildContext context,title,cat) => Get.bottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
                height: Get.height * 0.7,
                width: double.infinity,
                child: Column(
                    children: [
                      Container(height: Get.height * 0.005, width: Get.width * 0.2, margin: EdgeInsets.only(top: Get.height * 0.02, bottom: Get.height * 0.03), decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface, borderRadius: BorderRadius.circular(10.0))),
                      TextLarge(text: title.toString(), color: Theme.of(context).colorScheme.onSurface, fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize),
                      SizedBox(height: Get.height * 0.02),
                      Expanded(
                          child: ListView.builder(
                              itemCount: _getController.dropDownItemNotify.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {setState(() {Get.back();_getController.changeDropDownItems(4, index);});},
                                    child: Padding(
                                        padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                                        child: Column(
                                            children: [
                                              SizedBox(height: Get.height * 0.01),
                                              Container(
                                                  height: Get.height * 0.04,
                                                  width: Get.width,
                                                  margin: EdgeInsets.only(bottom: Get.height * 0.01),
                                                  child: Center(
                                                      child: Row(
                                                          children: [
                                                            TextSmall(text: _getController.dropDownItemNotify[index].tr, color: AppColors.black, fontWeight: FontWeight.w400),
                                                            const Spacer(),
                                                            if (_getController.dropDownItems[4] == index)
                                                              Icon(TablerIcons.circle_check, color: Theme.of(context).colorScheme.onSurface)
                                                            else
                                                              Icon(TablerIcons.circle, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))
                                                          ]
                                                      )
                                                  )
                                              ),
                                              if (_getController.dropDownItemNotify.length - 1 != index)
                                                const Divider()
                                            ]
                                        )
                                    )
                                );
                              }
                          )
                      )
                    ]
                )
            );
          })
  );

  void logOutDialog(BuildContext context) => Get.defaultDialog(
      backgroundColor: AppColors.white,
      barrierDismissible: false,
      titlePadding: EdgeInsets.only(top: 15.h, left: 10.w, right: 10.w),
      contentPadding: EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w),
      title: 'Tasdiqlash'.tr,
      titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp, color: AppColors.red, fontFamily: 'Schyler'),
      content: TextSmall(text: 'Hisobingizdan chiqishni xohlaysizmi?'.tr, color: AppColors.black, maxLines: 3),
      confirm: Container(
          width: 120.w,
          height: 42.h,
          margin: EdgeInsets.only(bottom: 15.h,top: 25.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: AppColors.blue),
          child: TextButton(onPressed: () {Get.back();ApiController().logout();_getController.logout();Get.offAll(() => const LoginPage(), transition: Transition.fadeIn);}, child: TextSmall(text: 'Chiqish'.tr, color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 15.sp))
      ),
      cancel: Container(
          width: 120.w,
          height: 42.h,
          margin: EdgeInsets.only(bottom: 15.h,top: 25.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: AppColors.red),
          child: TextButton(
              onPressed: () => Get.back(),
              child: TextSmall(text: 'Bekor qilish'.tr, color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 15.sp)
          )
      )
  );

  void paymentUpdate(BuildContext context, id) => Get.defaultDialog(
      backgroundColor: AppColors.white,
      barrierDismissible: false,
      titlePadding: EdgeInsets.only(top: 15.h, left: 10.w, right: 10.w),
      contentPadding: EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w),
      title: 'Tasdiqlash'.tr,
      titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp, color: AppColors.red, fontFamily: 'Schyler'),
      content: Column(
        children: [
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))), onPressed: (){ApiController().changeTransactionStatus(id, 2, '');Get.back();}, child: TextSmall(text: 'To`lash'.tr, color: AppColors.white, maxLines: 3)),
          SizedBox(height: 10.h),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: AppColors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))), onPressed: (){ApiController().changeTransactionStatus(id, 3, '');Get.back();}, child: TextSmall(text: 'Rad etish'.tr, color: AppColors.white, maxLines: 3)),
          SizedBox(height: 10.h),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))), onPressed: (){ApiController().changeTransactionStatus(id, 1, '');Get.back();}, child: TextSmall(text: 'Jarayonga o`tkazish'.tr, color: AppColors.white, maxLines: 3)),
          SizedBox(height: 10.h),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))), onPressed: (){ApiController().changeTransactionStatus(id, 0, '');Get.back();}, child: TextSmall(text: 'Hisoblash'.tr, color: AppColors.white, maxLines: 3)),
          SizedBox(height: 10.h),
        ],
      ),
      cancel: Container(
          width: 120.w,
          height: 42.h,
          margin: EdgeInsets.only(bottom: 15.h,top: 25.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: AppColors.red),
          child: TextButton(
              onPressed: () => Get.back(),
              child: TextSmall(text: 'Bekor qilish'.tr, color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 15.sp)
          )
      )
  );

  void languageDialog(BuildContext context) => Get.bottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
      enableDrag: true,
      elevation: 15,
      isScrollControlled: true, // Allows full control over height
      backgroundColor: AppColors.white,
      StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                  height: Get.height * 0.6,
                  width: double.infinity,
                  child: Column(
                      children: [
                        Container(
                            height: 5.h,
                            width: 100.w,
                            margin: EdgeInsets.only(top: 20.h, bottom: 30.h),
                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface, borderRadius: BorderRadius.circular(20.r))
                        ),
                        TextSmall(text: 'Tilni tanlang'.tr, color: Theme.of(context).colorScheme.onSurface),
                        SizedBox(height: Get.height * 0.04),
                        Expanded(
                            child: ListView.builder(
                                itemCount: _getController.locale.length,
                                itemBuilder: (context, index){
                                  return Container(
                                      height: 60.h,
                                      width: Get.width,
                                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                                      child: Column(
                                        children: [
                                          InkWell(
                                              overlayColor: WidgetStateProperty.all(Colors.transparent),
                                              child: Column(
                                                children: [
                                                  Row(
                                                      children: [
                                                        TextSmall(text: _getController.locale[index]['name'], color: AppColors.black),
                                                        const Spacer(),
                                                        if (_getController.locale[index]['locale'].toString() == _getController.language.toString())
                                                          const Icon(TablerIcons.circle_check, color: AppColors.blue),
                                                        if (_getController.locale[index]['locale'].toString() != _getController.language.toString())
                                                          const Icon(TablerIcons.circle, color: AppColors.grey)
                                                      ]
                                                  ),
                                                  SizedBox(height: 10.h)
                                                ]
                                              ),
                                              onTap: (){
                                                updateLanguage(_getController.locale[index]['locale']);
                                                Get.back();
                                              }
                                          ),
                                          if (index != _getController.locale.length - 1)
                                          const Divider()
                                        ],
                                      )
                                  );
                                }
                            )
                        )
                      ]
                  )
              );
            })
  );

  void showToast(String message, {color = AppColors.blue, textColor = AppColors.white, duration = 2}) {Fluttertoast.showToast(msg: message, fontAsset: 'Schyler', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP, timeInSecForIosWeb: duration, backgroundColor: color, textColor: textColor, fontSize: 16.sp);}

}