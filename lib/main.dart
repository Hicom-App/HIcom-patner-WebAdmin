import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hicom_partner_admin/auth/login_page.dart';
import 'package:hicom_partner_admin/auth/verify_page_number.dart';
import 'package:hicom_partner_admin/pages/sample_page.dart';
import 'package:hicom_partner_admin/resource/srting.dart';
import 'auth/key_page.dart';
import 'controllers/get_controller.dart';

main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GetController _getController = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    _getController.setHeightWidth(context);
    return ScreenUtilInit(
        designSize: Size(_getController.width.value, _getController.height.value),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          print(_getController.token.toString());
          return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Hicom',
              theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Schyler'),
              translations: LocaleString(),
              locale: GetController().language,
              //home: const LoginPage()
              routes: {
                //'/': (context) => const LoginPage(),
                '/': (context) => _getController.token == '' || _getController.token == null || _getController.token == 'null' ? const KeyPage() : SamplePage(),
                '/login': (context) => const LoginPage(),
                '/verify': (context) => const VerifyPageNumber(),
              }
          );
        }
    );
  }
}