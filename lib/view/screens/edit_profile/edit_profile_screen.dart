import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/data/controller/account/profile_controller.dart';
import 'package:viserpay_merchant/data/repo/account/profile_repo.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';
import 'package:viserpay_merchant/view/components/app-bar/custom_appbar.dart';
import 'package:viserpay_merchant/view/components/custom_loader/custom_loader.dart';
import 'package:viserpay_merchant/view/screens/edit_profile/widget/edit_profile_form.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));
    final controller = Get.put(ProfileController(profileRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadProfileInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => Scaffold(
        backgroundColor: MyColor.screenBgColor,
        appBar: CustomAppBar(
          isShowBackBtn: true,
          bgColor: MyColor.getAppBarColor(),
          title: MyStrings.editProfile.tr,
        ),
        body: controller.isLoading
            ? const CustomLoader()
            : const SingleChildScrollView(
                padding: EdgeInsets.only(left: Dimensions.space15, right: Dimensions.space15, top: Dimensions.space20, bottom: Dimensions.space20),
                child: Column(
                  children: [EditProfileForm()],
                ),
              ),
      ),
    );
  }
}
