import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicom_partner_admin/auth/login_page.dart';
import 'companents/filds/text_small.dart';
import 'resource/colors.dart';

class NotConnection extends StatelessWidget{
  const NotConnection({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.signal_wifi_off, color: AppColors.red, size: 100.sp),
            SizedBox(height: 20.h),
            TextSmall(text: 'Internet mavjud emas'.tr, color: AppColors.black, fontSize: 16.sp, fontWeight: FontWeight.w500),
            SizedBox(height: 20.h,width: Get.width),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r))),
                onPressed: () {
                  //Get.offAll(() => SplashScreen());
                  Get.offAll(() => LoginPage());
                  //_getController.logout();
                },
                child: TextSmall(text: 'Qayta urinish'.tr, color: AppColors.white, fontSize: 16.sp, fontWeight: FontWeight.w500)
            )
          ]
      )
  );
}