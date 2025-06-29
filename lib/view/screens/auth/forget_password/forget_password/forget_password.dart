import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/controller/auth/forget_password/forget_password_controller.dart';
import 'package:viserpay_merchant/data/repo/auth/login_repo.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';
import 'package:viserpay_merchant/view/components/app-bar/custom_appbar.dart';
import 'package:viserpay_merchant/view/components/buttons/gradient_rounded_button.dart';
import 'package:viserpay_merchant/view/components/buttons/rounded_button.dart';
import 'package:viserpay_merchant/view/components/buttons/rounded_loading_button.dart';
import 'package:viserpay_merchant/view/components/text-form-field/custom_text_field.dart';
import 'package:viserpay_merchant/view/components/text/default_text.dart';
import 'package:viserpay_merchant/view/components/text/header_text.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    Get.put(ForgetPasswordController(loginRepo: Get.find()));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: MyColor.colorWhite),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: MyColor.getScreenBgColor(),
            appBar: CustomAppBar(
              fromAuth: true,
              isShowBackBtn: true,
              title: MyStrings.forgetPassword.tr,
              bgColor: MyColor.getAppBarColor(),
            ),
            body: GetBuilder<ForgetPasswordController>(
              builder: (auth) => SingleChildScrollView(
                padding: Dimensions.screenPaddingHV,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimensions.space30),
                      HeaderText(text: MyStrings.recoverAccount.tr),
                      const SizedBox(height: 15),
                      DefaultText(text: MyStrings.forgetPasswordSubText.tr, textStyle: regularDefault.copyWith(color: MyColor.getTextColor().withOpacity(0.8))),
                      const SizedBox(height: Dimensions.space40),
                      CustomTextField(
                          animatedLabel: true,
                          needOutlineBorder: true,
                          labelText: MyStrings.usernameOrEmail.tr,
                          hintText: MyStrings.usernameOrEmailHint.tr,
                          textInputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.done,
                          controller: auth.emailOrUsernameController,
                          onSuffixTap: () {},
                          onChanged: (value) {
                            return;
                          },
                          validator: (value) {
                            if (auth.emailOrUsernameController.text.isEmpty) {
                              return MyStrings.enterEmailOrUserName.tr;
                            } else {
                              return null;
                            }
                          }),
                      const SizedBox(height: Dimensions.space25),
                      GradientRoundedButton(
                        showLoadingIcon: auth.submitLoading,
                        press: () {
                          if (_formKey.currentState!.validate()) {
                            auth.submitForgetPassCode();
                          }
                        },
                        text: MyStrings.submit.tr,
                      ),
                      const SizedBox(height: Dimensions.space40)
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
