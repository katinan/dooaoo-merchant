import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viserpay_merchant/core/helper/shared_preference_helper.dart';
import 'package:viserpay_merchant/core/route/route.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_images.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/controller/localization/localization_controller.dart';
import 'package:viserpay_merchant/data/controller/menu/menu_controller.dart';
import 'package:viserpay_merchant/data/repo/auth/general_setting_repo.dart';
import 'package:viserpay_merchant/data/repo/menu_repo/menu_repo.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';
import 'package:viserpay_merchant/view/components/divider/custom_divider.dart';
import 'package:viserpay_merchant/view/components/will_pop_widget.dart';
import 'package:viserpay_merchant/view/screens/bottom_nav_section/menu/widget/language_dialog.dart';
import 'package:viserpay_merchant/view/screens/bottom_nav_section/menu/widget/menu_item.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(MenuRepo(apiClient: Get.find()));
    final controller = Get.put(AppMenuController(menuRepo: Get.find(), repo: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (localizationController) => GetBuilder<AppMenuController>(
        builder: (menuController) => WillPopWidget(
          nextRoute: RouteHelper.bottomNavBar,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: MyColor.screenBgColor,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: MyColor.primaryColor,
                title: Text(MyStrings.menu, style: regularLarge.copyWith(color: MyColor.colorWhite)),
                automaticallyImplyLeading: false,
              ),
              body: GetBuilder<AppMenuController>(
                builder: (controller) => SingleChildScrollView(
                  padding: Dimensions.screenPaddingHV,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                        decoration: BoxDecoration(
                          color: MyColor.colorWhite,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            MenuItems(
                                imageSrc: MyImages.user,
                                label: MyStrings.profile.tr,
                                onPressed: () => Get.toNamed(RouteHelper.profileScreen)
                            ),
                            const CustomDivider(space: Dimensions.space10),
                            MenuItems(
                                imageSrc: MyImages.changePassword,
                                label: MyStrings.changePassword.tr,
                                onPressed: () => Get.toNamed(RouteHelper.changePasswordScreen)
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Dimensions.space10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                        decoration: BoxDecoration(
                          color: MyColor.colorWhite,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                           Visibility(
                             visible: controller.repo.apiClient.getWithdrawModuleStatus(),
                             child:Column(
                             children: [
                               MenuItems(
                                   imageSrc: MyImages.menuWithdraw_1,
                                   label: MyStrings.withdrawMoney.tr,
                                   onPressed: () => Get.toNamed(RouteHelper.withdrawMoneyScreen)
                               ),
                               const CustomDivider(space: Dimensions.space10),
                               MenuItems(
                                   isSvgImage: false,
                                   imageSrc: MyImages.bottomWithdraw,
                                   label: MyStrings.withdrawHistory.tr,
                                   onPressed: () => Get.toNamed(RouteHelper.withdrawHistoryScreen)
                               ),
                               const CustomDivider(space: Dimensions.space10),
                             ],
                           )),
                            MenuItems(
                                isSvgImage: false,
                                imageSrc: MyImages.bottomTransaction,
                                label: MyStrings.transaction.tr,
                                onPressed: () => Get.toNamed(RouteHelper.transactionHistoryScreen)
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Dimensions.space10),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                          decoration: BoxDecoration(
                            color: MyColor.colorWhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Visibility(
                                  visible: menuController.langSwitchEnable,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      MenuItems(
                                        imageSrc: MyImages.language,
                                        label: MyStrings.language.tr,
                                        onPressed: (){
                                          final apiClient = Get.put(ApiClient(sharedPreferences: Get.find()));
                                          SharedPreferences pref = apiClient.sharedPreferences;
                                          String language = pref.getString(SharedPreferenceHelper.languageListKey)  ??'';
                                          String countryCode = pref.getString(SharedPreferenceHelper.countryCode)   ??'US';
                                          String languageCode = pref.getString(SharedPreferenceHelper.languageCode) ??'en';
                                          Locale local = Locale(languageCode,countryCode);
                                          showLanguageDialog(language, local, context);
                                        },
                                      ),
                                      const CustomDivider(space: Dimensions.space10),
                                    ],
                                  )),
                              MenuItems(
                                  imageSrc: MyImages.policy,
                                  label: MyStrings.privacyPolicy.tr,
                                  onPressed: (){
                                    Get.toNamed(RouteHelper.privacyScreen);
                                  }
                              ),
                              const CustomDivider(space: Dimensions.space10),
                              controller.logoutLoading ? const Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 20, width: 20,
                                  child: CircularProgressIndicator(color: MyColor.primaryColor, strokeWidth: 2.00),
                                ),
                              ) : MenuItems(
                                  imageSrc: MyImages.logout,
                                  label: MyStrings.logout.tr,
                                  onPressed: () => controller.logout()
                              )
                            ],
                          )
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
