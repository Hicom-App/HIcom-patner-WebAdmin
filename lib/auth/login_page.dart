import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../controllers/get_controller.dart';
import '../companents/filds/text_large.dart';
import '../companents/filds/text_small.dart';
import '../companents/instrument/shake_widget.dart';
import '../controllers/api_controller.dart';
import '../resource/colors.dart';
import 'key_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
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
                                          Container(width: Get.width, margin: EdgeInsets.only(left: 25.w, right: 25.w), child: TextLarge(text: 'Telefon raqamingizni kiriting'.tr, color: AppColors.black, fontWeight: FontWeight.w500, maxLines: 2)),
                                          Container(width: Get.width, margin: EdgeInsets.only(left: 25.w, right: 25, bottom: Get.height * 0.04), child: TextSmall(text: 'Biz tasdiqlash kodini yuboramiz!'.tr, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontWeight: FontWeight.w500, maxLines: 3)),
                                          AnimatedOpacity(
                                              opacity: 1.0,
                                              duration: const Duration(milliseconds: 1500), // Kechikish bilan paydo bo'lish
                                              child: Container(
                                                  width: Get.width,
                                                  margin: EdgeInsets.only(left: 25.w, right: 25.w),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1), border: Border.all(color: _getController.errorInput[0] ? AppColors.red : AppColors.greys, width: 1)),
                                                  child: Center(
                                                      child: IntlPhoneField(
                                                          focusNode: _focusNode,
                                                          controller: _getController.phoneController,
                                                          keyboardType: TextInputType.phone,
                                                          textInputAction: TextInputAction.done,
                                                          onSubmitted: (_) {_focusNode.unfocus();},
                                                          flagsButtonPadding: EdgeInsets.only(left: Get.width * 0.01, right: Get.width * 0.01),
                                                          onChanged: (phone) {
                                                            _getController.sendParam(true);
                                                            if (phone.countryISOCode != 'uz') {
                                                              _getController.countryCode.value = phone.countryISOCode;
                                                            }
                                                          },
                                                          onCountryChanged: (phone) {
                                                            _getController.code.value = '+${phone.fullCountryCode}';
                                                            _getController.countryCode.value = phone.regionCode;
                                                            _getController.phoneController.clear();
                                                          },
                                                          invalidNumberMessage: null,
                                                          decoration: InputDecoration(hintText: 'Telefon raqam'.tr, hintStyle: TextStyle(color: AppColors.black.withOpacity(0.5), fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize, fontFamily: 'Schyler'), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(7.r)), borderSide: BorderSide.none), counterText: '', counter: null, isDense: true),
                                                          style: TextStyle(color: AppColors.black, fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize, fontFamily: 'Schyler'),
                                                          showCountryFlag: true,
                                                          showCursor: true,
                                                          showDropdownIcon: false,
                                                          initialCountryCode: 'UZ',
                                                          dropdownTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize)
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
                                            if (_getController.send.value){
                                              if (_getController.phoneController.text.isNotEmpty) {
                                                ApiController().sendCode();
                                              } else {
                                                _getController.changeErrorInput(0, true);
                                                _getController.tapTimes(() =>_getController.changeErrorInput(0, false),1);
                                                _getController.shakeKey[8].currentState?.shake();
                                              }
                                            }
                                          },
                                          child: Icon(Icons.arrow_forward, color: AppColors.white, size: 30.sp)
                                      )
                                  )
                                ]
                            ),
                            SizedBox(height: 50.h),
                            const Spacer(),

                            TextButton(onPressed: () => Get.offAll(() => const KeyPage(), transition: Transition.fadeIn), child: TextSmall(text: 'Kalit bilan kirish'.tr, color: AppColors.blue, fontWeight: FontWeight.w500, fontSize: 16.sp)),
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
