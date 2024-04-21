import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';

class AppDialog {
  accountRemoveDialog(
    BuildContext context, {
    required Function onPressYes,
  }) {
    return showDialog(
        context: context,
        useSafeArea: true,
        barrierDismissible: false,
        builder: (_) {
          return Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: MyColor.transparentColor,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  padding: const EdgeInsetsDirectional.only(start: Dimensions.space15, end: Dimensions.space15, top: Dimensions.space30, bottom: Dimensions.space20),
                  margin: const EdgeInsets.all(Dimensions.space20),
                  decoration: BoxDecoration(
                    color: MyColor.colorWhite,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: MyColor.borderColor,
                      width: 0.6,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimensions.space10),
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
                      const SizedBox(
                        height: Dimensions.space20,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: MyColor.borderColor,
                                  width: 0.5,
                                ),
                              ),
                              child: Text(
                                MyStrings.no.tr,
                                style: regularDefault.copyWith(color: MyColor.colorBlack, fontWeight: FontWeight.w600, fontSize: 18),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: Dimensions.space25,
                          ),
                          ElevatedButton(
                            onPressed: () => onPressYes(),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(100, 40),
                              backgroundColor: MyColor.colorRed,
                            ),
                            child: Text(
                              MyStrings.yes.tr,
                              style: regularDefault.copyWith(color: MyColor.colorWhite),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.space5,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          MyStrings.afterdelectyoucanback.tr,
                          style: mediumSmall.copyWith(color: MyColor.colorGrey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 30,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      color: MyColor.colorRed,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
