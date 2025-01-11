import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicom_partner_admin/controllers/api_controller.dart';
import 'package:image_picker/image_picker.dart';
import '../../companents/filds/text_field_custom.dart';
import '../../companents/filds/text_small.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';

class AddCategory extends StatelessWidget {
  final int? index;
  AddCategory({super.key, this.index});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.red, foregroundColor: AppColors.white, title: TextSmall(text: index == null ? 'Kategorya qo\'shish' : 'Kategoryani tahrirlash', color: Colors.white, fontWeight: FontWeight.bold)),
      body: Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Obx(() {
              DecorationImage getImage() {
                if (_getController.imagePath.value.isNotEmpty) {
                  return DecorationImage(image: MemoryImage(_getController.imagePath.value), fit: BoxFit.cover);
                } else if (index != null) {
                  final photoUrl = _getController.categoriesModel.value.result![index!].photoUrl;
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
            TextFieldCustom(controller: _getController.titleController, fillColor: AppColors.greys, hint: 'Category nomi'),
            SizedBox(height: 20.h),
            TextFieldCustom(controller: _getController.descriptionController, fillColor: AppColors.greys, hint: 'Izoh'),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      ApiController().deleteCategory(_getController.categoriesModel.value.result![index!].id!.toInt());
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
                    child: TextSmall(text: 'O`chirish', color: AppColors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)
                ),
                SizedBox(width: 20.w),
                ElevatedButton(
                    onPressed: () {
                      if (index == null) {
                        ApiController().addCategory();
                      } else {
                        ApiController().editCategory(_getController.categoriesModel.value.result![index!].id!.toInt());
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
                    child: TextSmall(text: 'Saqlash', color: AppColors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)
                )
              ],
            )
          ]
        )
      )
    );
  }
}