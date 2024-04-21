import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/data/controller/withdraw/withdraw_history_controller.dart';
import 'package:viserpay_merchant/data/repo/withdraw/withdraw_history_repo.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';
import 'package:viserpay_merchant/view/components/app-bar/action_button_icon_widget.dart';
import 'package:viserpay_merchant/view/components/app-bar/custom_appbar.dart';
import 'package:viserpay_merchant/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:viserpay_merchant/view/components/custom_loader/custom_loader.dart';
import 'package:viserpay_merchant/view/components/no_data.dart';
import 'package:viserpay_merchant/view/screens/withdrawals/withdraw_history/widget/withdraw_details_bottom_sheet.dart';
import 'package:viserpay_merchant/view/screens/withdrawals/withdraw_history/widget/withdraw_log_card.dart';
import 'package:viserpay_merchant/view/screens/withdrawals/withdraw_history/widget/withdraw_log_top.dart';

class WithdrawHistoryScreen extends StatefulWidget {
  final bool isShowBackBtn;
  const WithdrawHistoryScreen({super.key, required this.isShowBackBtn});

  @override
  State<WithdrawHistoryScreen> createState() => _WithdrawHistoryScreenState();
}

class _WithdrawHistoryScreenState extends State<WithdrawHistoryScreen> {
  final ScrollController scrollController = ScrollController();

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (Get.find<WithdrawHistoryController>().hasNext()) {
        Get.find<WithdrawHistoryController>().loadData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(WithdrawHistoryRepo(apiClient: Get.find()));
    final controller = Get.put(WithdrawHistoryController(withdrawHistoryRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialData();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawHistoryController>(
      builder: (controller) => Scaffold(
        backgroundColor: MyColor.screenBgColor,
        appBar: CustomAppBar(
          title: MyStrings.withdrawHistory,
          isShowBackBtn: widget.isShowBackBtn,
          action: [
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 10.0),
              child: ActionButtonIconWidget(
                pressed: () => controller.changeSearchStatus(),
                icon: controller.isSearch ? Icons.clear : Icons.search,
                backgroundColor: MyColor.primaryColor.withOpacity(0.1),
                iconColor: MyColor.primaryColor,
              ),
            ),
          ],
        ),
        body: controller.isLoading
            ? const CustomLoader()
            : Padding(
                padding: const EdgeInsets.only(top: Dimensions.space20, left: Dimensions.space15, right: Dimensions.space15),
                child: RefreshIndicator(
                  backgroundColor: MyColor.colorWhite,
                  color: MyColor.primaryColor,
                  onRefresh: () async {
                    controller.initialData();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: controller.isSearch,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            WithdrawLogTop(),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      controller.withdrawList.isEmpty && controller.filterLoading == false
                          ? Center(
                              child: NoDataWidget(
                                margin: 12,
                              ),
                            )
                          : controller.filterLoading
                              ? const CustomLoader()
                              : Expanded(
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                                      padding: EdgeInsets.zero,
                                      controller: scrollController,
                                      itemCount: controller.withdrawList.length + 1,
                                      separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                                      itemBuilder: (context, index) {
                                        if (controller.withdrawList.length == index) {
                                          return controller.hasNext() ? const CustomLoader(isPagination: true) : const SizedBox();
                                        }

                                        return WithdrawLogCard(
                                          index: index,
                                          press: () {
                                            CustomBottomSheet(child: WithdrawDetailsBottomSheet(index: index)).customBottomSheet(context);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
