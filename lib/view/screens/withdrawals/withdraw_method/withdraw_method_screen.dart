import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/helper/string_format_helper.dart';
import 'package:viserpay_merchant/core/route/route.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_images.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/controller/withdraw/withdraw_method_controller.dart';
import 'package:viserpay_merchant/data/repo/withdraw/withdraw_method_repo.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';
import 'package:viserpay_merchant/view/components/app-bar/custom_appbar.dart';
import 'package:viserpay_merchant/view/components/card/custom_card.dart';
import 'package:viserpay_merchant/view/components/custom_loader/custom_loader.dart';
import 'package:viserpay_merchant/view/components/divider/custom_divider.dart';
import 'package:viserpay_merchant/view/components/no_data.dart';
import 'package:viserpay_merchant/view/screens/withdrawals/withdraw_history/widget/status_widget.dart';

class WithdrawMethodScreen extends StatefulWidget {
  const WithdrawMethodScreen({super.key});

  @override
  State<WithdrawMethodScreen> createState() => _WithdrawMethodScreenState();
}

class _WithdrawMethodScreenState extends State<WithdrawMethodScreen> {
  final ScrollController scrollController = ScrollController();

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (Get.find<WithdrawMethodController>().hasNext()) {
        Get.find<WithdrawMethodController>().loadData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(WithdrawMethodRepo(apiClient: Get.find()));
    final controller = Get.put(WithdrawMethodController(withdrawMethodRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialData();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawMethodController>(
      builder: (controller) => Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar: CustomAppBar(title: MyStrings.withdrawMethod),
        body: controller.isLoading
            ? const CustomLoader()
            : SingleChildScrollView(
                padding: Dimensions.screenPaddingHV,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    CustomCard(
                      paddingTop: Dimensions.space15,
                      paddingBottom: Dimensions.space15,
                      isPress: true,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: MyColor.getPrimaryColor().withOpacity(0.2), shape: BoxShape.circle),
                            child: Image.asset(MyImages.addNewMethod, color: MyColor.getPrimaryColor(), height: 25, width: 25),
                          ),
                          const SizedBox(width: Dimensions.space15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${MyStrings.addNew.tr} +",
                                style: regularDefault.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: Dimensions.space8),
                              Text(
                                MyStrings.chooseNewWithdrawMethod.tr,
                                style: regularSmall.copyWith(color: MyColor.getTextColor().withOpacity(0.6)),
                              ),
                            ],
                          )
                        ],
                      ),
                      onPressed: () {
                        Get.toNamed(RouteHelper.addWithdrawMethodScreen);
                      },
                    ),
                    const SizedBox(height: Dimensions.space20),
                    controller.withdrawMoneyList.isEmpty
                        ? NoDataWidget(
                            margin: 12,
                            noDataText: MyStrings.emptyWithdrawMethodMsg.tr,
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.withdrawMoneyList.length,
                            separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                            itemBuilder: (context, index) {
                              return CustomCard(
                                paddingTop: Dimensions.space15,
                                paddingBottom: Dimensions.space15,
                                radius: Dimensions.defaultRadius,
                                isPress: true,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 35,
                                              width: 35,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(color: MyColor.getSymbolColor(index), shape: BoxShape.circle),
                                              child: Image.asset(MyImages.withdrawMoney, color: MyColor.colorWhite, height: 16, width: 16),
                                            ),
                                            const SizedBox(width: Dimensions.space15),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(controller.withdrawMoneyList[index].name ?? "", style: regularDefault.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w600)),
                                                const SizedBox(height: Dimensions.space5),
                                                Text("${controller.withdrawMoneyList[index].name ?? ""} - ${controller.currency}", style: regularSmall.copyWith(color: MyColor.getPrimaryColor())),
                                                const SizedBox(height: Dimensions.space10),
                                              ],
                                            )
                                          ],
                                        ),
                                        StatusWidget(status: controller.getStatusOrColor(index), color: controller.getStatusOrColor(index, isStatus: false))
                                      ],
                                    ),
                                    const CustomDivider(space: Dimensions.space10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              MyStrings.limit.tr,
                                              style: regularSmall.copyWith(color: MyColor.getTextColor().withOpacity(0.6)),
                                            ),
                                            const SizedBox(height: Dimensions.space5),
                                            Text(
                                                "${Converter.formatNumber(controller.withdrawMoneyList[index].minLimit ?? "")} ~ "
                                                "${Converter.formatNumber(controller.withdrawMoneyList[index].maxLimit ?? "")} "
                                                "${controller.currency}",
                                                style: regularSmall.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w600)),
                                          ],
                                        ),
                                        const SizedBox(width: Dimensions.space10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              MyStrings.charge.tr,
                                              style: regularSmall.copyWith(color: MyColor.getTextColor().withOpacity(0.6)),
                                            ),
                                            const SizedBox(height: Dimensions.space5),
                                            Text(
                                                "${Converter.calculateRate(controller.withdrawMoneyList[index].withdrawMethod?.fixedCharge ?? '0', controller.withdrawMoneyList[index].withdrawMethod?.rate ?? '0')} "
                                                "${controller.currency} + "
                                                "${Converter.formatNumber(controller.withdrawMoneyList[index].withdrawMethod?.percentCharge ?? "")}%",
                                                style: regularSmall.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w600)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  String id = controller.withdrawMoneyList[index].id.toString();
                                  Get.toNamed(RouteHelper.editWithdrawMethod, arguments: id);
                                },
                              );
                            },
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}
