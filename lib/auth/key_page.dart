import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicom_partner_admin/pages/sample_page.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../controllers/get_controller.dart';
import '../companents/filds/text_large.dart';
import '../companents/filds/text_small.dart';
import '../companents/instrument/shake_widget.dart';
import '../controllers/api_controller.dart';
import '../resource/colors.dart';
import 'login_page.dart';

class KeyPage extends StatefulWidget {
  const KeyPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<KeyPage> with SingleTickerProviderStateMixin {
  final GetController _getController = Get.put(GetController());
  final FocusNode _focusNode = FocusNode();
  bool isKeyboardVisible = false;
  bool animateTextFields = false;

  @override
  void initState() {
    super.initState();
    _startDelayedAnimation();
  }

  void _startDelayedAnimation() {
    Future.delayed(const Duration(milliseconds: 100), () => setState(() => animateTextFields = true));
    animateTextFields = false;
  }


  @override
  Widget build(BuildContext context) {
    isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    if (!isKeyboardVisible) {
      _startDelayedAnimation();
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is UserScrollNotification) {
              FocusScope.of(context).unfocus();
            }
            return true;
          },
          child: SingleChildScrollView(
            child: Container(
              width: Get.width,
              height: Get.height,
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/fon.png'), fit: BoxFit.fitWidth)),
              child: Stack(
                children: [
                  Positioned.fill(child: Image.asset('assets/images/fon.png', fit: BoxFit.fitWidth)),
                  Positioned(
                    top: 0,
                    child: AnimatedContainer(
                      width: Get.width,
                      height: isKeyboardVisible ? Get.height * 0.22 : Get.height * 0.4,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.r), bottomRight: Radius.circular(20.r)), image: const DecorationImage(image: AssetImage('assets/images/bar.png'), fit: BoxFit.cover), boxShadow: const [BoxShadow(color: AppColors.grey, spreadRadius: 5, blurRadius: 16, offset: Offset(0, 3))])
                    )
                  ),
                  Positioned.fill(
                      child: Column(
                          children: [
                            SizedBox(height: Get.height * 0.3),
                            ShakeWidget(
                                key: _getController.shakeKey[8],
                                shakeOffset: 5,
                                shakeCount: 15,
                                shakeDuration: const Duration(milliseconds: 500),
                                shakeDirection: Axis.horizontal,
                                child: AnimatedSlide(
                                    offset: animateTextFields ? const Offset(0, 0) : const Offset(0, 1.0),
                                    duration: Duration(milliseconds: animateTextFields ? 550 : 400),
                                    curve: Curves.easeInOut,
                                    child: Column(
                                        children: [
                                          Container(width: Get.width, margin: EdgeInsets.only(left: 25.w, right: 25.w), child: TextLarge(text: 'Diqqat!'.tr, color: AppColors.black, fontWeight: FontWeight.w500, maxLines: 2)),
                                          Container(width: Get.width, margin: EdgeInsets.only(left: 25.w, right: 25, bottom: Get.height * 0.04), child: TextSmall(text: 'Kalitingizni kiriting'.tr, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontWeight: FontWeight.w500, maxLines: 3)),
                                          AnimatedOpacity(
                                              opacity: 1.0,
                                              duration: const Duration(milliseconds: 1500), // Kechikish bilan paydo bo'lish
                                              child: Container(
                                                  width: Get.width,
                                                  margin: EdgeInsets.only(left: 25.w, right: 25.w),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1), border: Border.all(color: _getController.errorInput[0] ? AppColors.red : AppColors.greys, width: 1)),
                                                  child: Center(
                                                      child: TextField(
                                                          controller: _getController.nameController,
                                                          //onChanged: (value) => _getController.sendParam(true),
                                                          onChanged: (value) => _getController.nameController.text.isNotEmpty ? _getController.sendParam(true) : _getController.sendParam(false),
                                                          style: TextStyle(color: _getController.errorInput[0] ? AppColors.red : AppColors.black, fontSize: 16.sp),
                                                          decoration: InputDecoration(
                                                              border: InputBorder.none,
                                                              hintText: 'key',
                                                              contentPadding: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h, bottom: 15.h)
                                                          ),
                                                      )
                                                  )
                                              )
                                          )
                                        ]
                                    )
                                )
                            ),
                            const Spacer(),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                      height: 40.h,
                                      margin: EdgeInsets.only(bottom: Get.height * 0.06),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(backgroundColor: _getController.send.value ? AppColors.blue : AppColors.grey, shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r), bottomLeft: Radius.circular(12.r)))),
                                          onPressed: () {
                                            if (_getController.nameController.text.isNotEmpty) {
                                              _getController.saveToken(_getController.nameController.text);
                                              Get.offAll(() => SamplePage());
                                            } else {
                                              _getController.changeErrorInput(0, true);
                                              _getController.tapTimes(() =>_getController.changeErrorInput(0, false),1);
                                              _getController.shakeKey[8].currentState?.shake();
                                            }
                                          },
                                          child: Icon(Icons.arrow_forward, color: AppColors.white, size: 30.sp)
                                      )
                                  )
                                ]
                            ),
                            TextButton(onPressed: () => Get.offAll(() => const LoginPage(), transition: Transition.fadeIn), child: TextSmall(text: 'Telefon raqam bilan kirish'.tr, color: AppColors.blue, fontWeight: FontWeight.w500, fontSize: 16.sp)),
                            SizedBox(height: 50.h)
                          ]
                      )
                  )
                ]
              )
            )
          )
        )
      )
    );
  }
}
