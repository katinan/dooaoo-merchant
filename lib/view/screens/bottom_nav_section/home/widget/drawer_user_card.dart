import 'package:flutter/material.dart';
import 'package:viserpay_merchant/core/helper/string_format_helper.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_icons.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/view/components/image/custom_svg_picture.dart';
import 'package:viserpay_merchant/view/components/image/my_image_widget.dart';

class DrawerUserCard extends StatelessWidget {
  String? username, fullname, subtitle;
  String? image;
  bool isAsset;
  bool noAvatar;
  TextStyle? titleStyle, subtitleStyle;
  Widget? rightWidget;
  Widget? imgWidget;
  double? imgHeight;
  double? imgwidth;
  DrawerUserCard({
    super.key,
    this.username,
    this.fullname,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.image = MyIcons.user,
    this.isAsset = true,
    this.noAvatar = false,
    this.rightWidget,
    this.imgHeight,
    this.imgwidth,
    this.imgWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                imgWidget == null
                    ? !noAvatar
                        ? Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: MyColor.primaryColor.withOpacity(0.4),
                            ),
                            child: const CustomSvgPicture(image: MyIcons.user),
                          )
                        : MyImageWidget(
                            imageUrl: image.toString(),
                            height: imgHeight ?? 40,
                          )
                    : imgWidget!,
                const SizedBox(
                  width: Dimensions.space15,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          "$fullname".toCapitalized(),
                          style: titleStyle ??
                              regularDefault.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: Dimensions.fontLarge + 3,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: Dimensions.space3,
                      ),
                      Text(
                        "@$username",
                        style: titleStyle ??
                            regularDefault.copyWith(
                              fontSize: Dimensions.fontSmall,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: Dimensions.space5,
                      ),
                      subtitle != null
                          ? Text(
                              subtitle ?? "",
                              style: subtitleStyle ??
                                  regularDefault.copyWith(
                                    fontSize: Dimensions.fontSmall,
                                    color: MyColor.colorGrey.withOpacity(0.8),
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          rightWidget ?? const SizedBox.shrink()
        ],
      ),
    );
  }
}
