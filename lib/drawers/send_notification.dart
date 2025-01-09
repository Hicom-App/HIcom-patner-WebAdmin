import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicom_partner_admin/companents/filds/text_large.dart';
import 'package:hicom_partner_admin/controllers/api_controller.dart';
import '../companents/filds/text_field_custom.dart';
import '../companents/filds/text_small.dart';
import '../companents/instrument/instrument_components.dart';
import '../controllers/get_controller.dart';
import '../resource/colors.dart';

class SendNotification extends StatelessWidget{
  SendNotification({super.key});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    ApiController().getCountries();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: Get.width,height: 20.h),
              TextLarge(text: 'Xabarlar yuborish', color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.bold),
              SizedBox(width: Get.width,height: 30.h),
              TextFieldCustom(controller: _getController.titleController, fillColor: AppColors.greys, hint: 'Xabar nomi'),
              Container(
                  margin: EdgeInsets.only(top: 20.h),
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 300.h),
                      child: TextField(
                          controller: _getController.bodyController,
                          keyboardType: TextInputType.multiline,
                          maxLength: 5001,
                          maxLines: null,
                          style: const TextStyle(fontFamily: 'Schyler'),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.greys,
                              isDense: true,
                              hintText: 'Xabar matni',
                              hintStyle: const TextStyle(fontFamily: 'Schyler'),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r), borderSide: const BorderSide(color: AppColors.greys, width: 1)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r), borderSide: const BorderSide(color: AppColors.greys, width: 1)),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r), borderSide: const BorderSide(color: AppColors.greys, width: 1))
                          )
                      )
                  )
              ),
              Container(
                margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
                child: InkWell(
                    onTap: () {
                      if (FocusManager.instance.primaryFocus != null) FocusManager.instance.primaryFocus?.unfocus();
                      InstrumentComponents().bottomBuildNotifyTypeDialog(context,'Xabar yuborish turi'.tr,'0');
                    },
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextSmall(text: 'Xabar yuborish turi'.tr, color: AppColors.black, fontWeight: FontWeight.bold, maxLines: 3, fontSize: 13.sp),
                          Container(
                              height: 40.h,
                              margin: EdgeInsets.only(top: Get.height * 0.01),
                              padding: EdgeInsets.only(left: 15.w, right: 15.w),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: AppColors.greys),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextSmall(text: _getController.dropDownItemNotify[_getController.dropDownItems[4]].toString(), color: AppColors.black, fontWeight: FontWeight.bold, maxLines: 3, fontSize: 13.sp),
                                    const Icon(Icons.keyboard_arrow_down, color: AppColors.black)
                                  ]
                              )
                          )
                        ]
                    )
                )
              ),
              if (_getController.dropDownItems[4] == 0)
                TextFieldCustom(
                controller: _getController.tokenController,
                fillColor: AppColors.greys,
                hint: 'Qurilma tokeni',
              ),
              if (_getController.dropDownItems[4] == 1)
                Padding(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  child: InkWell(
                      onTap: () {
                        if (FocusManager.instance.primaryFocus != null) FocusManager.instance.primaryFocus?.unfocus();
                        InstrumentComponents().bottomBuildLanguageDialog(context,'Foydalanuvchi turi'.tr,'0');
                      },
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextSmall(text: 'Foydalanuvchi turi'.tr, color: AppColors.black, fontWeight: FontWeight.bold, maxLines: 3, fontSize: 13.sp),
                            Container(
                                height: 40.h,
                                margin: EdgeInsets.only(top: Get.height * 0.01),
                                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: AppColors.greys),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      TextSmall(text: _getController.dropDownItem[_getController.dropDownItems[0]].toString(), color: AppColors.black, fontWeight: FontWeight.bold, maxLines: 3, fontSize: 13.sp),
                                      const Icon(Icons.keyboard_arrow_down, color: AppColors.black)
                                    ]
                                )
                            )
                          ]
                      )
                  )
                ),
              if (_getController.dropDownItems[4] == 2)
              Padding(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  child: Column(
                    children: [
                      Column(
                          children: [
                            Container(width: Get.width, margin: EdgeInsets.only(top: Get.height * 0.01), child: TextSmall(text: 'Mamlakat'.tr, color: AppColors.black, fontWeight: FontWeight.bold, maxLines: 3,fontSize: 13.sp)),
                            InkWell(
                                onTap: () {
                                  if (FocusManager.instance.primaryFocus != null) FocusManager.instance.primaryFocus?.unfocus();
                                  _getController.countriesModel.value.countries == null ? null : InstrumentComponents().bottomSheetsCountries(context,'Mamlakat'.tr,0);
                                },
                                child: Container(
                                    width: Get.width,
                                    height: 40.h,
                                    padding: EdgeInsets.only(left: 15.w, right: 15.w),
                                    margin: EdgeInsets.only(top: Get.height * 0.01),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: AppColors.greys),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          TextSmall(text: _getController.dropDownItemsCountries.isNotEmpty ? _getController.dropDownItemsCountries[_getController.dropDownItems[1]].toString() : 'Mamlakat'.tr, color: _getController.dropDownItemsCountries.isNotEmpty ? AppColors.black : AppColors.black70, fontWeight: FontWeight.w500, maxLines: 3, fontSize: 13.sp),
                                          const Icon(Icons.keyboard_arrow_down, color: AppColors.black)
                                        ]
                                    )
                                )
                            )
                          ]
                      ),
                      SizedBox(height: 5.h),
                      Column(
                          children: [
                            Container(width: Get.width, margin: EdgeInsets.only(top: Get.height * 0.01), child: TextSmall(text: 'Viloyat'.tr, color: AppColors.black, fontWeight: FontWeight.bold, maxLines: 3,fontSize: 13.sp)),
                            InkWell(
                                onTap: () => _getController.regionsModel.value.regions == null ? null : InstrumentComponents().bottomSheetsCountries(context,'Viloyat'.tr,1),
                                child: Container(
                                    width: Get.width,
                                    height: 40.h,
                                    padding: EdgeInsets.only(left: 15.w, right: 15.w),
                                    margin: EdgeInsets.only(top: Get.height * 0.01),
                                    decoration: BoxDecoration(border: _getController.errorInput[5] ? Border.all(color: AppColors.red) : null, borderRadius: BorderRadius.circular(10.r), color: AppColors.greys),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          TextSmall(text: _getController.dropDownItemsRegions.isNotEmpty ? _getController.dropDownItemsRegions[_getController.dropDownItems[2]].toString() : 'Viloyatingizni Tanlang'.tr, color: _getController.dropDownItemsRegions.isNotEmpty ?AppColors.black : AppColors.black70, fontWeight: FontWeight.w500, maxLines: 3, fontSize: 13.sp),
                                          const Icon(Icons.keyboard_arrow_down, color: AppColors.black)
                                        ]
                                    )
                                )
                            )
                          ]
                      ),
                      SizedBox(height: 5.h),
                      Column(
                          children: [
                            Container(width: Get.width, margin: EdgeInsets.only(top: Get.height * 0.01), child: TextSmall(text: 'Shahar'.tr, color: AppColors.black, fontWeight: FontWeight.bold, maxLines: 3,fontSize: 14.sp)),
                            InkWell(
                                onTap: () => _getController.citiesModel.value.cities == null ? null : InstrumentComponents().bottomSheetsCountries(context,'Shahar'.tr,2),
                                child: Container(
                                    width: Get.width,
                                    height: 40.h,
                                    padding: EdgeInsets.only(left: 15.w, right: 15.w),
                                    margin: EdgeInsets.only(top: Get.height * 0.01),
                                    decoration: BoxDecoration(border: _getController.errorInput[6] ? Border.all(color: AppColors.red) : null, borderRadius: BorderRadius.circular(10.r), color: AppColors.greys),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          TextSmall(text: _getController.dropDownItemsCities.isNotEmpty ? _getController.dropDownItemsCities[_getController.dropDownItems[3]].toString() : 'Shaharingizni Tanlang'.tr, color:_getController.dropDownItemsCities.isNotEmpty ? AppColors.black : AppColors.black70, fontWeight: FontWeight.w500, maxLines: 3, fontSize: 13.sp),
                                          const Icon(Icons.keyboard_arrow_down, color: AppColors.black)
                                        ]
                                    )
                                )
                            )
                          ]
                      )
                    ]
                  )
              ),
              SizedBox(height: 100.h)
            ]
        ))
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.blue,
        child: const Icon(Icons.send, color: AppColors.white),
        onPressed: () {
          ApiController().sendNotification();
        },
      )
    );
  }
}