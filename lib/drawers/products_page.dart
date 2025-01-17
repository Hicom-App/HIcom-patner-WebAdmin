import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicom_partner_admin/controllers/api_controller.dart';
import 'package:hicom_partner_admin/pages/products/add_products.dart';
import '../companents/filds/search_text_field.dart';
import '../companents/filds/text_small.dart';
import '../companents/home/chashe_image.dart';
import '../companents/home/product_item.dart';
import '../companents/skletons/skeleton_category.dart';
import '../controllers/get_controller.dart';
import '../pages/products/add_category.dart';
import '../pages/products/category_page.dart';
import '../resource/colors.dart';

class ProductsPage extends StatelessWidget{
  ProductsPage({super.key});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    ApiController().getCategories();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Obx(() => SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            SearchTextField(color: AppColors.greys),
            if (_getController.categoriesModel.value.result != null)
              SizedBox(
                  width: Get.width,
                  height: 100.h,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 10.w, right: 30.w),
                      itemBuilder: (context, index) => index == 0
                          ? InkWell(
                          onTap: () => Get.to(AddCategory()),
                          child: SizedBox(
                              width: 95.w,
                              height: 100.h,
                              child: Container(
                                  decoration: BoxDecoration(color: AppColors.red, borderRadius: BorderRadius.circular(20.r)),
                                  child: Center(child: TextSmall(text: 'add'.tr, color: AppColors.white, fontSize: 11.sp, fontWeight: FontWeight.w600))
                              )
                          )
                      )
                          : InkWell(onTap: () => Get.to(CategoryPage(index: index - 1, open: 0)), child: Container(
                            width: 100.w,
                            height: 100.h,
                            margin: EdgeInsets.only(left: 15.w),
                            decoration: BoxDecoration(color: AppColors.red, borderRadius: BorderRadius.circular(20.r)),
                            child: Stack(
                                children: [
                                  Positioned.fill(
                                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                width: 40.w,
                                                height: 38.w,
                                                child: CacheImage(keys: _getController.categoriesModel.value.result![index - 1].id.toString(), url: _getController.categoriesModel.value.result![index - 1].photoUrl.toString())
                                            ),
                                            Container(margin: EdgeInsets.only(top: 5.h), width: 71.w, child: Center(child: _getController.categoriesModel.value.result != null ? TextSmall(text: _getController.categoriesModel.value.result![index - 1].name.toString(), color: AppColors.white, maxLines: 1, fontSize: 11.sp, fontWeight: FontWeight.w600) : const SizedBox()))
                                          ]
                                      )
                                  ),
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      child: InkWell(
                                          onTap: () {
                                            _getController.titleController.text = _getController.categoriesModel.value.result![index - 1].name.toString();
                                            _getController.descriptionController.text = _getController.categoriesModel.value.result![index - 1].description.toString();
                                            Get.to(AddCategory(index: index - 1));
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(3.w),
                                              decoration: const BoxDecoration(color: AppColors.greys, shape: BoxShape.circle),
                                              child: Icon(Icons.edit, color: AppColors.red, size: 20.sp)
                                          )
                                      )
                                  )
                                ]
                            )
                        )),
                      itemCount: _getController.categoriesModel.value.result != null ? _getController.categoriesModel.value.result!.length + 1 : 0,
                      shrinkWrap: true
                  )
              )
            else
              const SkeletonCategory(),
            Container(
                margin: EdgeInsets.only(top: 15.h, left: 25.w, right: 25.w),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextSmall(text: 'Barcha mahsulotlar'.tr, color: AppColors.black),
                      const Spacer(),
                      TextButton(onPressed: (){}, child: TextSmall(text: ''.tr, color: AppColors.grey.withOpacity(0.9)))
                    ]
                )
            ),
            if (_getController.productsModel.value.result != null && _getController.productsModel.value.result!.isNotEmpty)
              Container(
                  padding: EdgeInsets.only(bottom: 60.h),
                  width: Get.width,
                  child: GridView.builder(
                      padding: EdgeInsets.only(left: 25.w, right: 15.w, top: 15.h, bottom: 35.h),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _getController.productsModel.value.result != null ? _getController.productsModel.value.result!.length + 1 : 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: Get.width < 600 ? 2 : Get.width < 900 ? 3 : Get.width < 1000 ? 4 : Get.width < 1200 ? 5 : 6, mainAxisSpacing: 25, crossAxisSpacing: 1, childAspectRatio: 0.7),
                      itemBuilder: (context, index) => index == 0
                          ? InkWell(
                              onTap: () => Get.to(AddProducts()),
                              child: Container(
                                  height: 225.h,
                                  width: 165.w,
                                  margin: EdgeInsets.only(right: 15.w),
                                  decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(20.r), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 15.r, spreadRadius: 15.r, offset: const Offset(0, 0))]),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.add, color: AppColors.red, size: 40.sp),
                                        TextSmall(text: 'add'.tr, color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 15.sp)
                                      ]
                                  )
                              )
                          )
                          : InkWell(
                          onTap: () => Get.to(AddProducts(id: _getController.productsModel.value.result![index - 1].id)),
                          child: ProductItem(index: index - 1)),
                  )
              )
          ]
        )
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.blue,
        child: Icon(Icons.refresh, color: AppColors.white, size: 25.sp),
        onPressed: (){
          ApiController().getCategories();
        }
      ),
    );
  }
}