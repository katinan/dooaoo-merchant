import 'dart:convert';

import 'package:get/get.dart';
import 'package:viserpay_merchant/core/helper/string_format_helper.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/data/model/general_setting/general_setting_response_model.dart';
import 'package:viserpay_merchant/data/model/global/response_model/response_model.dart';
import 'package:viserpay_merchant/data/model/home/home_response_model.dart';
import 'package:viserpay_merchant/data/repo/home/home_repo.dart';
import 'package:viserpay_merchant/view/components/snack_bar/show_custom_snackbar.dart';

class HomeController extends GetxController {
  HomeRepo homeRepo;
  HomeController({required this.homeRepo});

  bool isLoading = true;

  String username = "";
  String userBalance = "";
  String email = "";
  String totalMoneyIn = "";
  String totalMoneyOut = "";
  String defaultCurrency = "";
  String defaultCurrencySymbol = "";
  String siteName = "";
  String totalWithdraw = "";
  String imagePath = "";
  String fullName = "";
  String mobile = "";
  bool isKycVerified = true;
  bool isKycPending = false;

  HomeResponseModel model = HomeResponseModel();
  GeneralSettingResponseModel generalSettingResponseModel = GeneralSettingResponseModel();
  List<LatestTrx> trxList = [];

  void initialData() async {
    defaultCurrency = homeRepo.apiClient.getCurrencyOrUsername(isCurrency: true);
    defaultCurrencySymbol = homeRepo.apiClient.getCurrencyOrUsername(isSymbol: true);
    trxList.clear();
    isLoading = true;
    update();

    await loadData();
    isLoading = false;
    update();
  }

  bool isWithdrawEnable = true;
  Future<void> loadData() async {
    isWithdrawEnable = homeRepo.apiClient.getWithdrawModuleStatus();
    defaultCurrency = homeRepo.apiClient.getCurrencyOrUsername();
    defaultCurrencySymbol = homeRepo.apiClient.getCurrencyOrUsername(isSymbol: true);
    generalSettingResponseModel = homeRepo.apiClient.getGSData();
    siteName = generalSettingResponseModel.data?.generalSetting?.siteName ?? "";

    ResponseModel responseModel = await homeRepo.getData();
    if (responseModel.statusCode == 200) {
      model = HomeResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.remark!.toLowerCase() == "unauthenticated") {
        // menuRepo.logout();
      }
      if (model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        userBalance = model.data?.merchant?.balance ?? "";
        username = model.data?.merchant?.username ?? "";
        email = model.data?.merchant?.email ?? "";
        mobile = model.data?.merchant?.mobile ?? "";
        fullName = "${model.data?.merchant?.firstname} ${model.data?.merchant?.lastname}";
        totalMoneyIn = "${Converter.formatNumber(model.data?.last7DayMoneyInOut?.totalMoneyIn ?? "")} $defaultCurrency";
        totalMoneyOut = "${Converter.formatNumber(model.data?.last7DayMoneyInOut?.totalMoneyOut ?? "")} $defaultCurrency";
        totalWithdraw = model.data?.totalWithdraw ?? "";
        imagePath = model.data?.merchant?.getImage ?? '';
        isKycVerified = model.data?.merchant?.kv == '1';
        isKycPending = model.data?.merchant?.kv == '2';
        List<LatestTrx>? tempTrxList = model.data?.latestTrx;
        if (tempTrxList != null && tempTrxList.isNotEmpty) {
          trxList.addAll(tempTrxList);
        }
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isLoading = false;
    update();

    await homeRepo.refreshGeneralSetting();
    await homeRepo.refreshModuleSetting();
    isWithdrawEnable = homeRepo.apiClient.getWithdrawModuleStatus();

    update();
  }
  //

  //Balanace animation
  RxBool isAnimation = false.obs;
  RxBool isBalanceShown = false.obs;
  RxBool isBalance = true.obs;
  RxBool isClickable = true.obs; // Add this boolean flag

  void changeState() async {
    if (!isClickable.value) {
      return;
    }

    isClickable.value = false; // Disable clicking during animation and showing balance
    isAnimation.value = true;
    isBalance.value = false;

    // First animation: Show balance text
    await Future.delayed(const Duration(milliseconds: 500));
    isBalanceShown.value = true;

    // Third animation: Hide the circle
    await Future.delayed(const Duration(seconds: 3));
    isAnimation.value = false;
    isBalanceShown.value = false;
    // Fourth animation: Show balance text again
    await Future.delayed(const Duration(milliseconds: 500));
    isBalance.value = true;

    isClickable.value = true; // Re-enable clicking after the animation
  }
}
