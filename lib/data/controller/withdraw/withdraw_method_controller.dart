import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/data/model/global/response_model/response_model.dart';
import 'package:viserpay_merchant/data/model/withdraw/withdraw_method_response_model.dart';
import 'package:viserpay_merchant/data/repo/withdraw/withdraw_method_repo.dart';
import 'package:viserpay_merchant/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:viserpay_merchant/data/model/withdraw/withdraw_money_response_model.dart' as wm_model;

class WithdrawMethodController extends GetxController {
  WithdrawMethodRepo withdrawMethodRepo;
  WithdrawMethodController({required this.withdrawMethodRepo});

  bool isLoading = true;
  WithdrawMethodResponseModel model = WithdrawMethodResponseModel();
  late WithdrawMethod? addMethod;

  // List<WithdrawMethod> methodList = [];
  wm_model.WithdrawMoneyResponseModel wmModel = wm_model.WithdrawMoneyResponseModel();

  List<wm_model.Method> withdrawMoneyList = [];
  int page = 0;
  String? nextPageUrl;

  setAddMethod(WithdrawMethod? data) async {
    addMethod = data;
    update();
  }

  String currency = "";
  String currencySym = "";
  void initialData() async {
    currency = withdrawMethodRepo.apiClient.getCurrencyOrUsername(isCurrency: true);
    currencySym = withdrawMethodRepo.apiClient.getCurrencyOrUsername(isSymbol: true);
    page = 0;
    // methodList.clear();
    withdrawMoneyList.clear();
    isLoading = true;
    update();

    await loadData();

    isLoading = false;
    update();
  }

  Future<void> loadData() async {
    page = page + 1;

    if (page == 1) {
      withdrawMoneyList.clear();
    }

    ResponseModel responseModel = await withdrawMethodRepo.getData(page);
    if (responseModel.statusCode == 200) {
      wmModel = wm_model.WithdrawMoneyResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      if (wmModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        List<wm_model.Method>? tempWithdrawMoneyList = wmModel.data?.methods?.data;
        if (tempWithdrawMoneyList != null && tempWithdrawMoneyList.isNotEmpty) {
          withdrawMoneyList.addAll(tempWithdrawMoneyList);
        }
      } else {
        CustomSnackBar.error(errorList: wmModel.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isLoading = false;
    update();
  }

  bool hasNext() {
    return nextPageUrl != null && nextPageUrl!.isNotEmpty && nextPageUrl != 'null' ? true : false;
  }

  dynamic getStatusOrColor(int index, {bool isStatus = true}) {
    String status = withdrawMoneyList[index].status ?? '';

    if (isStatus) {
      String text = status == "0"
          ? MyStrings.disabled
          : status == "1"
              ? MyStrings.enabled
              : "";
      return text;
    } else {
      Color color = status == "0"
          ? MyColor.colorOrange
          : status == "1"
              ? MyColor.colorGreen
              : MyColor.colorGreen;
      return color;
    }
  }
}
