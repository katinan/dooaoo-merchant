import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/style.dart';

class CustomDropDownWithTextField extends StatefulWidget {

  final String? title, selectedValue;
  final List<String>? list;
  final ValueChanged? onChanged;
  final double borderWidth;

  const CustomDropDownWithTextField({super.key,
    this.title,
    this.selectedValue,
    this.list,
    this.borderWidth = 1.0,
    this.onChanged, });

  @override
  State<CustomDropDownWithTextField> createState() => _CustomDropDownWithTextFieldState();
}

class _CustomDropDownWithTextFieldState extends State<CustomDropDownWithTextField> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    widget.list?.removeWhere((element) => element.isEmpty);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height:45,
          decoration: BoxDecoration(
              color: MyColor.colorWhite,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: MyColor.textFieldDisableBorderColor,width: widget.borderWidth)
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left:10,
                right: 5,
                top: 5,
                bottom: 5
            ),
            child: DropdownButton(
              isExpanded: true,
              underline: Container(),
              hint: Text(
                widget.selectedValue??'',
                style: regularDefault.copyWith(color: MyColor.colorBlack),
              ), // Not necessary for Option 1
              value: widget.selectedValue,
              dropdownColor: MyColor.colorWhite,
              onChanged: widget.onChanged,
              items: widget.list!.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value.tr,
                    style: regularDefault.copyWith(color: MyColor.colorBlack),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
