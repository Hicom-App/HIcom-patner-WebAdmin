import 'dart:typed_data';

import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../companents/filds/text_field_custom.dart';
import '../../companents/filds/text_small.dart';
import '../../companents/instrument/instrument_components.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';

class AddProducts extends StatelessWidget {
  final int? id;
  AddProducts({super.key, this.id});

  final GetController _getController = Get.put(GetController());
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final Uint8List imageBytes = await image.readAsBytes();
        _getController.imagePath.value = imageBytes;  // imagePath ni yangilash
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  Container _buildListTile({required String title, required VoidCallback onTap, color}) {
    color ??= AppColors.black;
    return Container(
        margin: EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: Colors.grey.withOpacity(0.2)),
        child: ListTile(onTap: onTap, hoverColor: Colors.transparent, focusColor: Colors.transparent, titleTextStyle: const TextStyle(fontFamily: 'Schyler'), title: TextSmall(text: title, color: color), trailing: Icon(EneftyIcons.arrow_down_outline, color: color))
    );
  }

  @override
  Widget build(BuildContext context) {
    _getController.titleController.text = '';
    _getController.cashbackController.text = '';
    _getController.priceController.text = '';
    _getController.warrantyController.text = '';
    _getController.discountController.text = '';
    _getController.descriptionController.text = '';
    _getController.changeDropDownItems(4, 0);
    if (id != null) {
      ApiController().getProduct(id!, isCategory: false).then((value) {
        int index = _getController.productsModelDetail.value.result!.first.categoryId!.toInt() - 1;
      _getController.titleController.text = _getController.productsModelDetail.value.result!.first.name!;
      _getController.cashbackController.text = _getController.productsModelDetail.value.result!.first.cashback.toString();
      _getController.priceController.text = _getController.productsModelDetail.value.result!.first.price.toString();
      _getController.warrantyController.text = _getController.productsModelDetail.value.result!.first.warranty.toString();
      _getController.discountController.text = _getController.productsModelDetail.value.result!.first.discount.toString();
      _getController.descriptionController.text = _getController.productsModelDetail.value.result!.first.description!;
      _getController.changeDropDownItems(4, index);
    });
    }
    return Scaffold(
        appBar: AppBar(backgroundColor: AppColors.red, foregroundColor: AppColors.white, title: TextSmall(text: id == null ? 'Tovar qo\'shish' : 'Tovarni tahrirlash', color: Colors.white, fontWeight: FontWeight.bold)),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(top: 20.h),
              child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Obx(() {
                      DecorationImage getImage() {
                        if (_getController.imagePath.value.isNotEmpty) {
                          return DecorationImage(image: MemoryImage(_getController.imagePath.value), fit: BoxFit.cover);
                        } else if (id != null && _getController.productsModelDetail.value.result != null) {
                          final photoUrl = _getController.productsModelDetail.value.result!.first.photoUrl;
                          return photoUrl == null ? const DecorationImage(image: AssetImage('assets/images/logo_back.png'), fit: BoxFit.cover) : DecorationImage(image: NetworkImage(photoUrl), fit: BoxFit.cover);
                        } else {
                          return const DecorationImage(image: AssetImage('assets/images/logo_back.png'), fit: BoxFit.cover);
                        }
                      }
                      return Container(width: 150.w, height: 150.h, decoration: BoxDecoration(color: AppColors.greys, borderRadius: BorderRadius.circular(20.r), image: getImage()));
                    }),
                    SizedBox(height: 10.h),
                    TextButton(onPressed: pickImage, child: TextSmall(text: 'Rasm tanlash', color: AppColors.blue, fontSize: 14.sp, fontWeight: FontWeight.w600)),
                    SizedBox(height: 20.h),
                    TextFieldCustom(controller: _getController.titleController, fillColor: AppColors.greys, hint: 'Tovar nomi'),
                    SizedBox(height: 20.h),
                    Obx(() => _buildListTile(
                        title:  _getController.dropDownItemCategory.isNotEmpty ? _getController.dropDownItemCategory[_getController.dropDownItems[4]] : 'Kategoriya tanlash',
                        onTap: () {
                          if (FocusManager.instance.primaryFocus != null) FocusManager.instance.primaryFocus?.unfocus();
                          InstrumentComponents().bottomSheetsCat(context,'Kategoriyalar'.tr, 4);}
                    )),
                    SizedBox(height: 20.h),
                    TextFieldCustom(controller: _getController.cashbackController, fillColor: AppColors.greys, hint: 'Kashbek miqdori'),
                    SizedBox(height: 20.h),
                    TextFieldCustom(controller: _getController.priceController, fillColor: AppColors.greys, hint: 'Mahsulot narxi'),
                    SizedBox(height: 20.h),
                    TextFieldCustom(controller: _getController.warrantyController, fillColor: AppColors.greys, hint: 'Kafolat muddati (kunlarda)'),
                    SizedBox(height: 20.h),
                    TextFieldCustom(controller: _getController.discountController, fillColor: AppColors.greys, hint: 'Mahsulot chegirmasi'),
                    SizedBox(height: 20.h),
                    TextFieldCustom(controller: _getController.descriptionController, fillColor: AppColors.greys, hint: 'Izoh'),
                    SizedBox(height: 20.h),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (id != null)
                            ElevatedButton(
                                onPressed: () {
                                  ApiController().deleteProduct(id!.toInt());
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
                                child: TextSmall(text: 'O`chirish', color: AppColors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)
                            ),
                          if (id != null)
                            SizedBox(width: 20.w),
                          ElevatedButton(
                              onPressed: () {
                                //ApiController().addProduct();
                                if (id == null) {
                                  ApiController().addProduct();
                                } else {
                                  ApiController().editProduct(id!.toInt());
                                }
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
                              child: TextSmall(text: 'Saqlash', color: AppColors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)
                          )
                        ]
                    ),
                    SizedBox(height: 20.h),
                  ]
              )
          )
        )
    );
  }
}