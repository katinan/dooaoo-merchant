import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/route/route.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_images.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/controller/auth/auth/registration_controller.dart';
import 'package:viserpay_merchant/data/repo/auth/general_setting_repo.dart';
import 'package:viserpay_merchant/data/repo/auth/signup_repo.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';
import 'package:viserpay_merchant/view/components/app-bar/custom_appbar.dart';
import 'package:viserpay_merchant/view/components/custom_loader/custom_loader.dart';
import 'package:viserpay_merchant/view/components/custom_no_data_found_class.dart';
import 'package:viserpay_merchant/view/components/will_pop_widget.dart';
import 'package:viserpay_merchant/view/screens/auth/registration/widget/registration_form.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(RegistrationRepo(apiClient: Get.find()));
    Get.put(RegistrationController(registrationRepo: Get.find(), generalSettingRepo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<RegistrationController>().initData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (controller) => WillPopWidget(
        nextRoute: RouteHelper.loginScreen,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.getScreenBgColor(isWhite: true),
            appBar: CustomAppBar(
              title: MyStrings.signUp,
              fromAuth: true,
            ),
            body: controller.noInternet
                ? NoDataOrInternetScreen(
                    isNoInternet: true,
                    onChanged: (value) {
                      controller.changeInternet(value);
                    },
                  )
                : controller.isLoading
                    ? const CustomLoader()
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.space30, horizontal: Dimensions.space20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * .02),
                            Center(
                              child: Image.asset(
                                MyImages.appColorLogo,
                                height: 50,
                                width: 225,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * .05),
                            const RegistrationForm(),
                            const SizedBox(height: Dimensions.space30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(MyStrings.alreadyAccount.tr, style: regularLarge.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w500)),
                                const SizedBox(width: Dimensions.space5),
                                TextButton(
                                  onPressed: () {
                                    controller.clearAllData();
                                    Get.offAndToNamed(RouteHelper.loginScreen);
                                  },
                                  child: Text(MyStrings.signIn.tr, style: regularLarge.copyWith(color: MyColor.getPrimaryColor())),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
