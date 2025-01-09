import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../companents/filds/text_small.dart';
import '../../companents/home/chashe_image.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';

class CatProductItem extends StatelessWidget{
  final int index;
  final bool isFavorite;
  CatProductItem({super.key, required this.index, required this.isFavorite});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        /*child: FadeInImage(
                            image: NetworkImage(_getController.categoryProductsModel.value.result![index].photoUrl.toString()),
                            placeholder: const AssetImage('assets/images/logo_back.png'),
                            imageErrorBuilder: (context, error, stackTrace) => ClipRRect(borderRadius: BorderRadius.only(topRight: Radius.circular(20.r), topLeft: Radius.circular(20.r),), child: Container(height: 184.h, width: 180.w, decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/logo_back.png'), fit: BoxFit.cover)))),
                            fit: BoxFit.cover
                        )*/
                      child: CacheImage(
                        keys: _getController.categoryProductsModel.value.result![index].id.toString(),
                        url: _getController.categoryProductsModel.value.result![index].photoUrl.toString()
                      )
                    ),
                    /*Positioned(
                        right: 12.w,
                        top: 10.h,
                        child: InkWell(onTap: () => ApiController().addFavorites(int.parse(_getController.categoryProductsModel.value.result![index].id.toString()), isProduct: _getController.categoryProductsModel.value.result![index].favorite == 0 ? true : false, isFavorite: isFavorite).then((value) => _getController.updateCatProductsModel(index, _getController.categoryProductsModel.value.result![index].favorite == 0 ? 1 : 0)), child: Icon(_getController.categoryProductsModel.value.result![index].favorite == 1 ? EneftyIcons.heart_bold : EneftyIcons.heart_outline, color: _getController.categoryProductsModel.value.result![index].favorite == 1 ? Colors.red : Theme.of(context).colorScheme.onSurface, size: 20))
                    )*/
                  ]
              ),
              Padding(
                  padding: EdgeInsets.only(left: 13.w, right: 5.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextSmall(text: _getController.getCategoryName(int.parse(_getController.categoryProductsModel.value.result![index].categoryId.toString())).toUpperCase(), color: AppColors.black,fontWeight: FontWeight.bold, fontSize: 15.sp),
                        TextSmall(text: _getController.categoryProductsModel.value.result![index].name.toString(), color: AppColors.black70, fontWeight: FontWeight.w400, maxLines: 1, fontSize: 12.sp),
                        Row(
                            children: [
                              SizedBox(width: 3.w),
                              Icon(EneftyIcons.star_bold, color: AppColors.backgroundApp, size: 11.sp),
                              SizedBox(width: 5.w),
                              TextSmall(
                                text: '${(_getController.categoryProductsModel.value.result != null && index < _getController.categoryProductsModel.value.result!.length && _getController.categoryProductsModel.value.result![index].rating != null) ? _getController.categoryProductsModel.value.result![index].rating!.toStringAsFixed(1) : '0'} * ''${(_getController.categoryProductsModel.value.result != null && index < _getController.categoryProductsModel.value.result!.length && _getController.categoryProductsModel.value.result![index].reviews != null) ? _getController.categoryProductsModel.value.result![index].reviews : '0'} ${'Baho'.tr}',
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                maxLines: 1,
                                fontSize: 10.sp
                              )
                            ]
                        )
                      ]
                  )
              )
            ]
        )
    );
  }
}