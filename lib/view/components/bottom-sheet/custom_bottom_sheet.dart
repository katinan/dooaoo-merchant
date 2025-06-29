import 'package:flutter/material.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';

class CustomBottomSheet {
  final Widget child;
  bool isNeedMargin;
  final VoidCallback? voidCallback;
  CustomBottomSheet({required this.child, this.isNeedMargin = false, this.voidCallback});

  void customBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: MyColor.transparentColor,
        context: context,
        builder: (BuildContext context) => SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: AnimatedPadding(
                padding: MediaQuery.of(context).viewInsets,
                duration: const Duration(milliseconds: 50),
                curve: Curves.decelerate,
                child: Container(
                  margin: isNeedMargin ? const EdgeInsets.only(left: 15, right: 15, bottom: 15) : const EdgeInsets.only(top: 0),
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space12),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white, //const Color(0xFFF7F8FC),
                      borderRadius: isNeedMargin ? BorderRadius.circular(15) : const BorderRadius.vertical(top: Radius.circular(15))),
                  child: child,
                ),
              ),
            )).then((value) => voidCallback);
  }
}
