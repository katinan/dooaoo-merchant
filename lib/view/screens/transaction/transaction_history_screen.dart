import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/data/controller/transaction/transaction_history_controller.dart';
import 'package:viserpay_merchant/data/repo/transaction/transaction_repo.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';
import 'package:viserpay_merchant/view/components/app-bar/action_button_icon_widget.dart';
import 'package:viserpay_merchant/view/components/app-bar/custom_appbar.dart';
import 'package:viserpay_merchant/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:viserpay_merchant/view/components/custom_loader/custom_loader.dart';
import 'package:viserpay_merchant/view/components/no_data.dart';
import 'package:viserpay_merchant/view/screens/transaction/widget/filters_field.dart';
import 'package:viserpay_merchant/view/screens/transaction/widget/transaction_card.dart';
import 'package:viserpay_merchant/view/screens/transaction/widget/transaction_history_bottom_sheet.dart';

class TransactionHistoryScreen extends StatefulWidget {
  final bool isShowBackBtn;
  const TransactionHistoryScreen({super.key, this.isShowBackBtn = true});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  late String trxType;

  final ScrollController scrollController = ScrollController();

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (Get.find<TransactionHistoryController>().hasNext()) {
        Get.find<TransactionHistoryController>().loadTransactionData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TransactionRepo(apiClient: Get.find()));
    final controller = Get.put(TransactionHistoryController(transactionRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      trxType = Get.arguments ?? "";
      controller.loadDefaultData(trxType);
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
    return GetBuilder<TransactionHistoryController>(
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: MyColor.screenBgColor,
        appBar: CustomAppBar(
          title: MyStrings.transaction,
          action: [
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 10.0),
              child: ActionButtonIconWidget(
                pressed: () => controller.changeSearchIcon(),
                icon: controller.isSearch ? Icons.clear : Icons.filter_alt_sharp,
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
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: controller.isSearch,
                        child: const FiltersField(),
                      ),
                      controller.transactionList.isEmpty && controller.filterLoading == false
                          ? Center(
                              child: NoDataWidget(
                                margin: 12,
                              ),
                            )
                          : controller.filterLoading
                              ? const CustomLoader()
                              : Expanded(
                                  flex: 0,
                                  child: ListView.separated(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: controller.transactionList.length + 1,
                                      separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                                      itemBuilder: (context, index) {
                                        if (controller.transactionList.length == index) {
                                          return controller.hasNext() ? const CustomLoader(isPagination: true) : const SizedBox();
                                        }
                                        return TransactionCard(
                                          index: index,
                                          press: () => CustomBottomSheet(child: TransactionHistoryBottomSheet(index: index)).customBottomSheet(context),
                                        );
                                      }),
                                ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
