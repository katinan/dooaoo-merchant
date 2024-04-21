import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_images.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/controller/qr_code/qr_code_controller.dart';
import 'package:viserpay_merchant/data/repo/qr_code/qr_code_repo.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';
import 'package:viserpay_merchant/view/components/app-bar/custom_appbar.dart';
import 'package:viserpay_merchant/view/components/buttons/gradient_rounded_button.dart';
import 'package:viserpay_merchant/view/components/custom_loader/custom_loader.dart';
import 'package:viserpay_merchant/view/components/image/my_image_widget.dart';

class MyQrCodeScreen extends StatefulWidget {
  const MyQrCodeScreen({super.key});

  @override
  State<MyQrCodeScreen> createState() => _MyQrCodeScreenState();
}

class _MyQrCodeScreenState extends State<MyQrCodeScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(QrCodeRepo(apiClient: Get.find()));
    final controller = Get.put(QrCodeController(qrCodeRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QrCodeController>(
      builder: (controller) => Scaffold(
        appBar: CustomAppBar(
          title: MyStrings.qrCode.tr,
          isShowBackBtn: true,
        ),
        body: SingleChildScrollView(
          padding: Dimensions.screenPaddingHV,
          child: controller.isLoading
              ? const CustomLoader(
                  loaderColor: MyColor.primaryColor,
                  isFullScreen: true,
                )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: Dimensions.space30),
                      MyImageWidget(
                        imageUrl: controller.qrCode,
                        height: 300,
                        width: 300,
                      ),

                      const SizedBox(height: Dimensions.space5),
                      Text(
                        controller.name.toUpperCase(),
                        style: semiBoldMediumLarge.copyWith(color: MyColor.colorBlack),
                      ),
                      const SizedBox(height: Dimensions.space15),
                      Text(
                        MyStrings.shareThisQrCodeSubTitle.tr,
                        style: regularDefault.copyWith(fontSize: Dimensions.fontDefault, color: MyColor.colorGrey),
                      ),
                      const SizedBox(height: Dimensions.space30),
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.space10),
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: MyColor.primaryColor,
                                  side: const BorderSide(color: MyColor.primaryColor, width: 0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(Dimensions.space10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      !controller.downloadLoading
                                          ? const Icon(
                                              Icons.download_for_offline,
                                              color: MyColor.primaryColor,
                                            )
                                          : const SizedBox.shrink(),
                                      const SizedBox(
                                        width: Dimensions.space3,
                                      ),
                                      Flexible(
                                        child: Text(
                                          controller.downloadLoading ? "${MyStrings.downloading.tr}..." : MyStrings.download.tr,
                                          overflow: TextOverflow.ellipsis,
                                          style: regularDefault.copyWith(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onPressed: () async {
                                  if (!controller.downloadLoading) {
                                    controller.downloadImage();
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: Dimensions.space12),
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: MyColor.primaryColor,
                                  side: const BorderSide(color: MyColor.primaryColor, width: 0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(Dimensions.space10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.ios_share_rounded,
                                        color: MyColor.primaryColor,
                                      ),
                                      const SizedBox(
                                        width: Dimensions.space3,
                                      ),
                                      Flexible(
                                        child: Text(
                                          MyStrings.share.tr,
                                          overflow: TextOverflow.ellipsis,
                                          style: regularDefault.copyWith(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  controller.shareImage();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width * 0.7,
                      //   child: controller.downloadLoading
                      //       ? GradientRoundedButton(
                      //           showLoadingIcon: controller.downloadLoading,
                      //           textColor: MyColor.colorWhite,
                      //           text: '',
                      //           press: () {},
                      //         )
                      //       : GradientRoundedButton(
                      //           text: MyStrings.downloadAsImage,
                      //           press: () {
                      //             controller.downloadImage();
                      //           },
                      //           textColor: MyColor.colorWhite,
                      //         ),
                      // ),
                      const SizedBox(height: Dimensions.space15)
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
