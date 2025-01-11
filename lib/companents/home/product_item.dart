import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import '../filds/text_small.dart';
import '../skletons/product_item_skeleton.dart';
import 'chashe_image.dart';

class ProductItem extends StatelessWidget{
  final int index;
  ProductItem({super.key, required this.index});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return _getController.productsModel.value.result != null
        ? _getController.productsModel.value.result!.isNotEmpty
        ? Container(
        height: 225.h,
        width: 165.w,
        margin: EdgeInsets.only(right: 15.w),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(20.r), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 15.r, spreadRadius: 15.r, offset: const Offset(0, 0))]),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(borderRadius: BorderRadius.only(topRight: Radius.circular(20.r), topLeft: Radius.circular(20.r)), child: CacheImage(url: _getController.productsModel.value.result![index].photoUrl.toString(), keys:  _getController.productsModel.value.result![index].id.toString())),
              Padding(
                  padding: EdgeInsets.only(left: 13.w, right: 5.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextSmall(text: _getController.getCategoryName(int.parse(_getController.productsModel.value.result![index].categoryId.toString())).toUpperCase(), color: AppColors.black,fontWeight: FontWeight.bold, fontSize: 15.sp),
                        TextSmall(text: _getController.productsModel.value.result![index].name.toString(), color: AppColors.black70, fontWeight: FontWeight.w400, maxLines: 1, fontSize: 12.sp),
                        Row(
                            children: [
                              SizedBox(width: 3.w),
                              Icon(EneftyIcons.star_bold, color: AppColors.backgroundApp, size: 11.sp),
                              SizedBox(width: 5.w),
                              TextSmall(text: '${_getController.productsModel.value.result![index].rating == null ? '0': _getController.productsModel.value.result![index].rating.toStringAsFixed(1)} * ${_getController.productsModel.value.result![index].reviews == null ? '0': _getController.productsModel.value.result![index].reviews.toString()} ${'Baho'.tr}', color: Colors.black87, fontWeight: FontWeight.w400, maxLines: 1, fontSize: 10.sp),
                            ]
                        )
                      ]
                  )
              )
            ]
        )
    ) : const SizedBox() : ProductItemSkeleton(index: index);
  }
}