import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../companents/filds/text_large.dart';
import '../../companents/filds/text_small.dart';
import '../../companents/instrument/shake_widget.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import '../controllers/api_controller.dart';

final GlobalKey<VerifyPageNumberState> verifyPageKey = GlobalKey<VerifyPageNumberState>();

class VerifyPageNumber extends StatefulWidget {
  const VerifyPageNumber({super.key});

  @override
  VerifyPageNumberState createState() => VerifyPageNumberState();
}

class VerifyPageNumberState extends State<VerifyPageNumber> with SingleTickerProviderStateMixin {
  final GetController _getController = Get.put(GetController());
  bool isKeyboardVisible = false;
  bool animateTextFields = false;

  @override
  void initState() {
    super.initState();
    _startDelayedAnimation();
  }

  void _startDelayedAnimation() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        animateTextFields = true;
      });
    });
    animateTextFields = false;
    Future.delayed(const Duration(milliseconds: 100), () => setState(() => animateTextFields = true));
    animateTextFields = false;
  }



  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: Theme.of(context).textTheme.headlineLarge!.fontSize! * 1.4,
      height: Theme.of(context).textTheme.headlineLarge!.fontSize! * 1.6,
      textStyle: Theme.of(context).textTheme.headlineSmall,
      decoration: BoxDecoration(border: Theme.of(context).colorScheme.onSurface.withOpacity(0.1).value == 0 ? Border.all(color: AppColors.grey.withOpacity(0.1), width: 1) : Border.all(color: AppColors.grey.withOpacity(0.1)), color: AppColors.grey.withOpacity(0.1), borderRadius:BorderRadius.circular(10.r))
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(border: Border.all(color: AppColors.blue), color: AppColors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(10.r));
    final submittedPinTheme = defaultPinTheme.copyWith(decoration: defaultPinTheme.decoration?.copyWith(color: AppColors.grey.withOpacity(0.1)));
    final errorPinTheme = defaultPinTheme.copyWith(decoration: defaultPinTheme.decoration?.copyWith(color: AppColors.red.withOpacity(0.1), border: Border.all(color: AppColors.red), borderRadius: BorderRadius.circular(10.r)));
    final successPinTheme = defaultPinTheme.copyWith(decoration: defaultPinTheme.decoration?.copyWith(color: AppColors.green.withOpacity(0.1), border: Border.all(color: AppColors.green), borderRadius: BorderRadius.circular(10.r)));
    isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    if (!isKeyboardVisible) _startDelayedAnimation();

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
                        child: Stack(children: [
                          Positioned.fill(child: Image.asset('assets/images/fon.png', fit: BoxFit.fitWidth)),
                          Positioned(
                              top: 0,
                              child: AnimatedContainer(
                                  width: Get.width,
                                  height: isKeyboardVisible ? Get.height * 0.22 : Get.height * 0.4,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.r), bottomRight: Radius.circular(20.r)), image: const DecorationImage(image: AssetImage('assets/images/bar.png'), fit: BoxFit.cover), boxShadow: const [BoxShadow(color: AppColors.grey, spreadRadius: 5, blurRadius: 7, offset: Offset(0, 3))])
                              )
                          ),
                          Positioned(top: Get.height * 0.05, left: 0, child: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_rounded, color: AppColors.white, size: 35.sp))),
                          Positioned(
                              top: Get.height * 0.28,
                              width: Get.width,
                              child: ShakeWidget(
                                  key: _getController.shakeKey[7],
                                  shakeOffset: 5,
                                  shakeCount: 15,
                                  shakeDuration: const Duration(milliseconds: 500),
                                  shakeDirection: Axis.horizontal,
                                  child: AnimatedSlide(
                                      offset: animateTextFields ? const Offset(0, 0.0) : const Offset(0, 0.8),
                                      duration: Duration(milliseconds: animateTextFields ? 550 : 400),
                                      curve: Curves.easeInOut,
                                      child: Obx(() => Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                    width: Get.width,
                                                    margin: EdgeInsets.only(left: 25.w, right: 25.w),
                                                    child: TextLarge(text: '${'Kodni kiriting'.tr}:', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500)
                                                ),
                                                Container(
                                                    width: Get.width,
                                                    margin: EdgeInsets.only(left: 25.w, right: 25.w),
                                                    child: TextSmall(text: '${'Faollashtirish kodi'.tr} ${_getController.maskPhoneNumber('${_getController.code.value}${_getController.phoneController.text}')} ${'raqamiga SMS tarzida yuborildi.'.tr}', color: AppColors.black, fontWeight: FontWeight.w500, maxLines: 3)
                                                ),
                                                SizedBox(height: Get.height * 0.045),
                                                AnimatedOpacity(
                                                    opacity: animateTextFields ? 1.0 : 1.0,
                                                    duration: const Duration(milliseconds: 1500),
                                                    child: Pinput(
                                                        length: 5,
                                                        defaultPinTheme: defaultPinTheme,
                                                        focusedPinTheme: focusedPinTheme,
                                                        submittedPinTheme: submittedPinTheme,
                                                        showCursor: false,
                                                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                                                        forceErrorState: _getController.errorField.value,
                                                        errorBuilder: (context, error) => TextSmall(text: error, color: AppColors.red, fontWeight: FontWeight.w500),
                                                        errorPinTheme: _getController.errorFieldOk.value ? successPinTheme : errorPinTheme,
                                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                        controller: _getController.verifyCodeControllers,
                                                        keyboardType: TextInputType.number,
                                                        errorTextStyle: const TextStyle(color: AppColors.red, fontFamily: 'Schyler'),
                                                        onCompleted: (value) {
                                                          ApiController().verifyPhone();
                                                        })),
                                                Obx(() => Padding(
                                                    padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03, top: Get.height * 0.01),
                                                    child: _getController.countdownDuration.value.inSeconds == 0
                                                        ? TextButton(
                                                            style: ButtonStyle(overlayColor: WidgetStateProperty.all<Color>(Theme.of(context).colorScheme.onSurface.withOpacity(0.1))),
                                                            onPressed: () {
                                                              ApiController().sendCode();
                                                              _getController.resetTimer();
                                                            },
                                                            child: TextSmall(text: 'Kodni qayta yuborish'.tr, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6), fontWeight: FontWeight.w500))
                                                        : TextButton(style: ButtonStyle(overlayColor: WidgetStateProperty.all<Color>(Theme.of(context).colorScheme.onSurface.withOpacity(0.1))), onPressed: () {}, child: TextSmall(text: '${'Kodni qayta yuborish'.tr}: ${_getController.countdownDuration.value.inMinutes.toString().padLeft(2, '0')}:${(_getController.countdownDuration.value.inSeconds % 60).toString().padLeft(2, '0')}', color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6), fontWeight: FontWeight.w500)))
                                                )
                                              ])
                                      )
                                  )
                              )
                          )
                        ])
                    )
                )
            )
        )
    );
  }
}
