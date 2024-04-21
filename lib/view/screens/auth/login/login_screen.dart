import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viserpay_merchant/core/route/route.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_images.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/core/utils/util.dart';
import 'package:viserpay_merchant/data/controller/auth/login_controller.dart';
import 'package:viserpay_merchant/data/repo/auth/login_repo.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';
import 'package:viserpay_merchant/view/components/buttons/gradient_rounded_button.dart';
import 'package:viserpay_merchant/view/components/text-form-field/custom_text_field.dart';
import 'package:viserpay_merchant/view/components/text/default_text.dart';
import 'package:viserpay_merchant/view/components/will_pop_widget.dart';

import '../../../../core/helper/shared_preference_helper.dart';
import '../../../../environment.dart';
import '../../../components/image/custom_svg_picture.dart';
import '../../bottom_nav_section/menu/widget/language_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    MyUtils.splashScreen();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    Get.put(LoginController(loginRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<LoginController>().remember = false;
    });
  }

  @override
  void dispose() {
    MyUtils.allScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(statusBarColor: MyColor.primaryColor, statusBarIconBrightness: Brightness.light, systemNavigationBarColor: MyColor.screenBgColor, systemNavigationBarIconBrightness: Brightness.dark),
      child: WillPopWidget(
        nextRoute: '',
        child: SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size(context.width, isLandscape ? context.height * .45 : context.height * .3),
                child: ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    height: 250, // Adjust the height of the curve
                    width: context.width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [MyColor.primaryColor, MyColor.primaryColor],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: isLandscape ? context.height * .15 : context.height * .1,
                          left: 0,
                          right: 0,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                MyImages.appLogo,
                                height: 45,
                                // color: MyColor.colorWhite,
                              ),
                              // const SizedBox(height:Dimensions.space10,),
                              // Text(MyStrings.merchant, style: regularLarge.copyWith(color: MyColor.colorWhite),)
                            ],
                          ),
                        ),
                        Get.find<LoginController>().loginRepo.apiClient.getMultiLanguageStatus()
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(RouteHelper.languageScreen);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsetsDirectional.only(top: 20, start: 15, end: 15),
                                      height: 33,
                                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 4),
                                      decoration: BoxDecoration(border: Border.all(color: MyColor.borderColor, width: 1), borderRadius: BorderRadius.circular(4)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.g_translate, color: MyColor.colorWhite, size: 14.5),
                                          const SizedBox(
                                            width: Dimensions.space2 + 1,
                                          ),
                                          Text(
                                            Get.find<SharedPreferences>().getString(SharedPreferenceHelper.languageCode)?.toUpperCase() ?? Environment.defaultLangCode.toUpperCase(),
                                            style: regularDefault.copyWith(color: MyColor.colorWhite),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                )),
            backgroundColor: MyColor.getScreenBgColor(isWhite: true),
            body: GetBuilder<LoginController>(
              builder: (controller) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: Dimensions.screenPaddingHV,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(MyStrings.login_.tr, style: title.copyWith(fontSize: 32)),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(MyStrings.loginMsg.tr, style: title.copyWith(fontSize: 16, color: MyColor.bodytextColor.withOpacity(0.6), fontWeight: FontWeight.w400)), //
                      ),
                      const SizedBox(height: Dimensions.space40),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomTextField(
                              animatedLabel: true,
                              needOutlineBorder: true,
                              controller: controller.emailController,
                              labelText: MyStrings.usernameOrEmail.tr,
                              onChanged: (value) {},
                              focusNode: controller.emailFocusNode,
                              nextFocus: controller.passwordFocusNode,
                              textInputType: TextInputType.emailAddress,
                              inputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return MyStrings.fieldErrorMsg.tr;
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: Dimensions.space20),
                            CustomTextField(
                              animatedLabel: true,
                              needOutlineBorder: true,
                              labelText: MyStrings.password.tr,
                              controller: controller.passwordController,
                              focusNode: controller.passwordFocusNode,
                              onChanged: (value) {},
                              isShowSuffixIcon: true,
                              isPassword: true,
                              textInputType: TextInputType.text,
                              inputAction: TextInputAction.done,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return MyStrings.fieldErrorMsg.tr;
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.clearTextField();
                                    Get.toNamed(RouteHelper.forgotPasswordScreen);
                                  },
                                  child: DefaultText(text: MyStrings.forgotPassword.tr, textColor: MyColor.getTextColor()),
                                )
                              ],
                            ),
                            const SizedBox(height: 25),
                            GradientRoundedButton(
                              showLoadingIcon: controller.isSubmitLoading,
                              text: MyStrings.signIn.tr,
                              press: () {
                                if (formKey.currentState!.validate()) {
                                  controller.loginMerchant();
                                }
                              },
                            ),
                            const SizedBox(height: 35),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(MyStrings.doNotHaveAccount.tr, overflow: TextOverflow.ellipsis, style: regularLarge.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w500)),
                                const SizedBox(width: Dimensions.space5),
                                TextButton(
                                  onPressed: () {
                                    Get.offAndToNamed(RouteHelper.registrationScreen);
                                  },
                                  child: Text(MyStrings.signUp.tr, maxLines: 2, overflow: TextOverflow.ellipsis, style: regularLarge.copyWith(color: MyColor.getPrimaryColor())),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 80);

    var firstControlPoint = Offset(size.width / 1.6, size.height + 70);
    var firstEndPoint = Offset(size.width, size.height - 60.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 60);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
