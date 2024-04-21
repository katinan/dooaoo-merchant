import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/data/controller/account/profile_complete_controller.dart';
import 'package:viserpay_merchant/data/repo/account/profile_repo.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';
import 'package:viserpay_merchant/view/components/app-bar/custom_appbar.dart';
import 'package:viserpay_merchant/view/components/buttons/gradient_rounded_button.dart';
import 'package:viserpay_merchant/view/components/text-form-field/custom_text_field.dart';
import 'package:viserpay_merchant/view/components/will_pop_widget.dart';
import 'package:viserpay_merchant/view/screens/auth/profile_complete/widget/image_widget.dart';

class ProfileCompleteScreen extends StatefulWidget {
  const ProfileCompleteScreen({super.key});

  @override
  State<ProfileCompleteScreen> createState() => _ProfileCompleteScreenState();
}

class _ProfileCompleteScreenState extends State<ProfileCompleteScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(
      apiClient: Get.find(),
    ));
    Get.put(ProfileCompleteController(profileRepo: Get.find()));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: '',
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.getScreenBgColor(isWhite: true),
          appBar: CustomAppBar(
            title: MyStrings.profileComplete.tr,
            isShowBackBtn: true,
            fromAuth: false,
            isProfileCompleted: true,
            bgColor: MyColor.getAppBarColor(),
          ),
          body: GetBuilder<ProfileCompleteController>(
            builder: (controller) => SingleChildScrollView(
              padding: Dimensions.screenPaddingHV,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: Dimensions.space5,
                    ),
                    CustomImageWidget(imagePath: '', onClicked: () {}),
                    const SizedBox(
                      height: Dimensions.space20,
                    ),
                    CustomTextField(
                      // animatedLabel: true,
                      isRequired: true,
                      needOutlineBorder: true,
                      labelText: MyStrings.firstName.tr,
                      //hintText: "${MyStrings.enterYour.tr} ${MyStrings.firstName.toLowerCase().tr}",
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      focusNode: controller.firstNameFocusNode,
                      controller: controller.firstNameController,
                      nextFocus: controller.lastNameFocusNode,
                      onChanged: (value) {
                        return;
                      },
                    ),
                    const SizedBox(height: Dimensions.space25),
                    CustomTextField(
                      // animatedLabel: true,
                      isRequired: true,
                      needOutlineBorder: true,
                      labelText: MyStrings.lastName.tr,
                      //hintText: "${MyStrings.enterYour.tr} ${MyStrings.lastName.toLowerCase().tr}",
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      focusNode: controller.lastNameFocusNode,
                      controller: controller.lastNameController,
                      nextFocus: controller.addressFocusNode,
                      onChanged: (value) {
                        return;
                      },
                    ),
                    const SizedBox(height: Dimensions.space25),
                    CustomTextField(
                      // animatedLabel: true,
                      needOutlineBorder: true,
                      labelText: MyStrings.address.tr,
                      //hintText: "${MyStrings.enterYour.tr} ${MyStrings.address.toLowerCase().tr}",
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      focusNode: controller.addressFocusNode,
                      controller: controller.addressController,
                      nextFocus: controller.stateFocusNode,
                      onChanged: (value) {
                        return;
                      },
                    ),
                    const SizedBox(height: Dimensions.space25),
                    CustomTextField(
                      // animatedLabel: true,
                      needOutlineBorder: true,
                      labelText: MyStrings.state.tr,
                      //hintText: "${MyStrings.enterYour.tr} ${MyStrings.state.toLowerCase().tr}",
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      focusNode: controller.stateFocusNode,
                      controller: controller.stateController,
                      nextFocus: controller.cityFocusNode,
                      onChanged: (value) {
                        return;
                      },
                    ),
                    const SizedBox(height: Dimensions.space25),
                    CustomTextField(
                      // animatedLabel: true,
                      needOutlineBorder: true,
                      labelText: MyStrings.city.tr,
                      //hintText: "${MyStrings.enterYour.tr} ${MyStrings.city.toLowerCase().tr}",
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      focusNode: controller.cityFocusNode,
                      controller: controller.cityController,
                      nextFocus: controller.zipCodeFocusNode,
                      onChanged: (value) {
                        return;
                      },
                    ),
                    const SizedBox(height: Dimensions.space25),
                    CustomTextField(
                      // animatedLabel: true,
                      needOutlineBorder: true,
                      labelText: MyStrings.zipCode.tr,
                      //hintText: "${MyStrings.enterYour.tr} ${MyStrings.zipCode.toLowerCase().tr}",
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.done,
                      focusNode: controller.zipCodeFocusNode,
                      controller: controller.zipCodeController,
                      onChanged: (value) {
                        return;
                      },
                    ),
                    const SizedBox(height: Dimensions.space35),
                    GradientRoundedButton(
                      showLoadingIcon: controller.submitLoading,
                      text: MyStrings.updateProfile.tr,
                      press: () {
                        controller.updateProfile();
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
