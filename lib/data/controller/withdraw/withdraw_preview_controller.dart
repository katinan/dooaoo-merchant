import 'dart:convert';

import 'package:get/get.dart';
import 'package:viserpay_merchant/core/helper/string_format_helper.dart';
import 'package:viserpay_merchant/core/route/route.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/data/model/authorization/authorization_response_model.dart';
import 'package:viserpay_merchant/data/model/global/response_model/response_model.dart';
import 'package:viserpay_merchant/data/model/withdraw/withdraw_preview_response_model.dart';
import 'package:viserpay_merchant/view/components/snack_bar/show_custom_snackbar.dart';
import '../../repo/withdraw/withdraw_money_repo.dart';

class WithdrawPreviewController extends GetxController {
  WithdrawMoneyRepo repo;
  WithdrawPreviewController({required this.repo});

  bool isLoading = true;

  String withdrawCharge = "";
  String youWillGet = "";
  String balanceWillBe = "";
  String selectedOtp = "";
  String remainingBalance = "";

  String currency = "";

  List<String> otpTypeList = [];

  WithdrawPreviewResponseModel model = WithdrawPreviewResponseModel();

  setSelectedOTP(String? otp) {
    selectedOtp = otp ?? "";
    update();
  }

  Future<void> loadData(String trxId) async {
    currency = repo.apiClient.getCurrencyOrUsername(isCurrency: true);
    isLoading = true;
    update();

    ResponseModel responseModel = await repo.getPreviewData(trx: trxId);
    otpTypeList.clear();

    otpTypeList.insert(0, MyStrings.selectOtp);

    if (responseModel.statusCode == 200) {
      model = WithdrawPreviewResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        withdrawCharge = model.data?.withdraw?.charge ?? "";
        youWillGet = model.data?.withdraw?.finalAmount ?? "";
        remainingBalance = Converter.formatNumber(model.data?.remainingBalance ?? "");

        List<String>? tempOtpList = model.data?.otpType;
        if (tempOtpList != null || tempOtpList!.isNotEmpty) {
          otpTypeList.addAll(tempOtpList);
        }
        if (tempOtpList.isNotEmpty) {
          selectedOtp = otpTypeList[0];
          setSelectedOTP(selectedOtp);
        }
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isLoading = false;
    update();
  }

  bool submitLoading = false;
  Future<void> submitMoney({required String trxId}) async {
    submitLoading = true;
    update();

    ResponseModel responseModel = await repo.submitData(otpType: selectedOtp.toString().toLowerCase(), trx: trxId);
    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        String actionId = model.data?.actionId ?? "";

        if (actionId.isNotEmpty) {
          Get.toNamed(RouteHelper.otpScreen, arguments: [actionId, RouteHelper.withdrawHistoryScreen, selectedOtp.toLowerCase().toString()]);
        } else {
          Get.offAndToNamed(RouteHelper.withdrawHistoryScreen);
          CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.requestSuccess]);
        }
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    submitLoading = false;
    update();
  }
}
