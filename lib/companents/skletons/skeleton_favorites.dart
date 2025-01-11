import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../resource/colors.dart';
import '../filds/text_small.dart';

class SkeletonFavorites extends StatelessWidget {
  const SkeletonFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: Get.width < 600 ? 2 : Get.width < 900 ? 3 : Get.width < 1000 ? 4 : Get.width < 1200 ? 5 : 6, crossAxisSpacing: 0, mainAxisSpacing: 15.sp, childAspectRatio: 0.78),
            padding: EdgeInsets.only(left: 15.w, right: 5.w),
            itemBuilder: (context, index) => Container(
                height: 225.h,
                width: 165.w,
                margin: EdgeInsets.only(right: 15.w),
                decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(20.r), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 15.r, spreadRadius: 15.r, offset: const Offset(0, 0))]),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(20.r), topLeft: Radius.circular(20.r)),
                                child: FadeInImage(
                                    image: const AssetImage('assets/images/logo_back.png'),
                                    placeholder: const AssetImage('assets/images/logo_back.png'),
                                    imageErrorBuilder: (context, error, stackTrace) {return Container(decoration: BoxDecoration(image: const DecorationImage(image:AssetImage('assets/images/logo_back.png'), fit: BoxFit.cover), borderRadius: BorderRadius.only(topRight: Radius.circular(10.r), bottomRight: Radius.circular(10.r))));},
                                    fit: BoxFit.cover
                                )
                            ),
                            Positioned(right: 12.w, top: 10.h, child: Icon(index == 1 ? EneftyIcons.heart_bold : EneftyIcons.heart_outline, color: index == 1 ? Colors.red : Theme.of(context).colorScheme.onSurface, size: 20))
                          ]
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 13.w, right: 5.w),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextSmall(text: 'Asalomu alaykum', color: AppColors.black,fontWeight: FontWeight.bold, fontSize: 15.sp),
                                TextSmall(text: 'salom', color: AppColors.black70, fontWeight: FontWeight.w400, maxLines: 1, fontSize: 12.sp),
                                Row(
                                    children: [
                                      SizedBox(width: 3.w),
                                      Icon(EneftyIcons.star_bold, color: AppColors.backgroundApp, size: 11.sp),
                                      SizedBox(width: 5.w),
                                      TextSmall(text: '2.2 * 2122 Baho', color: Colors.black87, fontWeight: FontWeight.w400, maxLines: 1, fontSize: 10.sp)
                                    ]
                                )
                              ]
                          )
                      )
                    ]
                )
            ),
            itemCount: 6
        )
    );
  }
}