import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/route/route.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_images.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/controller/account/profile_controller.dart';
import 'package:viserpay_merchant/view/components/circle_button_with_icon.dart';
import 'package:viserpay_merchant/view/components/column_widget/card_column.dart';
import 'package:viserpay_merchant/view/components/divider/custom_divider.dart';
import 'package:viserpay_merchant/view/components/image/circle_shape_image.dart';

class ProfileTopSection extends StatefulWidget {
  const ProfileTopSection({super.key});

  @override
  State<ProfileTopSection> createState() => _ProfileTopSectionState();
}

class _ProfileTopSectionState extends State<ProfileTopSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
        decoration: BoxDecoration(color: MyColor.getCardBgColor(), borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleButtonWithIcon(
                  circleSize: 50,
                  imageSize: 40,
                  padding: 0,
                  borderColor: Colors.transparent,
                  isIcon: false,
                  isAsset: false,
                  imagePath: controller.imageUrl,
                  isProfile: true,
                  press: () {},
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(RouteHelper.editProfileScreen),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: MyColor.getPrimaryColor(), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.edit, color: MyColor.colorWhite, size: 20),
                        const SizedBox(width: Dimensions.space10),
                        Text(
                          MyStrings.editProfile,
                          style: regularSmall.copyWith(color: MyColor.colorWhite),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: Dimensions.space25),
            Row(
              children: [const CircleShapeImage(imageColor: MyColor.primaryColor, image: MyImages.name), const SizedBox(width: Dimensions.space15), CardColumn(header: MyStrings.username, body: controller.model.data?.user?.username ?? "")],
            ),
            const CustomDivider(space: Dimensions.space15),
            Row(
              children: [const CircleShapeImage(imageColor: MyColor.primaryColor, image: MyImages.name), const SizedBox(width: Dimensions.space15), CardColumn(header: MyStrings.firstName, body: controller.model.data?.user?.firstname ?? "")],
            ),
            const CustomDivider(space: Dimensions.space15),
            Row(
              children: [const CircleShapeImage(imageColor: MyColor.primaryColor, image: MyImages.name), const SizedBox(width: Dimensions.space15), CardColumn(header: MyStrings.lastName, body: controller.model.data?.user?.lastname ?? "")],
            ),
            const CustomDivider(space: Dimensions.space15),
            Row(
              children: [const CircleShapeImage(imageColor: MyColor.primaryColor, image: MyImages.email), const SizedBox(width: Dimensions.space15), CardColumn(header: MyStrings.email, body: controller.model.data?.user?.email ?? "")],
            ),
            const CustomDivider(space: Dimensions.space15),
            Row(
              children: [const CircleShapeImage(imageColor: MyColor.primaryColor, image: MyImages.phone), const SizedBox(width: Dimensions.space15), CardColumn(header: MyStrings.phone, body: controller.model.data?.user?.mobile ?? "")],
            ),
            const CustomDivider(space: Dimensions.space15),
            Row(
              children: [const CircleShapeImage(imageColor: MyColor.primaryColor, image: MyImages.address), const SizedBox(width: Dimensions.space15), CardColumn(header: MyStrings.address, body: controller.model.data?.user?.address?.address ?? "")],
            ),
            const CustomDivider(space: Dimensions.space15),
            Row(
              children: [const CircleShapeImage(imageColor: MyColor.primaryColor, image: MyImages.state), const SizedBox(width: Dimensions.space15), CardColumn(header: MyStrings.state, body: controller.model.data?.user?.address?.state ?? "")],
            ),
            const CustomDivider(space: Dimensions.space15),
            Row(
              children: [const CircleShapeImage(imageColor: MyColor.primaryColor, image: MyImages.zipCode), const SizedBox(width: Dimensions.space15), CardColumn(header: MyStrings.zipCode, body: controller.model.data?.user?.address?.zip ?? "")],
            ),
            const CustomDivider(space: Dimensions.space15),
            Row(
              children: [const CircleShapeImage(imageColor: MyColor.primaryColor, image: MyImages.city), const SizedBox(width: Dimensions.space15), CardColumn(header: MyStrings.city, body: controller.model.data?.user?.address?.city ?? "")],
            ),
            const CustomDivider(space: Dimensions.space15),
            Row(
              children: [const CircleShapeImage(imageColor: MyColor.primaryColor, image: MyImages.country), const SizedBox(width: Dimensions.space15), CardColumn(header: MyStrings.country, body: controller.model.data?.user?.address?.country ?? "")],
            ),
          ],
        ),
      ),
    );
  }
}
