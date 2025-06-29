import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';

import '../../../../../core/utils/my_images.dart';

class CustomImageWidget extends StatefulWidget {

  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;
  final int listIndex;

  const CustomImageWidget({super.key,
    required this.imagePath,
    this.listIndex = 0,
    required this.onClicked,
    this.isEdit = false
  });

  @override
  State<CustomImageWidget> createState() => _CustomImageWidgetState();
}

class _CustomImageWidgetState extends State<CustomImageWidget> {
  XFile? imageFile;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: buildImage(),
    );
  }

  Widget buildImage() {

    return Container(
      padding: EdgeInsets.zero,
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: .5,color: MyColor.primaryColor.withOpacity(.1))
      ),
      child: ClipOval(
        child: Image.asset(
          MyImages.profile,
          fit: BoxFit.cover,
          width: 90,
          height: 90,
        ),
      ),
    );
  }


  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
  }

}