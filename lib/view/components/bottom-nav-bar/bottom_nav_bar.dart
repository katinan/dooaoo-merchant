import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_images.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';
import 'package:viserpay_merchant/view/components/blur/blur_widget.dart';
import 'package:viserpay_merchant/view/screens/bottom_nav_section/home/home_screen.dart';
import 'package:viserpay_merchant/view/screens/bottom_nav_section/menu/menu_screen.dart';
import 'package:viserpay_merchant/view/screens/transaction/transaction_history_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> screens = [
    const HomeScreen(),
    const TransactionHistoryScreen(
      isShowBackBtn: false,
    ),
    const MenuScreen()
  ];

  int currentIndex = 0;

  bool isWithdrawEnable = true;

  @override
  void initState() {
    final apiClient = Get.put(ApiClient(sharedPreferences: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        isWithdrawEnable = apiClient.getWithdrawModuleStatus();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Blur(
        blur: 30,
        borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
        color: MyColor.colorWhite,
        elevation: 6,
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: MyColor.primaryColor.withOpacity(0.02),
            indicatorColor: MyColor.primaryColor.withOpacity(0.1),
            labelTextStyle: MaterialStateProperty.all(regularSmall),
            surfaceTintColor: Colors.white,
            shadowColor: Colors.white,
          ),
          child: NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: (index) {
              currentIndex = index;
              setState(() {});
            },
            destinations: [
              NavigationDestination(
                icon: Image.asset(
                  MyImages.home,
                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,
                  color: 0 == currentIndex ? MyColor.primaryColor : MyColor.iconColor,
                ),
                selectedIcon: Image.asset(
                  MyImages.home,
                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,
                  color: 0 == currentIndex ? MyColor.primaryColor : MyColor.iconColor,
                ),
                label: MyStrings.home.tr,
              ),
              NavigationDestination(
                icon: Image.asset(
                  MyImages.bottomTransaction,
                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,
                  color: 1 == currentIndex ? MyColor.primaryColor : MyColor.iconColor,
                ),
                selectedIcon: Image.asset(
                  MyImages.bottomTransaction,
                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,
                  color: 1 == currentIndex ? MyColor.primaryColor : MyColor.iconColor,
                ),
                label: MyStrings.transaction.tr,
              ),
              NavigationDestination(
                icon: Image.asset(
                  MyImages.bottomMenu,
                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,
                  color: MyColor.iconColor,
                ),
                selectedIcon: Image.asset(
                  MyImages.bottomMenu,
                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,
                  color: MyColor.primaryColor,
                ),
                label: MyStrings.menu.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }

  navBarItem(String imagePath, int index, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: NavigationDestination(
        icon: Image.asset(
          MyImages.home,
          height: 24,
          width: 24,
          fit: BoxFit.cover,
          color: 0 == currentIndex ? MyColor.primaryColor : MyColor.iconColor,
        ),
        selectedIcon: Image.asset(
          MyImages.home,
          height: 24,
          width: 24,
          fit: BoxFit.cover,
          color: 0 == currentIndex ? MyColor.primaryColor : MyColor.iconColor,
        ),
        label: MyStrings.home.tr,
      ),
    );
  }
}
