import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicom_partner_admin/companents/filds/text_small.dart';
import 'package:hicom_partner_admin/controllers/api_controller.dart';
import '../companents/instrument/instrument_components.dart';
import '../controllers/get_controller.dart';
import '../resource/colors.dart';

class SamplePage extends StatelessWidget {
  SamplePage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    ApiController().getProfile(isWorker: false);
    _getController.changeWidgetOptions();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.red,
        foregroundColor: AppColors.white,
        title: Obx(() => _getController.profileInfoModel.value.result == null ? const Text('') : TextSmall(text: '${_getController.profileInfoModel.value.result!.first.firstName} ${_getController.profileInfoModel.value.result!.first.lastName}', color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          //Obx(() => _getController.profileInfoModel.value.result == null ? const Text('') : Container(margin: EdgeInsets.all(5.w), height: 130.w, width: 46.w, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.white), child: ClipOval(child: CacheImage(keys: 'avatar', url: _getController.profileInfoModel.value.result!.first.photoUrl ?? 'https://avatars.mds.yandex.net/i?id=04a44da22808ead8020a647bb3f768d2_sr-7185373-images-thumbs&n=13', fit: BoxFit.cover))))
          IconButton(onPressed: (){}, icon: const Icon(Icons.notifications, color: AppColors.white))
        ]
      ),
      body: Obx(() => _getController.widgetOptions.elementAt(_getController.index.value)),
      drawer: Drawer(
        child: Obx(() => ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  decoration: const BoxDecoration(color: AppColors.red),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() => _getController.profileInfoModel.value.result == null ? const CircleAvatar(radius: 40, backgroundImage: NetworkImage('https://avatars.mds.yandex.net/i?id=04a44da22808ead8020a647bb3f768d2_sr-7185373-images-thumbs&n=13')) : CircleAvatar(radius: 40, backgroundImage: NetworkImage(_getController.profileInfoModel.value.result!.first.photoUrl ?? 'https://avatars.mds.yandex.net/i?id=04a44da22808ead8020a647bb3f768d2_sr-7185373-images-thumbs&n=13'))),
                              IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close, color: AppColors.white))
                            ]
                        ),
                        SizedBox(height: 10.h),
                        Obx(() => Text(_getController.profileInfoModel.value.result == null ? '' : '${_getController.profileInfoModel.value.result!.first.firstName} ${_getController.profileInfoModel.value.result!.first.lastName}', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.white)))
                      ]
                  )
              ),
              ListTile(
                leading: const Icon(Icons.payment),
                title: const TextSmall(text: 'O`tkazmalar', color: AppColors.black),
                selectedColor: _getController.index.value == 0 ? AppColors.red : AppColors.black,
                onTap: () {
                  _getController.changeIndex(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                  leading: const Icon(Icons.propane_tank_outlined),
                  title: const TextSmall(text: 'Tovorlar', color: AppColors.black),
                  selectedColor: _getController.index.value == 1 ? AppColors.red : AppColors.black,
                  onTap: () {
                    _getController.changeIndex(1);
                    Navigator.pop(context);
                  }
              ),
              ListTile(
                  leading: const Icon(Icons.send_to_mobile),
                  title: const TextSmall(text: 'Xabarlar', color: AppColors.black),
                  selectedColor: _getController.index.value == 2 ? AppColors.red : AppColors.black,
                  onTap: () {
                    _getController.changeIndex(2);
                    Navigator.pop(context);
                  }
              ),
              ListTile(
                  leading: const Icon(Icons.message_outlined),
                  title: const TextSmall(text: 'Sharhlar', color: AppColors.black),
                  selectedColor: _getController.index.value == 3 ? AppColors.red : AppColors.black,
                  onTap: () {
                    _getController.changeIndex(3);
                    Navigator.pop(context);
                  }
              ),
              ListTile(
                  leading: const Icon(Icons.logout, color: AppColors.red),
                  title: const TextSmall(text: 'Chiqish', color: AppColors.red),
                  onTap: () => InstrumentComponents().logOutDialog(context),
                 /* onTap: () {
                    _getController.logout();
                    Navigator.pop(context);
                  }*/
              )
            ]
        ))
      )
    );
  }
}