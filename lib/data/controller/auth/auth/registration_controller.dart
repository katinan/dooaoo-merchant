import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viserpay_merchant/core/helper/shared_preference_helper.dart';
import 'package:viserpay_merchant/core/route/route.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/data/model/auth/sign_up_model/registration_response_model.dart';
import 'package:viserpay_merchant/data/model/auth/sign_up_model/sign_up_model.dart';
import 'package:viserpay_merchant/data/model/country_model/country_model.dart';
import 'package:viserpay_merchant/data/model/general_setting/general_setting_response_model.dart';
import 'package:viserpay_merchant/data/model/global/response_model/response_model.dart';
import 'package:viserpay_merchant/data/repo/auth/general_setting_repo.dart';
import 'package:viserpay_merchant/data/repo/auth/signup_repo.dart';
import 'package:viserpay_merchant/environment.dart';
import 'package:viserpay_merchant/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:viserpay_merchant/view/screens/auth/registration/model/error_model.dart';

class RegistrationController extends GetxController {
  RegistrationRepo registrationRepo;
  GeneralSettingRepo generalSettingRepo;

  RegistrationController({required this.registrationRepo, required this.generalSettingRepo});

  bool isLoading = true;
  bool agreeTC = false;

  GeneralSettingResponseModel generalSettingMainModel = GeneralSettingResponseModel();

  //it will come from general setting api
  bool checkPasswordStrength = false;
  bool needAgree = true;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode countryNameFocusNode = FocusNode();
  final FocusNode mobileFocusNode = FocusNode();
  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode companyNameFocusNode = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  String? email;
  String? password;
  String? confirmPassword;
  String? countryName;
  String? countryCode;
  String? mobileCode;
  String? userName;
  String? phoneNo;
  String? firstName;
  String? lastName;

  RegExp regex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  bool submitLoading = false;

  signUpUser() async {
    SignUpModel model = getUserData();
    if (countryName == null) {
      CustomSnackBar.error(errorList: [MyStrings.selectACountry]);
      update();
      return;
    }

    if (mobileController.text.isEmpty) {
      CustomSnackBar.error(errorList: [MyStrings.enterYourPhoneNumber]);
      return;
    }

    if (needAgree && !agreeTC) {
      CustomSnackBar.error(
        errorList: [MyStrings.agreePolicyMessage],
      );
      return;
    }

    submitLoading = true;
    update();

    final responseModel = await registrationRepo.registerUser(model);
    if (responseModel.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
      CustomSnackBar.success(successList: responseModel.message?.success ?? [MyStrings.success.tr]);
      checkAndGotoNextStep(responseModel);
    } else {
      CustomSnackBar.error(errorList: responseModel.message?.error ?? [MyStrings.somethingWentWrong.tr]);
    }
    submitLoading = false;
    update();
  }

  setCountryNameAndCode(String cName, String countryCode, String mobileCode) {
    countryName = cName;
    this.countryCode = countryCode;
    this.mobileCode = mobileCode;
    update();
  }

  updateAgreeTC() {
    agreeTC = !agreeTC;
    update();
  }

  SignUpModel getUserData() {
    SignUpModel model = SignUpModel(
      mobile: mobileController.text.toString(),
      email: emailController.text.toString(),
      agree: agreeTC ? true : false,
      username: userNameController.text.toString(),
      password: passwordController.text.toString(),
      country: countryName.toString(),
      mobileCode: mobileCode != null ? mobileCode!.replaceAll("[+]", "") : "",
      countryCode: countryCode ?? '',
    );

    return model;
  }

