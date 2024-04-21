import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:viserpay_merchant/core/route/route.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_images.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/controller/auth/auth/sms_verification_controler.dart';
import 'package:viserpay_merchant/data/repo/auth/sms_email_verification_repo.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';
import 'package:viserpay_merchant/view/components/app-bar/custom_appbar.dart';
import 'package:viserpay_merchant/view/components/buttons/gradient_rounded_button.dart';
import 'package:viserpay_merchant/view/components/image/custom_svg_picture.dart';
import 'package:viserpay_merchant/view/components/text/default_text.dart';
import 'package:viserpay_merchant/view/components/text/small_text.dart';
import 'package:viserpay_merchant/view/components/will_pop_widget.dart';

class SmsVerificationScreen extends StatefulWidget {
  const SmsVerificationScreen({super.key});

  @override
  State<SmsVerificationScreen> createState() => _SmsVerificationScreenState();
}

class _SmsVerificationScreenState extends State<SmsVerificationScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SmsEmailVerificationRepo(apiClient: Get.find()));
    final controller = Get.put(SmsVerificationController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.isProfileCompleteEnable = Get.arguments[0];
      controller.loadBefore();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.loginScreen,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.getScreenBgColor(),
          appBar: CustomAppBar(
            fromAuth: true,
            title: MyStrings.smsVerification.tr,
            isShowBackBtn: true,
            bgColor: MyColor.getAppBarColor(),
          ),
          body: GetBuilder<SmsVerificationController>(
            builder: (controller) => controller.isLoading
                ? Center(child: CircularProgressIndicator(color: MyColor.getPrimaryColor()))
                : SingleChildScrollView(
                    padding: Dimensions.screenPaddingHV,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: Dimensions.space30),
                          Container(
                            height: 100,
                            width: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: MyColor.primaryColor.withOpacity(.075), shape: BoxShape.circle),
                            child: CustomSvgPicture(image: MyImages.emailVerifyImage, height: 50, width: 50, color: MyColor.getPrimaryColor()),
                          ),
                          const SizedBox(height: Dimensions.space50),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .07),
                            child: SmallText(text: MyStrings.smsVerificationMsg.tr, maxLine: 3, textAlign: TextAlign.center, textStyle: regularDefault.copyWith(color: MyColor.getLabelTextColor())),
                          ),
                          const SizedBox(height: Dimensions.space10),
                          DefaultText(text: "${MyStrings.phonenumber.tr}: ${controller.maskPhoneNumber(controller.userPhone)}", textAlign: TextAlign.center, textColor: MyColor.getContentTextColor()),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space30),
                            child: PinCodeTextField(
                              appContext: context,
                              pastedTextStyle: regularDefault.copyWith(color: MyColor.getPrimaryColor()),
                              length: 6,
                              textStyle: regularDefault.copyWith(color: MyColor.getPrimaryColor()),
                              obscureText: false,
                              obscuringCharacter: '*',
                              blinkWhenObscuring: false,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderWidth: 1,
                                  borderRadius: BorderRadius.circular(5),
                                  fieldHeight: 40,
                                  fieldWidth: 40,
                                  inactiveColor: MyColor.getTextFieldDisableBorder(),
                                  inactiveFillColor: MyColor.getScreenBgColor(),
                                  activeFillColor: MyColor.getScreenBgColor(),
                                  activeColor: MyColor.getPrimaryColor(),
                                  selectedFillColor: MyColor.getScreenBgColor(),
                                  selectedColor: MyColor.getPrimaryColor()),
                              cursorColor: MyColor.getTextColor(),
                              animationDuration: const Duration(milliseconds: 100),
                              enableActiveFill: true,
                              keyboardType: TextInputType.number,
                              beforeTextPaste: (text) {
                                return true;
                              },
                              onChanged: (value) {
                                setState(() {
                                  controller.currentText = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: Dimensions.space30),
                          GradientRoundedButton(
                            showLoadingIcon: controller.submitLoading,
                            text: MyStrings.verify.tr,
                            press: () {
                              controller.verifyYourSms(controller.currentText);
                            },
                          ),
                          const SizedBox(height: Dimensions.space30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(MyStrings.didNotReceiveCode.tr, style: regularDefault.copyWith(color: MyColor.getLabelTextColor())),
                              const SizedBox(width: Dimensions.space10),
                              controller.resendLoading
                                  ? Container(
                                      margin: const EdgeInsets.all(5),
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: MyColor.getPrimaryColor(),
                                      ))
                                  : GestureDetector(
                                      onTap: () {
                                        controller.sendCodeAgain();
                                      },
                                      child: Text(
                                        MyStrings.resendCode.tr,
                                        style: regularDefault.copyWith(
                                          decoration: TextDecoration.underline,
                                          decorationColor: MyColor.getPrimaryColor(),
                                          color: MyColor.getPrimaryColor(),
                                        ),
                                      ),
                                    ),
                            ],
                          )
                        ],
                      ),
                    )),
          ),
        ),
      ),
    );
  }
}
