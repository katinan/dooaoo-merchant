import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:viserpay_merchant/core/helper/string_format_helper.dart';
import 'package:viserpay_merchant/core/route/route.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/core/utils/util.dart';
import 'package:viserpay_merchant/data/controller/home/home_controller.dart';
import 'package:viserpay_merchant/data/controller/menu/menu_controller.dart';
import 'package:viserpay_merchant/data/repo/auth/general_setting_repo.dart';
import 'package:viserpay_merchant/data/repo/home/home_repo.dart';
import 'package:viserpay_merchant/data/repo/menu_repo/menu_repo.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';
import 'package:viserpay_merchant/view/components/custom_loader/custom_loader.dart';
import 'package:viserpay_merchant/view/components/image/my_image_widget.dart';
import 'package:viserpay_merchant/view/components/will_pop_widget.dart';
import 'package:viserpay_merchant/view/screens/bottom_nav_section/home/widget/insight_section.dart';
import 'package:viserpay_merchant/view/screens/bottom_nav_section/home/widget/kyc_warning_section.dart';
import 'package:viserpay_merchant/view/screens/bottom_nav_section/home/widget/latest_transaction_section.dart';
import 'package:viserpay_merchant/view/screens/bottom_nav_section/home/widget/my_drawer.dart';

import 'package:viserpay_merchant/view/screens/bottom_nav_section/home/widget/withdraw_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    MyUtils.allScreen();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(HomeRepo(apiClient: Get.find()));
    Get.put(MenuRepo(apiClient: Get.find()));
    final menucontroller = Get.put(AppMenuController(menuRepo: Get.find(), repo: Get.find()));
    final controller = Get.put(HomeController(homeRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialData();
      menucontroller.loadData();
    });
  }

  @override
  void dispose() {
    MyUtils.allScreen();
    super.dispose();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: MyColor.colorWhite),
        child: WillPopWidget(
          nextRoute: "",
          child: SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              endDrawer: MyDrawer(onDrawerItemTap: _closeDrawer),
              backgroundColor: MyColor.getScreenBgColor(),
              appBar: homeScreenAppBar(context, controller, _scaffoldKey),
              body: controller.isLoading
                  ? const CustomLoader()
                  : RefreshIndicator(
                      backgroundColor: MyColor.colorWhite,
                      color: MyColor.primaryColor,
                      onRefresh: () async {
                        controller.initialData();
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const KYCWarningSection(),
                            const SizedBox(height: Dimensions.space10),
                            const InsightSection(),
                            Visibility(
                              visible: controller.isWithdrawEnable,
                              child: const Column(
                                children: [
                                  SizedBox(height: Dimensions.space10),
                                  WithdrawSection(),
                                ],
                              ),
                            ),
                            const SizedBox(height: Dimensions.space10),
                            const LatestTransactionSection()
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

PreferredSize homeScreenAppBar(BuildContext context, HomeController controller, GlobalKey<ScaffoldState> bootomNavscaffoldKey) {
  return PreferredSize(
    preferredSize: Size(MediaQuery.of(context).size.width, 80),
    child: Container(
      padding: const EdgeInsetsDirectional.only(top: 10, bottom: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: MyColor.colorWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(0, 2.0),
            blurRadius: 4.0,
          )
        ],
      ),
      child: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: MyColor.colorWhite,
        elevation: 0,
        title: Row(
          children: [
            if (controller.isLoading)
              Shimmer.fromColors(
                baseColor: MyColor.colorGrey.withOpacity(0.2),
                highlightColor: MyColor.primaryColor.withOpacity(0.7),
                child: Container(
                  decoration: BoxDecoration(color: MyColor.colorGrey.withOpacity(0.2), borderRadius: BorderRadius.circular(100)),
                  height: 40,
                  width: 40,
                ),
              )
            else
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.profileScreen);
                },
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: MyColor.borderColor, width: 0.5), shape: BoxShape.circle),
                  height: 40,
                  width: 40,
                  child: ClipOval(
                    child: MyImageWidget(
                      imageUrl: controller.imagePath,
                      boxFit: BoxFit.cover,
                      isProfle: true,
                    ),
                  ),
                ),
              ),
            const SizedBox(
              width: Dimensions.space10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.isLoading)
                  Shimmer.fromColors(
                    baseColor: MyColor.colorGrey.withOpacity(0.2),
                    highlightColor: MyColor.primaryColor.withOpacity(0.7),
                    child: Container(
                      decoration: BoxDecoration(color: MyColor.colorGrey.withOpacity(0.2), borderRadius: BorderRadius.circular(100)),
                      width: Dimensions.space60 + 100,
                      height: Dimensions.fontMediumLarge,
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: Dimensions.space10),
                    child: Text(
                      controller.fullName.toCapitalized(),
                      style: regularDefault.copyWith(
                        fontSize: Dimensions.fontMediumLarge,
                        fontWeight: FontWeight.w600,
                        color: MyColor.colorBlack,
                      ),
                    ),
                  ),
                const SizedBox(
                  height: Dimensions.space5,
                ),
                if (controller.isLoading)
                  Shimmer.fromColors(
                    baseColor: MyColor.colorGrey.withOpacity(0.2),
                    highlightColor: MyColor.primaryColor.withOpacity(0.7),
                    child: Container(
                      decoration: BoxDecoration(color: MyColor.colorGrey.withOpacity(0.2), borderRadius: BorderRadius.circular(100)),
                      width: Dimensions.space60 + 50,
                      height: Dimensions.fontMediumLarge,
                    ),
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ///Button
                      Material(
                        type: MaterialType.canvas,
                        color: MyColor.borderColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(50),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            controller.changeState();
                          },
                          child: Obx(
                            () => Container(
                              width: 170,
                              height: 28,
                              decoration: BoxDecoration(color: MyColor.transparentColor, borderRadius: BorderRadius.circular(50)),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  AnimatedOpacity(
                                    opacity: controller.isBalanceShown.value ? 1 : 0,
                                    duration: const Duration(milliseconds: 500),
                                    child: Text(
                                      Converter.formatNumber(controller.userBalance),
                                      style: const TextStyle(color: MyColor.primaryColor, fontSize: 14),
                                    ),
                                  ),

                                  /// tapForBalance
                                  AnimatedOpacity(
                                    opacity: controller.isBalance.value ? 1 : 0,
                                    duration: const Duration(milliseconds: 300),
                                    child: Text(
                                      MyStrings.tapForBalance.tr,
                                      style: TextStyle(color: MyColor.primaryColor.withOpacity(0.8), fontSize: 14),
                                    ),
                                  ),

                                  /// Circle
                                  AnimatedPositioned(
                                    duration: const Duration(milliseconds: 1100),
                                    left: controller.isAnimation.value == false ? 5 : 145,
                                    curve: Curves.fastOutSlowIn,
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      // padding: const EdgeInsetsDirectional.only(bottom: 4),
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(color: MyColor.primaryColor.withOpacity(0.8), borderRadius: BorderRadius.circular(50)),
                                      child: FittedBox(
                                        child: Text(
                                          controller.defaultCurrencySymbol,
                                          style: const TextStyle(color: Colors.white, fontSize: Dimensions.fontMediumLarge),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
        actions: [
          const SizedBox(
            width: Dimensions.space15,
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              bootomNavscaffoldKey.currentState!.openEndDrawer();
            },
            child: const Icon(
              Icons.menu,
              color: Colors.black,
              size: 28,
            ),
          ),
          const SizedBox(
            width: Dimensions.space15,
          ),
        ],
      ),
    ),
  );
}
