import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../resource/colors.dart';
import '../filds/text_small.dart';

class ReportPageSkeleton extends StatelessWidget {
  const ReportPageSkeleton({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: [
              Container(width: Get.width, height: Get.height * 0.4,
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.r), bottomRight: Radius.circular(25.r)), image: const DecorationImage(image: AssetImage('assets/images/bar.png'), fit: BoxFit.cover), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 25.r, spreadRadius: 30.r, offset: const Offset(0, 0))]),
                  child: Column(
                      children: [
                        AppBar(backgroundColor: Colors.transparent, foregroundColor: AppColors.white, elevation: 0, title: TextSmall(text: 'Hisobotlar'.tr, color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 20.sp)),
                        Skeletonizer(child: SizedBox(
                            width: Get.width,
                            height: Get.height * 0.025,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 12,
                                padding: EdgeInsets.only(left: 20.w),
                                itemBuilder:(context, index) => Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(left: 14.w),
                                    padding: EdgeInsets.only(left: 19.w, right: 19.w),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(width: 1.5.w, color: AppColors.white.withOpacity(0.7)), color: index == 0 ? AppColors.white.withOpacity(0.7) : Theme.of(context).brightness == Brightness.light ? AppColors.blackTransparent : AppColors.grey.withOpacity(0.2)),
                                    child: TextSmall(text: 'yanvar', color: AppColors.red.withOpacity(0.7), fontWeight: FontWeight.w500, maxLines: 1,fontSize: 12.sp)
                                )
                            )
                        )),
                        Skeletonizer(child: Container(
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
                                      decoration: BoxDecoration(color:AppColors.blue.shade200, borderRadius: BorderRadius.all(Radius.circular(15.r))),
                                      child: Container(
                                          height: Get.height * 0.1,
                                          margin: EdgeInsets.only(right: 10.w),
                                          padding: EdgeInsets.only(left: 15.w, right: 15.w),
                                          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(15.r),bottomLeft: Radius.circular(15.r),topRight: Radius.circular(5.r), bottomRight: Radius.circular(5.r))),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                TextSmall(text: 'Hisoblangan'.tr, color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 11.sp),
                                                SizedBox(height: 4.h),
                                                Row(
                                                    children: [
                                                      TextSmall(text: '100', color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                                      TextSmall(text: '.00 so‘m'.tr, color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.w400, fontSize: 11.sp),
                                                    ]
                                                ),
                                                SizedBox(height: 4.h),
                                                Row(
                                                    children: [
                                                      TextSmall(text: '10', color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
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
                                      decoration: BoxDecoration(color: AppColors.white.withOpacity(0.3), borderRadius: BorderRadius.all(Radius.circular(20.r))),
                                      child: Container(
                                          height: Get.height * 0.1,
                                          margin: EdgeInsets.only(left: 10.w),
                                          padding: EdgeInsets.only(left: 15.w, right: 15.w),
                                          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(5.r),bottomLeft: Radius.circular(5.r),topRight: Radius.circular(15.r), bottomRight: Radius.circular(15.r))),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                TextSmall(text: 'Rad etilgan'.tr, color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 11.sp),
                                                SizedBox(height: 4.h),
                                                Row(
                                                    children: [
                                                      TextSmall(text: '1000', color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                                      TextSmall(text: '.00 so‘m'.tr, color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.w400, fontSize: 11.sp),
                                                    ]
                                                ),
                                                SizedBox(height: 4.h),
                                                Row(
                                                    children: [
                                                      TextSmall(text: '0'.tr, color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
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
                        )),
                        Skeletonizer(child: Container(
                          width: Get.width,
                          margin: EdgeInsets.only(top: 20.h, left: 15.w, right: 15.w),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    width: Get.width * 0.43,
                                    height: Get.height * 0.1,
                                    decoration: BoxDecoration(color:AppColors.primaryColor.withOpacity(0.6), borderRadius: BorderRadius.all(Radius.circular(15.r))),
                                    child: Container(
                                        height: Get.height * 0.1,
                                        margin: EdgeInsets.only(right: 10.w),
                                        padding: EdgeInsets.only(left: 15.w, right: 15.w),
                                        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(15.r),bottomLeft: Radius.circular(15.r),topRight: Radius.circular(5.r), bottomRight: Radius.circular(5.r))),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              TextSmall(text: 'Jarayonda'.tr, color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 11.sp),
                                              SizedBox(height: 4.h),
                                              Row(
                                                  children: [
                                                    TextSmall(text: '100.0', color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                                    TextSmall(text: '.00 so‘m'.tr, color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.w400, fontSize: 11.sp),
                                                  ]
                                              ),
                                              SizedBox(height: 4.h),
                                              Row(
                                                  children: [
                                                    TextSmall(text: '10', color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
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
                                    decoration: BoxDecoration(color:AppColors.green.withOpacity(0.6), borderRadius: BorderRadius.all(Radius.circular(15.r))),
                                    child: Container(
                                        height: Get.height * 0.1,
                                        margin: EdgeInsets.only(left: 10.w),
                                        padding: EdgeInsets.only(left: 15.w, right: 15.w),
                                        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(5.r),bottomLeft: Radius.circular(5.r), topRight: Radius.circular(15.r), bottomRight: Radius.circular(15.r))),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              TextSmall(text: 'To`langan'.tr, color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 11.sp),
                                              SizedBox(height: 4.h),
                                              Row(
                                                  children: [
                                                    TextSmall(text: '100.0', color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                                    TextSmall(text: '.00 so‘m'.tr, color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.w400, fontSize: 11.sp),
                                                  ]
                                              ),
                                              SizedBox(height: 4.h),
                                              Row(
                                                  children: [
                                                    TextSmall(text: '0'.tr, color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
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
                        ))
                      ]
                  )
              ),
              Skeletonizer(
                  child: SizedBox(
                      width: Get.width,
                      height: Get.height * 0.52,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(), // Scrollni o'chiradi
                          shrinkWrap: true,
                          itemCount: 10,
                          padding: EdgeInsets.only(left: 10.w, right: 10.w,top: 13.h, bottom: 100.h),
                          itemBuilder:(context, index) => Column(
                              children: [
                                index == 0 || index == 2 || index == 3 || index == 6 || index == 13 ? Container(padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 12.h), child: TextSmall(text: index == 0 ? 'Bugun' : index == 2 ? 'Kecha' : index == 3 ? '15 Sentabr' : index == 6 ? '10 Sentabr' : '5 Sentabr', color: Theme.of(context).brightness == Brightness.light ? AppColors.black.withOpacity(0.4) : AppColors.white.withOpacity(0.6), fontWeight: FontWeight.w400),) : Container(),
                                Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 12.h),
                                    padding: EdgeInsets.only(right: 5.w, top: 5.h, bottom: 6.h, left: 5.w),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.r),
                                        color: AppColors.white,
                                        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 15.r, spreadRadius: 10.r, offset: const Offset(0, 0))]
                                    ),
                                    child: Column(
                                        children: [
                                          Container(
                                            width: Get.width,
                                            padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                            child: index == 0 ? TextSmall(text: 'Bank kartalari', color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white,fontWeight: FontWeight.w400, fontSize: 13.sp)
                                                : index == 1 ? TextSmall(text: 'Keshbek', color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.w400, fontSize: 13.sp)
                                                : index == 2 ? TextSmall(text: 'Bank Kartalari', color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.w400, fontSize: 13.sp)
                                                : TextSmall(text: 'Keshbek', color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.w400, fontSize: 10.sp),
                                          ),
                                          Container(
                                              width: Get.width,
                                              padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                              child: Row(
                                                  children: [
                                                    index == 0 ? TextSmall(text: 'Balansni to`ldirish' , color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold) : index == 2 ? TextSmall(text: 'Balansni to`ldirish', color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold) : TextSmall(text: 'Balansni to`ldirish', color: Theme.of(context).brightness == Brightness.light ? AppColors.black : AppColors.white, fontWeight: FontWeight.bold),
                                                    const Spacer(),
                                                    Row(
                                                        children: [
                                                          TextSmall(text: '100.0', color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                                          TextSmall(text: '.00'.tr, color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 12.sp),
                                                          SizedBox(width: 5.w),
                                                          TextSmall(text: 'so‘m'.tr, color: AppColors.white, fontWeight: FontWeight.w400, fontSize: 12.sp)
                                                        ]
                                                    )
                                                  ]
                                              )
                                          ),
                                          Container(
                                              width: Get.width,
                                              padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                              child:Row(
                                                  children: [
                                                    TextSmall(text: 'Assalom', color: AppColors.black, fontWeight: FontWeight.w400, fontSize: 10.sp),
                                                    const Spacer(),
                                                    Container(
                                                        margin: EdgeInsets.only(top: 3.h,right: 5.w),
                                                        padding: EdgeInsets.only(left: 15.w, right: 15.w),
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.r), color: index == 0 ? AppColors.green.withOpacity(0.3) : index == 1 ? AppColors.red.withOpacity(0.3) : index == 2 ? AppColors.primaryColor.withOpacity(0.3) : AppColors.blue.withOpacity(0.3)),
                                                        child: TextSmall(text: index == 0 ? 'To`landi'.tr : index == 1 ? 'Rad etildi'.tr : index == 2 ? 'Jarayonda'.tr : 'Qabul qilindi'.tr, color: AppColors.white, fontWeight: FontWeight.w400, fontSize: 10.sp)
                                                    )
                                                  ]
                                              )
                                          )
                                        ]
                                    )
                                )
                              ]
                          )
                      )
                  ))
            ]
        )
    );
  }
}