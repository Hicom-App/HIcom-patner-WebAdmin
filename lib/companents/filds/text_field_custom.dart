import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';

class TextFieldCustom extends StatelessWidget {
  final Color fillColor;
  final String hint;
  final IconData? icons;
  final bool? mack;
  final TextEditingController controller;
  final bool? errorInput;
  final bool? isNext;
  final TextInputType? inputType;

  TextFieldCustom({super.key, required this.fillColor, required this.hint, this.icons, this.mack, required this.controller, this.errorInput, this.isNext = false, this.inputType = TextInputType.text});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.sp,
      margin: EdgeInsets.only(right: 15.sp, left: 15.sp),
      alignment: Alignment.center,
      decoration: BoxDecoration(border: Border.all(color: errorInput == true ? AppColors.red : AppColors.blackTransparent, width: 1), borderRadius: BorderRadius.circular(15.sp)),
      child: TextField(
          controller: controller,
          keyboardType: inputType ?? TextInputType.text,
          textInputAction: isNext == true ? TextInputAction.next : TextInputAction.search,
          onSubmitted: (isNext == true) ? (value) {Get.focusScope!.unfocus();} : null,
          inputFormatters: (mack ?? false) ? [_getController.mackFormater] : [],
          style: TextStyle(fontSize: 19.sp, fontFamily: 'Schyler', color: AppColors.black),
          decoration: InputDecoration(filled: true, isDense: true, border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(15)), fillColor: fillColor, hintText: hint.tr, hintStyle: TextStyle(color:AppColors.black.withOpacity(0.5), fontSize: 19.sp, fontFamily: 'Schyler'), prefixIcon: icons != null ? Padding(padding: EdgeInsets.all(Get.height * 0.013), child: Icon(icons, color: Theme.of(context).colorScheme.onSurface)) : null, suffixIcon: _getController.searchController.text.isNotEmpty ? IconButton(onPressed: () {_getController.searchController.clear();}, icon: Icon(TablerIcons.x, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6), size: 18.sp)) : const SizedBox(height: 0, width: 0)),
      )
    );
  }
}
