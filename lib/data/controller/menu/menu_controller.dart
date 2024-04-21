import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/route/route.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/data/model/authorization/authorization_response_model.dart';
import 'package:viserpay_merchant/data/model/general_setting/general_setting_response_model.dart';
import 'package:viserpay_merchant/data/model/global/response_model/response_model.dart';
import 'package:viserpay_merchant/data/repo/auth/general_setting_repo.dart';
import 'package:viserpay_merchant/data/repo/menu_repo/menu_repo.dart';
import 'package:viserpay_merchant/view/components/snack_bar/show_custom_snackbar.dart';

class AppMenuController extends GetxController {
  MenuRepo menuRepo;
  GeneralSettingRepo repo;
  AppMenuController({required this.menuRepo, required this.repo});

  bool logoutLoading = false;
  bool isLoading = true;
  bool noInternet = false;

  bool balTransferEnable = true;
  bool langSwitchEnable = true;

  void loadData() async {
    isLoading = true;
    update();
    await configureMenuItem();
    isLoading = false;
    update();
  }

  Future<void> logout() async {
    logoutLoading = true;
    update();

    await menuRepo.logout();
    CustomSnackBar.success(successList: [MyStrings.logoutSuccessMsg]);

    logoutLoading = false;
    update();
    Get.offAllNamed(RouteHelper.loginScreen);
  }

  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();

  bool removeLoading = false;
  Future<void> deleteAccount() async {
    removeLoading = true;
    update();
    if (passwordController.text.isEmpty) {
      CustomSnackBar.error(errorList: [MyStrings.enterYourPassword_]);
    } else {
      final responseModal = await menuRepo.removeAccount(passwordController.text);
      print(responseModal.statusCode);
      print(responseModal.statusCode);
      if (responseModal.statusCode == 200) {
        AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModal.responseJson));

            print(model.message!.toJson());
        if (model.status?.toLowerCase() == MyStrings.success) {
          await menuRepo.clearSharedPrefData();
          CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.logoutSuccessMsg]);
          Get.offAllNamed(RouteHelper.loginScreen);
        } else {
          CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.requestFail]);
        }
      } else {
        CustomSnackBar.error(errorList: [responseModal.message]);
      }
    }

    removeLoading = false;
    update();
  }

  //
  configureMenuItem() async {
    ResponseModel response = await repo.getGeneralSetting();

    if (response.statusCode == 200) {
      GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        bool langStatus = model.data?.generalSetting?.enableLanguage == '0' ? false : true;
        langSwitchEnable = langStatus;
        repo.apiClient.storeGeneralSetting(model);
        update();
      } else {
        List<String> message = [MyStrings.somethingWentWrong];
        CustomSnackBar.error(errorList: model.message?.error ?? message);
        return;
      }
    } else {
      if (response.statusCode == 503) {
        //noInternet=true;
        update();
      }
      CustomSnackBar.error(errorList: [response.message]);
      return;
    }
  }
}