  void checkAndGotoNextStep(RegistrationResponseModel responseModel) async {
    bool needEmailVerification = responseModel.data?.merchant?.ev == "1" ? false : true;
    bool needSmsVerification = responseModel.data?.merchant?.sv == "1" ? false : true;

    SharedPreferences preferences = registrationRepo.apiClient.sharedPreferences;

    await preferences.setString(SharedPreferenceHelper.userIdKey, responseModel.data?.merchant?.id.toString() ?? '-1');
    await preferences.setString(SharedPreferenceHelper.accessTokenKey, responseModel.data?.accessToken ?? '');
    await preferences.setString(SharedPreferenceHelper.accessTokenType, responseModel.data?.tokenType ?? '');
    await preferences.setString(SharedPreferenceHelper.userEmailKey, responseModel.data?.merchant?.email ?? '');
    await preferences.setString(SharedPreferenceHelper.userNameKey, responseModel.data?.merchant?.username ?? '');
    await preferences.setString(SharedPreferenceHelper.userPhoneNumberKey, responseModel.data?.merchant?.mobile ?? '');


    bool isProfileCompleteEnable = true;
    bool isTwoFactorEnable = false;

    if (needEmailVerification == false && needSmsVerification == false) {
      Get.offAndToNamed(RouteHelper.profileCompleteScreen);
    } else if (needEmailVerification == true && needSmsVerification == true) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen, arguments: [true, isProfileCompleteEnable, isTwoFactorEnable]);
    } else if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen, arguments: [false, isProfileCompleteEnable, isTwoFactorEnable]);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerificationScreen, arguments: [isProfileCompleteEnable, isTwoFactorEnable]);
    }
  }

  void closeAllController() {
    isLoading = false;
    emailController.text = '';
    passwordController.text = '';
    cPasswordController.text = '';
    fNameController.text = '';
    lNameController.text = '';
    mobileController.text = '';
    countryController.text = '';
    userNameController.text = '';
    companyNameController.text = '';
  }

  clearAllData() {
    closeAllController();
  }

  List<ErrorModel> passwordValidationRules = [
    ErrorModel(text: MyStrings.hasUpperLetter.tr, hasError: true),
    ErrorModel(text: MyStrings.hasLowerLetter.tr, hasError: true),
    ErrorModel(text: MyStrings.hasDigit.tr, hasError: true),
    ErrorModel(text: MyStrings.hasSpecialChar.tr, hasError: true),
    ErrorModel(text: MyStrings.minSixChar.tr, hasError: true),
  ];

  bool isCountryLoading = true;

  void initData() async {
    isLoading = true;
    update();
    await getCountryData();

    ResponseModel response = await generalSettingRepo.getGeneralSetting();
    if (response.statusCode == 200) {
      GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase() == 'success') {
        generalSettingMainModel = model;
        registrationRepo.apiClient.storeGeneralSetting(model);
      } else {
        List<String> message = [MyStrings.somethingWentWrong.tr];
        CustomSnackBar.error(errorList: model.message?.error ?? message);
        return;
      }
    } else {
      if (response.statusCode == 503) {
        noInternet = true;
        update();
      }
      CustomSnackBar.error(errorList: [response.message]);
      return;
    }

    needAgree = generalSettingMainModel.data?.generalSetting?.agree.toString() == '0' ? false : true;
    checkPasswordStrength = generalSettingMainModel.data?.generalSetting?.securePassword.toString() == '0' ? false : true;

    isLoading = false;
    update();
  }

  // country data
  bool countryLoading = true;
  List<Countries> countryList = [];

  List<Countries> filteredCountries = [];
  String defaultCountryCode = Environment.defaultCountryCode; //Default Country Code
  String dialCode = Environment.defaultPhoneCode;
  void updateMobilecode(String code) {
    dialCode = code;
    update();
  }

  Countries selectedCountryData = Countries(
    country: Environment.defaultCountryCode,
    countryCode: Environment.defaultCountryCode,
    dialCode: Environment.defaultPhoneCode,
  );

  selectCountryData(Countries value) {
    selectedCountryData = value;
    setCountryNameAndCode(value.country ?? defaultCountryCode, value.countryCode ?? dialCode, value.dialCode ?? dialCode);
    update();
  }

  Future<dynamic> getCountryData() async {
    ResponseModel mainResponse = await registrationRepo.getCountryList();

    if (mainResponse.statusCode == 200) {
      CountryModel model = CountryModel.fromJson(jsonDecode(mainResponse.responseJson));
      List<Countries>? tempList = model.data?.countries;

      if (tempList != null && tempList.isNotEmpty) {
        countryList.addAll(tempList);
      }

      var selectDefCountry = tempList!.firstWhere(
        (country) => country.countryCode!.toLowerCase() == Environment.defaultCountryCode.toLowerCase(),
        orElse: () => Countries(),
      );
      if (selectDefCountry.dialCode != null) {
        selectCountryData(selectDefCountry);
        setCountryNameAndCode(selectDefCountry.country.toString(), selectDefCountry.countryCode.toString(), selectDefCountry.dialCode.toString());
      }

      countryLoading = false;
      update();
      return;
    } else {
      CustomSnackBar.error(errorList: [mainResponse.message]);

      countryLoading = false;
      update();
      return;
    }
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return MyStrings.enterYourPassword_.tr;
    } else {
      if (checkPasswordStrength) {
        if (!regex.hasMatch(value)) {
          return MyStrings.invalidPassMsg.tr;
        } else {
          return null;
        }
      } else {
        return null;
      }
    }
  }

  bool noInternet = false;
  void changeInternet(bool hasInternet) {
    noInternet = false;
    initData();
    update();
  }

  void updateValidationList(String value) {
    passwordValidationRules[0].hasError = value.contains(RegExp(r'[A-Z]')) ? false : true;
    passwordValidationRules[1].hasError = value.contains(RegExp(r'[a-z]')) ? false : true;
    passwordValidationRules[2].hasError = value.contains(RegExp(r'[0-9]')) ? false : true;
    passwordValidationRules[3].hasError = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ? false : true;
    passwordValidationRules[4].hasError = value.length >= 6 ? false : true;
    update();
  }

  bool hasPasswordFocus = false;
  void changePasswordFocus(bool hasFocus) {
    hasPasswordFocus = hasFocus;
    update();
  }

  bool isActiveAccount = true;
  void changeState(bool activeState) {
    isActiveAccount = activeState;
    update();
  }
}
