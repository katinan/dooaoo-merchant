import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/route/route.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool isShowBackBtn;
  final VoidCallback? backButtonOnPress;
  final Color bgColor;
  final bool isTitleCenter;
  final bool fromAuth;
  final bool isProfileCompleted;
  final dynamic actionIcon;
  final List<Widget>? action;
  final VoidCallback? actionPress;
  final bool isActionIconAlignEnd;
  final String actionText;
  final bool isActionImage;
  TextStyle? titleStyle;
  Color? iconColor;
  final bool isForceBackHome;
  double? elevation;
  bool shadowEnabled = false;
  CustomAppBar({
    super.key,
    this.isProfileCompleted = false,
    this.fromAuth = false,
    this.isTitleCenter = false,
    this.bgColor = MyColor.colorWhite,
    this.isShowBackBtn = true,
    required this.title,
    this.actionText = '',
    this.actionIcon,
    this.backButtonOnPress,
    this.actionPress,
    this.isActionIconAlignEnd = false,
    this.isActionImage = true,
    this.action,
    this.titleStyle,
    this.isForceBackHome = false,
    this.iconColor = MyColor.colorBlack,
    this.elevation = 0.0,
    this.shadowEnabled = true,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool hasNotification = false;
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isShowBackBtn
        ? PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 100),
            // preferredSize: const Size.fromHeight(100),
            child: Container(
              // padding: const EdgeInsetsDirectional.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: MyColor.colorWhite,
                boxShadow: widget.shadowEnabled
                    ? [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          offset: const Offset(0, 2.0),
                          blurRadius: 4.0,
                        )
                      ]
                    : [],
              ),
              child: AppBar(
                elevation: 0,
                scrolledUnderElevation: 0,
                titleSpacing: 0,
                leading: widget.isShowBackBtn
                    ? IconButton(
                        onPressed: () {
                          if (widget.backButtonOnPress == null) {
                            if (widget.fromAuth) {
                              Get.offAllNamed(RouteHelper.loginScreen);
                            } else {
                              String previousRoute = Get.previousRoute;
                              if (previousRoute == '/splash-screen' || widget.isForceBackHome == true) {
                                // Get.offAndToNamed(RouteHelper.homeScreen);
                              } else {
                                Navigator.of(context).maybePop();
                              }
                            }
                          } else {
                            widget.backButtonOnPress!();
                          }
                        },
                        icon: Icon(Icons.arrow_back_ios_new_outlined, color: widget.iconColor, size: 20),
                      )
                    : const SizedBox.shrink(),
                backgroundColor: widget.bgColor,
                title: Text(
                  widget.title.tr,
                  style: widget.titleStyle ?? regularDefault.copyWith(color: MyColor.getTextColor()),
                ),
                centerTitle: widget.isTitleCenter,
                actions: widget.action,
              ),
            ),
          )
        : PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 100),
            child: Container(
              decoration: BoxDecoration(
                color: MyColor.colorWhite,
                boxShadow: widget.shadowEnabled
                    ? [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          offset: const Offset(0, 2.0),
                          blurRadius: 4.0,
                        )
                      ]
                    : [],
              ),
              child: AppBar(
                titleSpacing: 0,
                scrolledUnderElevation: 0,
                shadowColor: MyColor.appBarColor,
                elevation: widget.elevation,
                backgroundColor: widget.bgColor,
                centerTitle: widget.isTitleCenter,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    widget.title.tr,
                    style: widget.titleStyle ??
                        regularDefault.copyWith(
                          color: MyColor.getTextColor(),
                        ),
                  ),
                ),
                actions: widget.action,
                automaticallyImplyLeading: false,
              ),
            ),
          );
  }
}
