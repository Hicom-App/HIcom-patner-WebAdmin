import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../resource/colors.dart';
import '../filds/text_small.dart';

class SkeletonCategory extends StatelessWidget {
  const SkeletonCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: SizedBox(
          width: Get.width,
          height: 82.h,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 10.w, right: 30.w),
              itemBuilder: (context, index) => InkWell(
                  child:  Container(
                      margin: EdgeInsets.only(left: 15.w),
                      padding: EdgeInsets.only(left: 6.w, right: 6.w),
                      decoration: BoxDecoration(color: AppColors.red.withOpacity(0.2), borderRadius: BorderRadius.circular(20.r)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 40.w,
                                height: 38.w,
                                child: FadeInImage(
                                    image: const AssetImage('assets/images/logo_back.png'),
                                    placeholder: const AssetImage('assets/images/logo_back.png'),
                                    imageErrorBuilder: (context, error, stackTrace) {return Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/logo_back.png'), fit: BoxFit.cover)));},
                                    fit: BoxFit.contain
                                )
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 5.h),
                                width: 71.w,
                                child: Center(
                                    child: TextSmall(text: 'hi-82E', color: AppColors.white, maxLines: 1, fontSize: 11.sp, fontWeight: FontWeight.w600)
                                )
                            )
                          ]
                      )
                  )
              ),
              itemCount: 10,
              shrinkWrap: true
          )
      )
    );
  }

}