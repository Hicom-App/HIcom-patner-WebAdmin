import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicom_partner_admin/companents/instrument/instrument_components.dart';
import 'package:hicom_partner_admin/resource/colors.dart';
import 'package:intl/intl.dart';
import '../companents/filds/text_small.dart';
import '../companents/skletons/report_page_skleton.dart';
import '../controllers/get_controller.dart';
import '../pages/checks_detail.dart';

class PaymentPage extends StatelessWidget{
  PaymentPage({super.key});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.changeSelectedMonth(0);
    return Obx(() => _getController.sortedTransactionsModel.value.result != null
        ? Column(
        children: [
          Container(width: Get.width, height: Get.height * 0.431,
              decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.r), bottomRight: Radius.circular(25.r)), image: const DecorationImage(image: AssetImage('assets/images/bar.png'), fit: BoxFit.cover), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 25.r, spreadRadius: 10.r, offset: const Offset(0, 0))]),
              child: Column(
                  children: [
                    AppBar(leading: const SizedBox(), backgroundColor: Colors.transparent, foregroundColor: AppColors.white, elevation: 0, title: TextSmall(text: 'Hisobotlar'.tr, color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 20.sp)),
                    SizedBox(
                        width: Get.width,
                        height: Get.height * 0.025,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _getController.listMonth.length,
                            padding: EdgeInsets.only(left: 20.w),
                            itemBuilder:(context, index) => InkWell(
                                onTap: () => _getController.changeSelectedMonth(index),
                                child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(left: 14.w),
                                    padding: EdgeInsets.only(left: 19.w, right: 19.w),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(width: 1.5.w, color: AppColors.white), color: _getController.listMonth[index]['selected'] == true ? AppColors.white : Theme.of(context).brightness == Brightness.light ? AppColors.blackTransparent : AppColors.grey.withOpacity(0.2)),
                                    child: TextSmall(text: _getController.listMonth[index]['name'].toString(), color: _getController.listMonth[index]['selected'] == true ? AppColors.red : AppColors.white, fontWeight: FontWeight.w500, maxLines: 1,fontSize: 12.sp)
                                )
                            )
                        )
                    ),
                    Container(
                        width: Get.width,
                        height: Get.height * 0.1,
                        margin: EdgeInsets.only(top: Get.height * 0.03, left: 15.w, right: 15.w),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  width: Get.width * 0.43,
                                  height: Get.height * 0.1,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.white,width: 1.8.sp),
                                      color:AppColors.blue, borderRadius: BorderRadius.all(Radius.circular(15.r))),
                                  child: Container(
                                      height: Get.height * 0.1,
                                      margin: EdgeInsets.only(right: 10.w),
                                      padding: EdgeInsets.only(left: 15.w, right: 5.w),
                                      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r),bottomLeft: Radius.circular(10.r),topRight: Radius.circular(1.r), bottomRight: Radius.circular(1.r))),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextSmall(text: 'Hisoblangan'.tr, color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 11.sp),
                                            SizedBox(height: 4.h),
                                            Row(
                                                children: [
                                                  TextSmall(text:_getController.twoList.value.result!.isNotEmpty ? _getController.getMoneyFormat(_getController.twoList.value.result!.first.calculated!) : '0', color: AppColors.black, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                                  TextSmall(text: '.00 ${'so‘m'.tr}'.tr, color:AppColors.black, fontWeight: FontWeight.w400, fontSize: 11.sp),
                                                ]
                                            ),
                                            SizedBox(height: 4.h),
                                            Row(
                                                children: [
                                                  TextSmall(text: _getController.getSortedTransactionsResultIndex(0), color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                                  SizedBox(width: 5.w),
                                                  TextSmall(text: 'ta'.tr, color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                                ]
                                            )
                                          ]
                                      )
                                  )
                              ),
                              Container(
                                  width: Get.width * 0.43,
                                  height: Get.height * 0.1,
                                  decoration: BoxDecoration(border: Border.all(color: AppColors.white,width: 1.8.sp), color:AppColors.red, borderRadius: BorderRadius.all(Radius.circular(15.r))),
                                  child: Container(
                                      height: Get.height * 0.1,
                                      margin: EdgeInsets.only(left: 10.w),
                                      padding: EdgeInsets.only(left: 10.w, right: 5.w),
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(1.r),
                                              bottomLeft: Radius.circular(1.r),
                                              topRight: Radius.circular(10.r),
                                              bottomRight: Radius.circular(10.r)
                                          )
                                      ),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextSmall(text: 'Rad etilgan'.tr, color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 11.sp),
                                            SizedBox(height: 4.h),
                                            Row(
                                                children: [
                                                  TextSmall(text: _getController.twoList.value.result!.isNotEmpty ? _getController.getMoneyFormat(_getController.twoList.value.result!.first.rejected!) : '0', color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                                  TextSmall(text: '.00 ${'so‘m'.tr}'.tr, color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.w400, fontSize: 11.sp),
                                                ]
                                            ),
                                            SizedBox(height: 4.h),
                                            Row(
                                                children: [
                                                  TextSmall(text: _getController.getSortedTransactionsResultIndex(3), color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                                  SizedBox(width: 5.w),
                                                  TextSmall(text: 'ta'.tr, color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                                ]
                                            )
                                          ]
                                      )
                                  )
                              )
                            ]
                        )
                    ),
                    Container(
                      width: Get.width,
                      margin: EdgeInsets.only(top: 20.h, left: 15.w, right: 15.w),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                width: Get.width * 0.43,
                                height: Get.height * 0.1,
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.white,width: 1.8.sp),
                                    color:AppColors.primaryColor, borderRadius: BorderRadius.all(Radius.circular(15.r))),
                                child: Container(
                                    height: Get.height * 0.1,
                                    margin: EdgeInsets.only(right: 10.w),
                                    padding: EdgeInsets.only(left: 15.w, right: 5.w),
                                    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r),bottomLeft: Radius.circular(10.r),topRight: Radius.circular(1.r), bottomRight: Radius.circular(1.r))),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          TextSmall(text: 'Jarayonda'.tr, color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 11.sp),
                                          SizedBox(height: 4.h),
                                          Row(
                                              children: [
                                                TextSmall(text: _getController.twoList.value.result!.isNotEmpty ? _getController.getMoneyFormat(_getController.twoList.value.result!.first.waiting!) : '0', color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                                TextSmall(text: '.00 ${'so‘m'.tr}'.tr, color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.w400, fontSize: 11.sp),
                                              ]
                                          ),
                                          SizedBox(height: 4.h),
                                          Row(
                                              children: [
                                                TextSmall(text: _getController.getSortedTransactionsResultIndex(1), color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                                SizedBox(width: 5.w),
                                                TextSmall(text: 'ta'.tr, color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                              ]
                                          )
                                        ]
                                    )
                                )
                            ),
                            Container(
                                width: Get.width * 0.43,
                                height: Get.height * 0.1,
                                decoration: BoxDecoration(border: Border.all(color: AppColors.white,width: 1.8.sp), color:AppColors.green, borderRadius: BorderRadius.all(Radius.circular(15.r))),
                                child: Container(
                                    height: Get.height * 0.1,
                                    margin: EdgeInsets.only(left: 10.w),
                                    padding: EdgeInsets.only(left: 10.w, right: 5.w),
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(1.r),
                                            bottomLeft: Radius.circular(1.r),
                                            topRight: Radius.circular(10.r),
                                            bottomRight: Radius.circular(10.r)
                                        )
                                    ),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          TextSmall(text: 'To‘langan'.tr, color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 11.sp),
                                          SizedBox(height: 4.h),
                                          Row(
                                              children: [
                                                TextSmall(text: _getController.twoList.value.result!.isNotEmpty ? _getController.getMoneyFormat(_getController.twoList.value.result!.first.withdrawn!) : '0', color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                                TextSmall(text: '.00 ${'so‘m'.tr}'.tr, color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.w400, fontSize: 11.sp),
                                              ]
                                          ),
                                          SizedBox(height: 4.h),
                                          Row(
                                              children: [
                                                TextSmall(text: _getController.getSortedTransactionsResultIndex(2), color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                                SizedBox(width: 5.w),
                                                TextSmall(text: 'ta'.tr, color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                              ]
                                          )
                                        ]
                                    )
                                )
                            )
                          ]
                      ),
                    )
                  ]
              )
          ),
          SizedBox(
              width: Get.width,
              height: Get.height * 0.49,
              child: SingleChildScrollView(
                  child: _getController.sortedTransactionsModel.value.result != null && _getController.sortedTransactionsModel.value.result!.isNotEmpty
                      ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(), // Disable scrolling
                      shrinkWrap: true,
                      itemCount: _getController.sortedTransactionsModel.value.result?.length ?? 0,
                      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 13.h, bottom: 100.h),
                      itemBuilder: (context, index) {
                        var transactionGroup = _getController.sortedTransactionsModel.value.result![index];
                        var resultsList = transactionGroup.results;
                        return Column(
                            children: [
                              if (resultsList != null && resultsList.isNotEmpty && transactionGroup.date != null)
                                Container(padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 12.h), child: TextSmall(text: _getController.getDateFormat(transactionGroup.date ?? ''), color: AppColors.black.withOpacity(0.4), fontWeight: FontWeight.w400))
                              else if (resultsList == null || resultsList.isEmpty && transactionGroup.date == null)
                                if (index == 0)
                                  Container(height: Get.height * 0.4, width: Get.width, alignment: Alignment.center, child: TextSmall(text: 'Ma’lumotlar yo‘q'.tr, color: AppColors.black70, fontWeight: FontWeight.bold)),
                              if (resultsList != null && resultsList.isNotEmpty)
                                for (var transaction in resultsList)
                                  GestureDetector(
                                      onTap: () => Get.to(() => ChecksDetail(id: transaction.id ?? 0, cardId: transaction.cardId ?? 0, operation: int.parse(transaction.operation.toString()), dateCreated: transaction.dateCreated ?? '', name: transaction.lastName ?? '-', firstName: transaction.firstName ?? '-', amount: transaction.amount ?? 0, description: transaction.description ?? '-', cardNo: transaction.cardNo ?? '-', cardHolder: transaction.cardHolder ?? '-'), arguments: transaction),
                                      child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 12.h),
                                          padding: EdgeInsets.only(right: 5.w, top: 5.h, bottom: 6.h, left: 5.w),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColors.white, boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 15.r, spreadRadius: 5.r, offset: const Offset(0, 0))]),
                                          child: Column(
                                              children: [
                                                Container(
                                                    width: Get.width,
                                                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                                    child: TextSmall(text: transaction.operation == 0  ? 'Keshbek'.tr : transaction.operation == 1 ? 'Bank kartalari'.tr : 'Bank kartalari'.tr, color: AppColors.black, fontWeight: FontWeight.w400, fontSize: 13.sp)
                                                ),
                                                Container(
                                                    width: Get.width,
                                                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                                    child: Row(
                                                        children: [
                                                          TextSmall(text: transaction.operation == 0 || transaction.operation == 0 ? 'Balansni to‘ldirish'.tr : '${transaction.firstName} ${transaction.lastName}', color: transaction.amount != null && transaction.amount! < 0 ? AppColors.red :AppColors.black, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                                          const Spacer(),
                                                          IconButton(
                                                              onPressed:() {
                                                                InstrumentComponents().paymentUpdate(context, transaction.id ?? 0);
                                                              },
                                                              icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.black)),
                                                          TextSmall(text: _getController.getMoneyFormat(transaction.amount ?? 0), color: transaction.amount != null && transaction.amount! < 0 ? AppColors.red : AppColors.black, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                                          TextSmall(text: '.00'.tr, color: AppColors.black, fontWeight: FontWeight.bold, fontSize: 12.sp),
                                                          SizedBox(width: 5.w),
                                                          TextSmall(text: 'so‘m'.tr, color:AppColors.black, fontWeight: FontWeight.w400, fontSize: 12.sp)
                                                        ]
                                                    )
                                                ),
                                                Container(
                                                    width: Get.width,
                                                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                                    child: Row(
                                                        children: [
                                                          TextSmall(text : transaction.dateCreated != null ? DateFormat.Hm().format(DateTime.parse(transaction.dateCreated!)) : '', color: AppColors.black, fontWeight: FontWeight.w400, fontSize: 10.sp),
                                                          const Spacer(),
                                                          Container(
                                                              margin: EdgeInsets.only(top: 3.h, right: 5.w),
                                                              padding: EdgeInsets.only(left: 15.w, right: 15.w),
                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.r), color:transaction.operation == 0 ? AppColors.blue : transaction.operation == 1 ? AppColors.primaryColor : transaction.operation == 2 ? AppColors.green : AppColors.red),
                                                              child: TextSmall(text:transaction.operation == 0 ? 'Hisoblangan': transaction.operation == 1 ? 'Jarayonda'.tr : transaction.operation == 2 ? 'To‘langan'.tr : 'Rad etilgan'.tr, color: AppColors.white, fontWeight: FontWeight.w400, fontSize: 10.sp)
                                                          )
                                                        ]
                                                    )
                                                )
                                              ]
                                          )
                                      )
                                  )
                            ]
                        );
                      })
                      :  Container(
                      width: Get.width,
                      height: Get.height * 0.4,
                      alignment: Alignment.center,
                      child: TextSmall(text: 'Ma’lumotlar yo‘q'.tr, color: AppColors.black, fontWeight: FontWeight.w400, fontSize: 16.sp)
                  )
              )
          )
        ]
    )
        : const ReportPageSkeleton());
  }

}