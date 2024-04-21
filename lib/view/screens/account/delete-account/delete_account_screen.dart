import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/controller/menu/menu_controller.dart';
import 'package:viserpay_merchant/view/components/app-bar/custom_appbar.dart';
import 'package:viserpay_merchant/view/components/buttons/gradient_rounded_danger_button.dart';
import 'package:viserpay_merchant/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:viserpay_merchant/view/components/text-form-field/custom_text_field.dart';

class DisableAccountScreen extends StatelessWidget {
  const DisableAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.colorWhite,
      appBar: CustomAppBar(title: MyStrings.accountDelete, isTitleCenter: true),
      body: GetBuilder<AppMenuController>(builder: (controller) {
        return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: Dimensions.defaultPaddingHV,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.space20, horizontal: Dimensions.space10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Dimensions.space20),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${MyStrings.deleteAccount.tr} ?",
                            style: boldMediumLarge.copyWith(
                              color: MyColor.colorRed,
                            ),
                          )
                        ],
                        text: MyStrings.areyouSurewantTodeleteAccount.tr,
                        style: regularMediumLarge,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Dimensions.space10),
                     Text(MyStrings.enterYourPassword_.tr, style: regularDefault),
                    const SizedBox(height: 2),
                    Text(
                      MyStrings.afterdelectyoucanback.tr,
                      style: mediumSmall.copyWith(color: MyColor.colorGrey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 25),
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
                    const SizedBox(height: Dimensions.space50),
                    GradientRoundedDangerButton(
                      showLoadingIcon: controller.removeLoading,
                      text: MyStrings.deleteAccount.tr,
                      press: () {
                        if (controller.passwordController.text.isEmpty) {
                          CustomSnackBar.error(errorList: [MyStrings.enterYourPassword_]);
                        } else {
                          controller.deleteAccount();
                        }
                      },
                    ),
                    const SizedBox(height: Dimensions.space50),
                  ],
                ),
              ),
            ));
      }),
    );
  }
}
