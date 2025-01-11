import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import '../companents/filds/text_small.dart';

class ChecksDetail extends StatelessWidget{
  final int id;
  final int operation;
  final String dateCreated;
  final String name;
  final String firstName;
  final int? cardId;
  final int amount;
  final String description;
  final String? cardNo;
  final String? cardHolder;

  ChecksDetail({super.key, required this.operation, required this.dateCreated, required this.name, required this.firstName, required this.amount, required this.description, this.cardId, required this.id, this.cardNo, this.cardHolder});

  final GetController _getController = Get.put(GetController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.white,
      appBar: AppBar(
        backgroundColor:  AppColors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.close, color:  AppColors.black), onPressed: () {Get.back();}),
        /*actions: [
          IconButton(icon: const Icon(Icons.download, color:  AppColors.black), onPressed: () {})
        ]*/
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            Icon(operation == 0 ? TablerIcons.circle_plus_filled : operation == 1 ? TablerIcons.clock_filled : operation == 2 ? TablerIcons.circle_check_filled : TablerIcons.xbox_x_filled, color: operation == 3 ? AppColors.red : operation == 1 ? AppColors.backgroundApp : operation == 2 ? AppColors.green : AppColors.blue, size: 80.sp),
            SizedBox(height: 10.h),
            TextSmall(text: operation == 0 ? 'Hisoblangan'.tr : operation == 1 ? 'Jarayonda'.tr : operation == 2 ? 'To‘langan'.tr : 'Rad etilgan'.tr, fontSize: 18.sp, color: operation == 3 ? AppColors.red : operation == 1 ? AppColors.backgroundApp : AppColors.black, fontWeight: FontWeight.w500),
            SizedBox(height: 5.h),
            if (dateCreated.isNotEmpty)
              TextSmall(text: _getController.getDateFormat(dateCreated), fontSize: 14.sp, color:  AppColors.black, fontWeight: FontWeight.w400),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(color:  AppColors.white, borderRadius: BorderRadius.circular(20.r), boxShadow: const [BoxShadow(color:  AppColors.greys, spreadRadius: 2, blurRadius: 5)]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextSmall(text: 'Tranzaksiya tafsilotlari'.tr,fontSize: 16.sp, color: AppColors.black, fontWeight: FontWeight.bold),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextSmall(text: 'Karta raqami'.tr,fontSize: 14.sp, color: AppColors.black, fontWeight: FontWeight.w400),
                      Row(
                        children: [
                          if (cardNo != null && cardNo!.isNotEmpty && cardNo != '-')
                            const Icon(Icons.credit_card, color: AppColors.black70),
                          SizedBox(width: 5.h),
                          TextSmall(text: cardNo.toString(), fontSize: 14.sp, color: AppColors.black, fontWeight: FontWeight.w400)
                        ]
                      )
                    ]
                  ),
                  SizedBox(height: 5.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextSmall(text: 'Qabul qiluvchi'.tr,fontSize: 14.sp, color:  AppColors.black, fontWeight: FontWeight.w400),
                        TextSmall(text: cardHolder.toString(),fontSize: 14.sp, color:  AppColors.black, fontWeight: FontWeight.w400)
                      ]
                  ),
                  Divider(thickness: 1, color: Colors.grey[300]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextSmall(text: 'Tranzaksiya vaqti', fontSize: 14.sp, color:  AppColors.black, fontWeight: FontWeight.w400),
                      TextSmall(
                          text: DateFormat('HH:mm').format(DateTime.parse(dateCreated)),
                          fontSize: 14.sp, color:  AppColors.black, fontWeight: FontWeight.w400)
                    ]
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextSmall(text: 'Tranzaksiya raqami',fontSize: 14.sp, color:  AppColors.black, fontWeight: FontWeight.w400),
                      TextSmall(text: id.toString(),fontSize: 14.sp, color:  AppColors.black, fontWeight: FontWeight.w400)
                    ]
                  ),
                  Divider(thickness: 1, color: Colors.grey[300]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextSmall(text: 'Jami',fontSize: 18.sp, color:  AppColors.black, fontWeight: FontWeight.bold),
                      TextSmall(text: '$amount.00',fontSize: 18.sp, color:  AppColors.black, fontWeight: FontWeight.bold)
                    ]
                  )
                ]
              )
            ),
            SizedBox(height: 20.h),
            if (description.isNotEmpty && description != 'null')
              Container(
                width: Get.width,
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(color: AppColors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(20.r)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextSmall(text: 'Qo‘shimcha',fontSize: 16.sp, color:  AppColors.black, fontWeight: FontWeight.bold, maxLines: 300),
                      SizedBox(height: 10.h),
                      TextSmall(text: description, fontSize: 14.sp, color:  AppColors.black, fontWeight: FontWeight.w400, maxLines: 10)
                    ]
                )
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)), backgroundColor: AppColors.blue, padding: EdgeInsets.symmetric(horizontal: 70.w, vertical: 15.h)),
              child: TextSmall(text: 'Orqaga', color: AppColors.white, fontWeight: FontWeight.bold, maxLines: 1,fontSize: 16.sp)
            ),
            SizedBox(height: 30.h)
          ]
        )
      )
    );
  }
}