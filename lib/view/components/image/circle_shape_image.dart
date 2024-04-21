import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';

class CircleShapeImage extends StatefulWidget {
  final String image;
  final Color backgroundColor, imageColor;
  final double size;
  final bool isSvgImage;
  const CircleShapeImage({
    super.key,
    this.backgroundColor = MyColor.screenBgColor,
    this.imageColor = MyColor.primaryColor,
    this.size = 35,
    required this.image,
    this.isSvgImage = false
  });

  @override
  State<CircleShapeImage> createState() => _CircleShapeImageState();
}

class _CircleShapeImageState extends State<CircleShapeImage> {
  @override
  Widget build(BuildContext context) {
    return widget.isSvgImage ? Container(
      height: widget.size, width: widget.size,
      padding: const EdgeInsets.all(Dimensions.space10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        shape: BoxShape.circle
      ),
      child: SvgPicture.asset(widget.image, color: widget.imageColor, height: widget.size / 2, width: widget.size / 2),
    ) : Container(
      height: widget.size, width: widget.size,
      padding: const EdgeInsets.all(Dimensions.space10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          shape: BoxShape.circle
      ),
      child: Image.asset(widget.image, color: widget.imageColor, height: widget.size / 2, width: widget.size / 2),
    );
  }
}
