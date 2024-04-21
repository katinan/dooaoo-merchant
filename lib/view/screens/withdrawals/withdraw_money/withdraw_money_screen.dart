import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/route/route.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/controller/withdraw/withdraw_money_controller.dart';
import 'package:viserpay_merchant/data/repo/withdraw/withdraw_money_repo.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';
import 'package:viserpay_merchant/view/components/app-bar/custom_appbar.dart';
import 'package:viserpay_merchant/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:viserpay_merchant/view/components/custom_loader/custom_loader.dart';
import 'package:viserpay_merchant/view/components/no_data.dart';
import 'package:viserpay_merchant/view/screens/withdrawals/withdraw_money/widget/withdraw_money_bottom_sheet.dart';
import 'package:viserpay_merchant/view/screens/withdrawals/withdraw_money/widget/withdraw_money_card.dart';

class WithdrawMoneyScreen extends StatefulWidget {
  const WithdrawMoneyScreen({super.key});

  @override
  State<WithdrawMoneyScreen> createState() => _WithdrawMoneyScreenState();
}

class _WithdrawMoneyScreenState extends State<WithdrawMoneyScreen> {
  final ScrollController scrollController = ScrollController();
  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (Get.find<WithdrawMoneyController>().hasNext()) {
        Get.find<WithdrawMoneyController>().loadData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(WithdrawMoneyRepo(apiClient: Get.find()));
    final controller = Get.put(WithdrawMoneyController(withdrawMoneyRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialData();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawMoneyController>(
      builder: (controller) => Scaffold(
        backgroundColor: MyColor.screenBgColor,
        appBar: CustomAppBar(
          title: MyStrings.withdrawMoney,
          backButtonOnPress: () {
            if (Get.previousRoute == RouteHelper.withdrawMethodScreen || Get.previousRoute == RouteHelper.addWithdrawMethodScreen) {
              Get.offAllNamed(RouteHelper.bottomNavBar);
            } else {
              Get.back();
            }
          },
          action: [
            Padding(
              padding: const EdgeInsets.all(Dimensions.space8),
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 1.0, color: MyColor.primaryColor),
                  ),
                  onPressed: () {
                    Get.toNamed(RouteHelper.withdrawMethodScreen)!.then((value) => controller.loadData());
                  },
                  child: Text(
                    "+ ${MyStrings.addMethod.tr}",
                    style: regularDefault.copyWith(color: MyColor.primaryColor),
                  )),
            )
          ],
        ),
        body: controller.isLoading
            ? const CustomLoader()
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: Dimensions.screenPaddingHV,
                child: controller.withdrawMoneyList.isEmpty
                    ? Center(
                        child: NoDataWidget(),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.withdrawMoneyList.length + 1,
                        separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10 + 2),
                        itemBuilder: (context, index) {
                          if (controller.withdrawMoneyList.length == index) {
                            return controller.hasNext() ? const CustomLoader(isPagination: true) : const SizedBox();
                          }
                          return WithdrawMoneyCard(
                            index: index,
                            // press: () {
                            //   print(controller.withdrawMoneyList[index].minLimit);
                            //   print(controller.withdrawMoneyList[index].maxLimit);
                            // },
                            press: () => CustomBottomSheet(child: WithdrawMoneyBottomSheet(index: index)).customBottomSheet(context),
                          );
                        }),
              ),
      ),
    );
  }
}
