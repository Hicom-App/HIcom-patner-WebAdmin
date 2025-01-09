import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicom_partner_admin/resource/colors.dart';
import '../companents/filds/search_text_field.dart';
import '../controllers/get_controller.dart';

class PaymentPage extends StatelessWidget{
  PaymentPage({super.key});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        SearchTextField(color: AppColors.greys)
      ],
    );
  }

}