import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/data/controller/localization/localization_controller.dart';
import 'package:viserpay_merchant/data/controller/my_language_controller/my_language_controller.dart';
import 'package:viserpay_merchant/data/repo/auth/general_setting_repo.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';
import 'package:viserpay_merchant/view/components/app-bar/custom_appbar.dart';
import 'package:viserpay_merchant/view/components/buttons/gradient_rounded_button.dart';
import 'package:viserpay_merchant/view/components/buttons/rounded_loading_button.dart';
import 'package:viserpay_merchant/view/components/custom_loader/custom_loader.dart';
import 'package:viserpay_merchant/view/components/no_data.dart';
import 'package:viserpay_merchant/view/screens/language/widget/language_card.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String comeFrom = '';

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    final controller = Get.put(MyLanguageController(repo: Get.find(), localizationController: Get.find()));

    comeFrom = Get.arguments ?? '';

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadLanguage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyLanguageController>(
        builder: (controller) => Scaffold(
            backgroundColor: MyColor.getScreenBgColor(),
            appBar: CustomAppBar(
              isShowBackBtn: true,
              title: MyStrings.language.tr,
            ),
            body: controller.isLoading
                ? const CustomLoader()
                : controller.langList.isEmpty
                    ? NoDataWidget()
                    : SingleChildScrollView(
                        padding: Dimensions.screenPaddingHV,
                        child: GridView.builder(
                          shrinkWrap: true,
                          addAutomaticKeepAlives: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: controller.langList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: MediaQuery.of(context).size.width > 200 ? 2 : 1, crossAxisSpacing: 12, mainAxisSpacing: 12, mainAxisExtent: 150),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              controller.changeSelectedIndex(index);
                            },
                            child: LanguageCard(index: index, selectedIndex: controller.selectedIndex, langeName: controller.langList[index].languageName, isShowTopRight: true),
                          ),
                        ),
                      ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsetsDirectional.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
              child: GradientRoundedButton(
                  text: MyStrings.confirm.tr,
                  showLoadingIcon: controller.isChangeLangLoading,
                  // color: MyColor.getButtonColor(),
                  // textColor: MyColor.getButtonTextColor(),
                  press: () {
                    controller.changeLanguage(controller.selectedIndex, isComeFromSplashScreen: comeFrom.isNotEmpty);
                  }),
            )));
  }
}
