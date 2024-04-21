import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_images.dart';
import 'package:viserpay_merchant/core/utils/util.dart';
import 'package:viserpay_merchant/data/controller/localization/localization_controller.dart';
import 'package:viserpay_merchant/data/controller/splash/splash_controller.dart';
import 'package:viserpay_merchant/data/repo/auth/general_setting_repo.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    MyUtils.splashScreen();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    final controller = Get.put(SplashController(repo: Get.find(), localizationController: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.gotoNextPage();
    });
  }

  @override
  void dispose() {
    MyUtils.splashScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<SplashController>(
        builder: (controller) => Scaffold(
          backgroundColor: MyColor.primaryColor,
          body: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  MyImages.appLogo,
                  width: MediaQuery.of(context).size.width * .65,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
