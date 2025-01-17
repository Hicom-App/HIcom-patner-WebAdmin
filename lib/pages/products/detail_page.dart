import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../companents/filds/text_large.dart';
import '../../companents/filds/text_small.dart';
import '../../companents/home/chashe_image.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';

class DetailPage extends StatelessWidget {
  final int? id;

  DetailPage({super.key, this.id});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    debugPrint('id: $id');
    _getController.allComments.value = false;
    _getController.fullText.value = false;
    _getController.clearProductsModelDetail();
    ApiController().getProduct(id!, isCategory: false);
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          child: Obx(() => Column(
              children: [
                SizedBox(
                    height: Get.height * 0.37,
                    width: Get.width,
                    child: Column(
                        children: [
                          SizedBox(
                              width: Get.width,
                              child: AppBar(
                                surfaceTintColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                foregroundColor: AppColors.blue,
                                backgroundColor: Colors.grey.shade200,
                                centerTitle: true,
                                elevation: 0,
                                title: _getController.productsModelDetail.value.result != null ? TextLarge(text: _getController.getCategoryName(_getController.productsModelDetail.value.result!.first.categoryId!).toString().toUpperCase(), color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 20.sp) : Skeletonizer(child: TextLarge(text: 'Nimadurda', color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 20.sp)),
                              )
                          ),
                          Expanded(
                              child: InkWell(
                                  onTap: (){},
                                  child: SizedBox(width: Get.width, child: CacheImage(keys: _getController.productsModelDetail.value.result != null ? _getController.productsModelDetail.value.result!.first.id.toString() : '', url: _getController.productsModelDetail.value.result != null ? _getController.productsModelDetail.value.result!.first.photoUrl.toString() : ''))
                              )
                          )
                        ]
                    )
                ),
                Container(
                    width: Get.width,
                    padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 20.h),
                    decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), offset: const Offset(0, -10), blurRadius: 20)], color: AppColors.white , borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _getController.productsModelDetail.value.result != null
                                          ? TextLarge(text: _getController.productsModelDetail.value.result!.first.name.toString(), color: AppColors.blue, fontWeight: FontWeight.bold, maxLines: 1, fontSize: 30.sp)
                                          : Skeletonizer(child: TextLarge(text: 'Nimadurda', color: AppColors.blue, fontWeight: FontWeight.bold, maxLines: 1, fontSize: 30.sp)),
                                      _getController.productsModelDetail.value.result != null
                                          ? TextLarge(text: _getController.getCategoryName(_getController.productsModelDetail.value.result!.first.categoryId!).toString(), color: Theme.of(context).brightness == Brightness.light ? AppColors.black70 : AppColors.white, maxLines: 1, fontSize: 16.sp)
                                          : Skeletonizer(child: TextLarge(text: 'Nimadur', color: Theme.of(context).brightness == Brightness.light ? AppColors.black70 : AppColors.white, maxLines: 1, fontSize: 16.sp))
                                    ]
                                )),
                                // _getController.productsModelDetail.value.result != null ? InkWell(onTap: () => ApiController().addFavorites(_getController.productsModelDetail.value.result!.first.id!, isProduct: _getController.productsModelDetail.value.result!.first.favorite == 0 ? true : false).then((value) => ApiController().getProduct(id!, isCategory: false)), child: Container(padding: EdgeInsets.all(9.r), decoration: BoxDecoration(color: AppColors.greys, borderRadius: BorderRadius.circular(100.r)), child: Icon(_getController.productsModelDetail.value.result!.first.favorite == 0 ? EneftyIcons.heart_outline : EneftyIcons.heart_bold, color:_getController.productsModelDetail.value.result!.first.favorite == 0 ? AppColors.black : AppColors.red, size: 19.sp))) : Skeletonizer(child: Icon(EneftyIcons.heart_outline, color: AppColors.white, size: 39.sp))
                              ]
                          ),
                          SizedBox(height: Get.height * 0.02),
                          Container(
                              width: Get.width,
                              height: 55.h,
                              decoration: BoxDecoration(color: AppColors.greys, borderRadius: BorderRadius.circular(10.r)),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              TextSmall(text: 'Baho', color: AppColors.black70, fontSize: 10.sp),
                                              _getController.productsModelDetail.value.result != null
                                                  ? Row(
                                                  children: [
                                                    Icon(EneftyIcons.star_bold, color: AppColors.backgroundApp, size: 15.sp),
                                                    SizedBox(width: Get.width * 0.01),
                                                    TextSmall(text: _getController.productsModelDetail.value.result!.first.rating != null ? _getController.productsModelDetail.value.result!.first.rating.toStringAsFixed(1) : '-', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold, maxLines: 1, fontSize: 15)
                                                  ])
                                                  : Skeletonizer(child: Row(children: [Icon(EneftyIcons.star_bold, color: AppColors.backgroundApp, size: 15.sp), SizedBox(width: Get.width * 0.01), TextSmall(text: '289 ', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold, maxLines: 1, fontSize: 15)]))
                                            ])),
                                    const VerticalDivider(color: Colors.grey, thickness: 1, width: 20, indent: 10, endIndent: 10),
                                    Center(
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              TextSmall(text: 'Kafolat', color: AppColors.black70, fontSize: 10.sp),
                                              SizedBox(width: Get.width * 0.01),
                                              _getController.productsModelDetail.value.result != null
                                                  ? TextSmall(text: '${_getController.productsModelDetail.value.result!.first.warranty != null ? _getController.productsModelDetail.value.result!.first.warranty.toString() == '0' ? '-' : _getController.productsModelDetail.value.result!.first.warranty.toString() : '-'} ${ _getController.productsModelDetail.value.result!.first.warranty.toString() == '0' ? '' : 'kun'.tr}', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold, maxLines: 1, fontSize: 15)
                                                  : Skeletonizer(child: TextSmall(text: 'Nimadur', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold, maxLines: 1, fontSize: 15))
                                            ]
                                        )
                                    ),
                                    const VerticalDivider(color: Colors.grey, thickness: 1, width: 20, indent: 10, endIndent: 10),
                                    Center(
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              TextSmall(text: 'Brend', color: AppColors.black70, fontSize: 10.sp),
                                              SizedBox(width: Get.width * 0.01),
                                              _getController.productsModelDetail.value.result != null
                                                  ? TextSmall(text: _getController.productsModelDetail.value.result!.first.brand != '' || _getController.productsModelDetail.value.result!.first.brand != 'null' || _getController.productsModelDetail.value.result!.first.brand != null ? _getController.productsModelDetail.value.result!.first.brand.toString() : '-', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold, maxLines: 1, fontSize: 15)
                                                  : Skeletonizer(child: TextSmall(text: 'Nimadur', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold, maxLines: 1, fontSize: 15))
                                            ]
                                        )
                                    )
                                  ]
                              )
                          ),
                          SizedBox(height: Get.height * 0.02),
                          if (_getController.productsModelDetail.value.result != null && _getController.productsModelDetail.value.result!.first.description != null)
                            const TextSmall(text: 'Tavsif', color: AppColors.blue, fontWeight: FontWeight.bold),
                          Container(
                              width: Get.width,
                              padding: EdgeInsets.only(top: Get.height * 0.01),
                              child: Column(
                                  children: [
                                    Obx(() => _getController.productsModelDetail.value.result != null
                                        ? AnimatedSize(
                                        duration: const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                        child: SizedBox(
                                            height: _getController.fullText.value ? null : 105.h,
                                            child: FadingEdgeScrollView.fromScrollView(
                                                gradientFractionOnEnd: 0.5,
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.zero,
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    controller: _getController.scrollControllerOk,
                                                    itemCount: 1,
                                                    itemBuilder: (context, index) {
                                                      final description = _getController.productsModelDetail.value.result?.first.description;
                                                      return Html(
                                                        data: description ?? '-',
                                                      );
                                                    })
                                            )
                                        )
                                    )
                                        : Skeletonizer(
                                        child: SizedBox(
                                            height: 105.h,
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                physics: const NeverScrollableScrollPhysics(),
                                                controller: _getController.scrollControllerOk,
                                                itemCount: 10,
                                                itemBuilder: (context, index) => const TextSmall(
                                                    text: 'Loading...',
                                                    color: RiveAppTheme.shadow,
                                                    fontWeight: FontWeight.w400,
                                                    maxLines: 10000,
                                                    fontSize: 10
                                                )
                                            )
                                        )
                                    )),
                                    InkWell(
                                        onTap: () {
                                          _getController.fullText.value = !_getController.fullText.value;
                                        },
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              TextSmall(text: 'Batafsil', color: AppColors.blue, fontWeight: FontWeight.w400, maxLines: 1, fontSize: 14.sp),
                                              Icon(_getController.fullText.value ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: AppColors.blue, size: Theme.of(context).iconTheme.size)
                                            ]
                                        )
                                    )
                                  ]
                              )
                          ),
                          const Divider(color: Colors.grey, thickness: 1),
                          SizedBox(height: Get.height * 0.01),
                          const TextSmall(text: 'Baholash', color: AppColors.blue, fontWeight: FontWeight.bold),
                          SizedBox(height: Get.height * 0.01),
                          RatingBar.builder(
                              initialRating: _getController.productsModelDetail.value.result != null ? _getController.productsModelDetail.value.result!.first.rating!.toDouble() : 0,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemSize: 20.sp,
                              itemPadding:
                              EdgeInsets.symmetric(horizontal: 5.sp),
                              unratedColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                              itemBuilder: (context, _) => const Icon(EneftyIcons.star_bold, color: AppColors.backgroundApp),
                              onRatingUpdate: (rating) {
                                //_getController.ratings = rating;
                                //InstrumentComponents().addRate(context);
                              }),
                          SizedBox(height: Get.height * 0.01),
                          const TextSmall(text: 'Sharhlar', color: AppColors.blue, fontWeight: FontWeight.bold),
                          if (_getController.reviewsModel.value.result != null)
                            for (int index = 0; index < (_getController.allComments.value == true || _getController.reviewsModel.value.result!.length < 3 ? _getController.reviewsModel.value.result!.length : 3); index++)
                              Container(
                                  width: Get.width,
                                  margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h, bottom: 20.h),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(children: [
                                          Container(
                                              height: 25.w,
                                              width: 25.w,
                                              margin: EdgeInsets.only(right: 6.w),
                                              decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: AppColors.grey, spreadRadius: 0.22, blurRadius: 25)]), child: ClipOval(child: FadeInImage(image: _getController.reviewsModel.value.result![index].userAvatar != '' ? NetworkImage(_getController.reviewsModel.value.result![index].userAvatar!) : const AssetImage('assets/images/logo_back.png'), placeholder: const AssetImage('assets/images/logo_back.png'), imageErrorBuilder: (context, error, stackTrace) => Container(decoration: const BoxDecoration(image: DecorationImage(image: NetworkImage('https://avatars.mds.yandex.net/i?id=04a44da22808ead8020a647bb3f768d2_sr-7185373-images-thumbs&n=13'), fit: BoxFit.cover))), fit: BoxFit.cover))
                                          ),
                                          TextSmall(text: _getController.reviewsModel.value.result![index].userName ?? 'Anonim', color: AppColors.black, fontWeight: FontWeight.bold),
                                          const TextSmall(text: ' | ', color: AppColors.black, fontWeight: FontWeight.bold),
                                          Expanded(child: TextSmall(text: DateFormat('dd.MM.yyyy HH:mm').format(DateTime.parse(_getController.reviewsModel.value.result![index].dateCreated!)), color: AppColors.black, fontWeight: FontWeight.w400, fontSize: 12.sp))]),
                                        SizedBox(height: Get.height * 0.01),
                                        RatingBar.builder(
                                          initialRating: _getController.reviewsModel.value.result![index].rating!.toDouble(),
                                          minRating: 0,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          ignoreGestures: true,
                                          itemCount: 5,
                                          itemSize: 12.sp,
                                          itemPadding: EdgeInsets.symmetric(horizontal: 1.sp),
                                          unratedColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                                          itemBuilder: (context, _) => const Icon(EneftyIcons.star_bold, color: AppColors.backgroundApp),
                                          onRatingUpdate: (double value) {},
                                          glow: false,
                                        ),
                                        SizedBox(height: Get.height * 0.01),
                                        if (_getController.reviewsModel.value.result![index].review != null && _getController.reviewsModel.value.result![index].review!.isNotEmpty)
                                          AnimatedSize(
                                              duration: const Duration(milliseconds: 300),
                                              curve: Curves.easeInOut,
                                              child: TextSmall(text: _getController.reviewsModel.value.result![index].review ?? '', color: AppColors.black70, fontSize: 12.sp, maxLines: _getController.isExpandedList[index] ? 2 : _getController.reviewsModel.value.result![index].review!.length, overflow: TextOverflow.ellipsis)),
                                        InkWell(
                                            onTap: () {
                                              _getController.isExpandedList[index] = !_getController.isExpandedList[index];
                                              _getController.update();
                                            },
                                            child: Row(
                                                children: [
                                                  TextSmall(text: _getController.isExpandedList[index] ? 'Ko‘proq ko‘rish' : 'To‘liq izoh', color: AppColors.blue, fontWeight: FontWeight.w400, fontSize: 12.sp),
                                                  Icon(!_getController.isExpandedList[index] ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: AppColors.blue, size: Theme.of(context).iconTheme.size)
                                                ]
                                            )
                                        )
                                      ]
                                  )
                              ),
                          if (_getController.reviewsModel.value.result != null && _getController.allComments.value == false && _getController.reviewsModel.value.result!.length > 3)
                            ElevatedButton(onPressed: (){_getController.allComments.value = !_getController.allComments.value;}, style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 5, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)), fixedSize: Size(Get.width, 40.h), surfaceTintColor: Colors.white, shadowColor: Colors.white, foregroundColor: Colors.white), child: TextSmall(text: 'Barchasini ko‘rish'.tr, color: AppColors.blue, fontWeight: FontWeight.w400, fontSize: 12.sp)),
                          SizedBox(height: Get.height * 0.1)
                        ]
                    )
                )
              ]
          ))
        )
    );
  }
}