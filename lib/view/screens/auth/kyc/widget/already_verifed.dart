import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/helper/string_format_helper.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_icons.dart';
import 'package:viserpay_merchant/core/utils/my_images.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/core/utils/url_container.dart';
import 'package:viserpay_merchant/data/controller/kyc_controller/kyc_controller.dart';
import 'package:viserpay_merchant/view/components/buttons/gradient_rounded_button.dart';
import 'package:viserpay_merchant/view/components/column_widget/card_column.dart';
import 'package:viserpay_merchant/view/components/file_download_dialog/download_dialogue.dart';

class AlreadyVerifiedWidget extends StatefulWidget {
  final bool isPending;
  const AlreadyVerifiedWidget({super.key, this.isPending = false});

  @override
  State<AlreadyVerifiedWidget> createState() => _AlreadyVerifiedWidgetState();
}

class _AlreadyVerifiedWidgetState extends State<AlreadyVerifiedWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<KycController>(builder: (controller) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(Dimensions.space20),
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColor.getScreenBgColor(isWhite: true),
        ),
        child: controller.pendingData.isNotEmpty
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Container(
                  //   padding: const EdgeInsets.all(Dimensions.space10),
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     color: MyColor.primaryColor,
                  //     borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                  //   ),
                  //   child: Center(
                  //     child: Text(
                  //       MyStrings.kycData.tr,
                  //       style: heading.copyWith(color: MyColor.colorWhite),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: Dimensions.space10),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: controller.pendingData.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(Dimensions.space8),
                          margin: const EdgeInsets.symmetric(vertical: Dimensions.space10),
                          decoration: BoxDecoration(
                            border: Border.all(color: MyColor.borderColor, width: .5),
                            borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                          ),
                          child: controller.pendingData[index].type == "file"
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.pendingData[index].name ?? '', style: heading.copyWith(fontSize: Dimensions.fontDefault)),
                                    const SizedBox(height: Dimensions.space5),
                                    GestureDetector(
                                      onTap: () {
                                        String url = "${UrlContainer.domainUrl}/${controller.path}/${controller.pendingData[index].value.toString()}";
                                        print(url);
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return DownloadingDialog(isImage: true, url: url, fileName: MyStrings.kycData);
                                          },
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.file_download,
                                            size: 17,
                                            color: MyColor.primaryColor,
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            MyStrings.attachment.tr,
                                            style: regularDefault.copyWith(color: MyColor.primaryColor),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : CardColumn(
                                  header: controller.pendingData[index].name ?? '',
                                  body: Converter.removeQuotationAndSpecialCharacterFromString(controller.pendingData[index].value ?? ''),
                                  headerTextDecoration: heading.copyWith(fontSize: Dimensions.fontDefault),
                                  bodyTextDecoration: regularDefault.copyWith(),
                                  bodyMaxLine: 40,
                                ),
                        );
                      },
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    widget.isPending ? MyIcons.pendingIcon : MyImages.verifiedIcon,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    color: MyColor.primaryColor,
                  ),
                  const SizedBox(height: 25),
                  Text(
                    widget.isPending ? MyStrings.kycUnderReviewMsg.tr : MyStrings.kycAlreadyVerifiedMsg.tr,
                    style: regularDefault.copyWith(
                      color: MyColor.colorBlack,
                      fontSize: Dimensions.fontExtraLarge,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.isPending ? MyStrings.kycPendingMsg.tr : '',
                    style: regularDefault.copyWith(
                      color: MyColor.colorGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: GradientRoundedButton(
                      press: () {
                        Get.back();
                        Get.back();
                      },
                      text: MyStrings.backToHome,
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
