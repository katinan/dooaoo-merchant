import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viserpay_merchant/core/helper/shared_preference_helper.dart';
import 'package:viserpay_merchant/core/helper/string_format_helper.dart';
import 'package:viserpay_merchant/core/route/route.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_icons.dart';
import 'package:viserpay_merchant/core/utils/my_images.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/data/controller/home/home_controller.dart';
import 'package:viserpay_merchant/data/controller/menu/menu_controller.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';
import 'package:viserpay_merchant/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:viserpay_merchant/view/components/bottom-sheet/delete_account_bottom_sheet_body.dart';
import 'package:viserpay_merchant/view/components/divider/custom_divider.dart';
import 'package:viserpay_merchant/view/components/image/my_image_widget.dart';
import 'package:viserpay_merchant/view/screens/bottom_nav_section/home/widget/drawer_user_card.dart';
import 'package:viserpay_merchant/view/screens/bottom_nav_section/menu/widget/language_dialog.dart';
import 'package:viserpay_merchant/view/screens/bottom_nav_section/menu/widget/menu_item.dart';

class MyDrawer extends StatelessWidget {
  final Function() onDrawerItemTap;

  const MyDrawer({super.key, required this.onDrawerItemTap});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppMenuController>(builder: (controller) {
      return SafeArea(
        child: ClipRRect(
          borderRadius: const BorderRadiusDirectional.only(
              // topEnd: Radius.circular(Dimensions.space15),
              // bottomEnd: Radius.circular(Dimensions.space15),
              ),
          child: Drawer(
            width: context.width / 1.65,
            backgroundColor: MyColor.colorWhite,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 10.0, end: 4),
              child: GetBuilder<HomeController>(
                builder: (homecontroller) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: Dimensions.space10,
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(end: Dimensions.space15),
                          height: Dimensions.space50,
                          width: double.infinity,
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () => onDrawerItemTap(),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.close_rounded,
                                size: 30,
                                color: MyColor.getTextColor(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: Dimensions.space10,
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed(RouteHelper.profileScreen),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(
                              start: Dimensions.space10,
                            ),
                            child: DrawerUserCard(
                              fullname: homecontroller.fullName,
                              username: homecontroller.username,
                              imgWidget: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: MyColor.borderColor, width: 0.5),
                                  shape: BoxShape.circle,
                                ),
                                height: 40,
                                width: 40,
                                child: MyImageWidget(
                                  imageUrl: homecontroller.imagePath,
                                  boxFit: BoxFit.cover,
                                  isProfle: true,
                                  radius: 50,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const CustomDivider(
                          space: Dimensions.space20,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: Dimensions.space10, top: Dimensions.space10),
                          child: Column(
                            children: [
                              MenuItems(imageSrc: MyIcons.user, label: MyStrings.profile.tr, onPressed: () => Get.toNamed(RouteHelper.profileScreen)),
                              const SizedBox(height: Dimensions.space10),
                              MenuItems(
                                imageSrc: MyIcons.changePassword,
                                label: MyStrings.changePassword,
                                onPressed: () => Get.toNamed(RouteHelper.changePasswordScreen),
                              ),
                              const SizedBox(height: Dimensions.space10),
                              MenuItems(
                                imageSrc: MyImages.twoFa,
                                isSvgImage: false,
                                label: MyStrings.twoFactorAuth,
                                onPressed: () => Get.toNamed(RouteHelper.twoFactorSetupScreen),
                              ),
                              const SizedBox(height: Dimensions.space10),
                              MenuItems(
                                imageSrc: MyIcons.menuQrCode,
                                label: MyStrings.myQrCode.tr,
                                onPressed: () => Get.toNamed(RouteHelper.myQRCodeScreen),
                              ),
                              const SizedBox(height: Dimensions.space10),
                              Column(
                                children: [
                                  Visibility(
                                      visible: controller.repo.apiClient.getWithdrawModuleStatus(),
                                      child: Column(
                                        children: [
                                          MenuItems(
                                            isSvgImage: false,
                                            imageSrc: MyImages.banktranfer,
                                            label: MyStrings.withdrawMoney.tr,
                                            onPressed: () => Get.toNamed(RouteHelper.withdrawMoneyScreen),
                                          ),
                                          const SizedBox(height: Dimensions.space10),
                                          MenuItems(
                                            isSvgImage: true,
                                            imageSrc: MyIcons.clock,
                                            label: MyStrings.withdrawHistory,
                                            onPressed: () => Get.toNamed(RouteHelper.withdrawHistoryScreen),
                                          ),
                                        ],
                                      )),
                                  const SizedBox(height: Dimensions.space10),
                                  MenuItems(isSvgImage: true, imageSrc: MyIcons.transaction, label: MyStrings.transactions.tr, onPressed: () => Get.toNamed(RouteHelper.transactionHistoryScreen)),
                                ],
                              ),
                              const SizedBox(height: Dimensions.space10),
                              Column(
                                children: [
                                  Visibility(
                                    visible: controller.menuRepo.apiClient.getMultiLanguageStatus(),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MenuItems(
                                          imageSrc: MyIcons.language,
                                          label: MyStrings.language.tr,
                                          onPressed: () {
                                            Get.toNamed(RouteHelper.languageScreen);
                                          },
                                        ),
                                        const SizedBox(height: Dimensions.space10),
                                      ],
                                    ),
                                  ),
                                  MenuItems(
                                    imageSrc: MyIcons.privacy,
                                    label: MyStrings.privacyPolicy.tr,
                                    onPressed: () {
                                      Get.toNamed(RouteHelper.privacyScreen);
                                    },
                                  ),
                                  const SizedBox(height: Dimensions.space10),
                                  MenuItems(
                                    imageSrc: MyIcons.power,
                                    label: MyStrings.deleteAccount.tr,
                                    imgColor: MyColor.colorRed,
                                    textColor: MyColor.colorRed,
                                    onPressed: () {
                                      onDrawerItemTap();
                                      controller.passwordController.text = "";
                                      CustomBottomSheet(
                                        isNeedMargin: true,
                                        child: const DeleteAccountBottomsheetBody(),
                                      ).customBottomSheet(context);
                                    },
                                  ),
                                  const SizedBox(height: Dimensions.space50),
                                  const CustomDivider(space: 10),
                                  controller.logoutLoading
                                      ? const Align(
                                          alignment: Alignment.center,
                                          child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(color: MyColor.primaryColor, strokeWidth: 2.00),
                                          ),
                                        )
                                      : MenuItems(
                                          hideArrow: true,
                                          imageSrc: MyIcons.logout,
                                          label: MyStrings.logout.tr.toTitleCase(),
                                          onPressed: () => controller.logout(),
                                        )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
