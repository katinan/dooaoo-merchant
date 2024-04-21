import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/route/route.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_icons.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/core/utils/url_container.dart';
import 'package:viserpay_merchant/data/controller/auth/auth/registration_controller.dart';
import 'package:viserpay_merchant/view/components/buttons/gradient_rounded_button.dart';
import 'package:viserpay_merchant/view/components/image/my_image_widget.dart';
import 'package:viserpay_merchant/view/components/text-form-field/custom_text_field.dart';
import 'package:viserpay_merchant/view/screens/auth/registration/widget/country_bottom_sheet.dart';
import 'package:viserpay_merchant/view/screens/auth/registration/widget/validation_widget.dart';

import '../../../../../environment.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final formKey = GlobalKey<FormState>();
  bool isNumberBlank = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (controller) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                animatedLabel: true,
                needOutlineBorder: true,
                labelText: MyStrings.username.tr,
                controller: controller.userNameController,
                focusNode: controller.userNameFocusNode,
                textInputType: TextInputType.text,
                nextFocus: controller.emailFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return MyStrings.enterYourUsername.tr;
                  } else if (value.length < 6) {
                    return MyStrings.kShortUserNameError.tr;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  return;
                },
              ),
              const SizedBox(height: Dimensions.space20),
              CustomTextField(
                animatedLabel: true,
                needOutlineBorder: true,
                labelText: MyStrings.email.tr,
                controller: controller.emailController,
                focusNode: controller.emailFocusNode,
                textInputType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return MyStrings.enterYourEmail.tr;
                  } else if (!MyStrings.emailValidatorRegExp.hasMatch(value ?? '')) {
                    return MyStrings.invalidEmailMsg.tr;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  return;
                },
              ),
              const SizedBox(height: Dimensions.space20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isNumberBlank ? MyColor.colorRed : MyColor.getTextFieldDisableBorder(),
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                ),
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        CountryBottomSheet.bottomSheet(context, controller);
                      },
                      child: Container(
                        // padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: MyColor.transparentColor,
                          borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyImageWidget(
                              imageUrl: UrlContainer.countryFlagImageLink.replaceAll("{countryCode}", (controller.selectedCountryData.countryCode ?? Environment.defaultCountryCode).toString().toLowerCase()),
                              height: Dimensions.space25,
                              width: Dimensions.space40 + 2,
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: Dimensions.space10),
                              child: Text(
                                "+${controller.selectedCountryData.dialCode ?? Environment.defaultPhoneCode}",
                                style: regularMediumLarge,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: MyColor.transparentColor,
                        padding: const EdgeInsetsDirectional.only(start: Dimensions.space5 + 2, bottom: 0),
                        child: TextFormField(
                          controller: controller.mobileController,
                          focusNode: controller.mobileFocusNode,
                          onFieldSubmitted: (text) => FocusScope.of(context).requestFocus(controller.passwordFocusNode),
                          onChanged: (value) {
                            controller.mobileController.text.isNotEmpty ? isNumberBlank = false : null;
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(Dimensions.space15),
                              child: SvgPicture.asset(
                                MyIcons.phoneSVG,
                              ),
                            ),
                            hintText: "000-000-000",
                            border: InputBorder.none, // Remove border
                            filled: false, // Remove fill
                            contentPadding: const EdgeInsetsDirectional.only(top: 9.5, start: 1.5, end: 15, bottom: 2),
                            hintStyle: regularMediumLarge.copyWith(color: MyColor.hintTextColor.withOpacity(0.5)),
                          ),
                          keyboardType: TextInputType.phone, // Set keyboard type to phone
                          style: regularMediumLarge,
                          cursorColor: MyColor.primaryColor, // Set cursor color to red
                          validator: (value) {
                            if (value!.isEmpty) {
                              setState(() {
                                isNumberBlank = true;
                              });
                            } else {
                              return null;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              isNumberBlank ? const SizedBox(height: Dimensions.space5) : const SizedBox.shrink(),
              isNumberBlank ? Padding(padding: const EdgeInsets.only(left: 8.0), child: Text(MyStrings.enterYourPhoneNumber.tr, style: regularSmall.copyWith(color: MyColor.colorRed))) : const SizedBox.shrink(),
              Visibility(
                visible: controller.hasPasswordFocus && controller.checkPasswordStrength,
                child: ValidationWidget(
                  list: controller.passwordValidationRules,
                ),
              ),
              const SizedBox(height: Dimensions.space20),
              Focus(
                  onFocusChange: (hasFocus) {
                    controller.changePasswordFocus(hasFocus);
                  },
                  child: CustomTextField(
                    animatedLabel: true,
                    needOutlineBorder: true,
                    isShowSuffixIcon: true,
                    isPassword: true,
                    labelText: MyStrings.password.tr,
                    controller: controller.passwordController,
                    focusNode: controller.passwordFocusNode,
                    nextFocus: controller.confirmPasswordFocusNode,
                    textInputType: TextInputType.text,
                    onChanged: (value) {
                      if (controller.checkPasswordStrength) {
                        controller.updateValidationList(value);
                      }
                    },
                    validator: (value) {
                      return controller.validatePassword(value ?? '');
                    },
                  )),
              const SizedBox(height: Dimensions.space20),
              CustomTextField(
                animatedLabel: true,
                needOutlineBorder: true,
                labelText: MyStrings.confirmPassword.tr,
                controller: controller.cPasswordController,
                focusNode: controller.confirmPasswordFocusNode,
                inputAction: TextInputAction.done,
                isShowSuffixIcon: true,
                isPassword: true,
                onChanged: (value) {},
                validator: (value) {
                  if (controller.passwordController.text != controller.cPasswordController.text) {
                    return MyStrings.kMatchPassError.tr;
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: Dimensions.space25),
              Visibility(
                  visible: controller.needAgree,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: Checkbox(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                          activeColor: MyColor.primaryColor,
                          checkColor: MyColor.colorWhite,
                          value: controller.agreeTC,
                          side: MaterialStateBorderSide.resolveWith(
                            (states) => BorderSide(width: 1.0, color: controller.agreeTC ? MyColor.getTextFieldEnableBorder() : MyColor.getTextFieldDisableBorder()),
                          ),
                          onChanged: (bool? value) {
                            controller.updateAgreeTC();
                          },
                        ),
                      ),
                      const SizedBox(width: Dimensions.space8),
                      Row(
                        children: [
                          Text(MyStrings.iAgreeWith.tr, style: regularDefault.copyWith(color: MyColor.getTextColor())),
                          const SizedBox(width: Dimensions.space3),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.privacyScreen);
                            },
                            child: Text(MyStrings.policies.tr.toLowerCase(), style: regularLarge.copyWith(color: MyColor.getPrimaryColor(), decoration: TextDecoration.underline, decorationColor: MyColor.getPrimaryColor())),
                          ),
                          const SizedBox(width: Dimensions.space3),
                        ],
                      ),
                    ],
                  )),
              const SizedBox(height: Dimensions.space30),
              GradientRoundedButton(
                  showLoadingIcon: controller.submitLoading,
                  text: MyStrings.signUp.tr,
                  press: () {
                    if (formKey.currentState!.validate() && isNumberBlank == false) {
                      controller.signUpUser();
                    }
                  }),
            ],
          ),
        );
      },
    );
  }
}
