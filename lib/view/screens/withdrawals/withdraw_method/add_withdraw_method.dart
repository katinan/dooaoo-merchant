import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/controller/withdraw/add_withdraw_method_controller.dart';
import 'package:viserpay_merchant/data/controller/withdraw/withdraw_money_controller.dart';
import 'package:viserpay_merchant/data/repo/withdraw/add_withdraw_method_repo.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';
import 'package:viserpay_merchant/view/components/app-bar/custom_appbar.dart';
import 'package:viserpay_merchant/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:viserpay_merchant/view/components/buttons/gradient_rounded_button.dart';
import 'package:viserpay_merchant/view/components/buttons/rounded_button.dart';
import 'package:viserpay_merchant/view/components/buttons/rounded_loading_button.dart';
import 'package:viserpay_merchant/view/components/checkbox/custom_check_box.dart';
import 'package:viserpay_merchant/view/components/custom_loader/custom_loader.dart';
import 'package:viserpay_merchant/view/components/custom_radio_button.dart';
import 'package:viserpay_merchant/view/components/form_row.dart';
import 'package:viserpay_merchant/view/components/text-form-field/custom_drop_down_text_field.dart';
import 'package:viserpay_merchant/view/components/text-form-field/custom_text_field.dart';
import 'package:viserpay_merchant/view/components/text/label_text.dart';
import 'package:viserpay_merchant/view/screens/auth/kyc/widget/widget/choose_file_list_item.dart';
import 'package:viserpay_merchant/view/screens/transaction/widget/filter_row_widget.dart';
import 'package:viserpay_merchant/view/screens/withdrawals/withdraw_method/widget/add_withdraw_method_bottom_sheet.dart';
import '../../../../../data/model/withdraw/add_withdraw_method_response_model.dart' as withdraw;

class AddWithdrawMethodScreen extends StatefulWidget {
  const AddWithdrawMethodScreen({super.key});

  @override
  State<AddWithdrawMethodScreen> createState() => _AddWithdrawMethodScreenState();
}

class _AddWithdrawMethodScreenState extends State<AddWithdrawMethodScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(AddWithdrawMethodRepo(apiClient: Get.find()));
    final controller = Get.put(AddWithdrawMethodController(addWithdrawMethodRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddWithdrawMethodController>(
      builder: (controller) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: MyColor.colorWhite),
        child: Scaffold(
          backgroundColor: MyColor.getScreenBgColor(),
          appBar: CustomAppBar(
            title: MyStrings.addWithdrawMethod.tr,
            bgColor: MyColor.getAppBarColor(),
          ),
          body: controller.isLoading
              ? const CustomLoader()
              : SingleChildScrollView(
                  padding: Dimensions.screenPaddingHV,
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColor.colorWhite,
                      borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Padding(
                        //   // padding: Dimensions.screenPaddingHV,
                        //   padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space10),
                        //   child: Text(
                        //     MyStrings.enterDetails.tr,
                        //     style: boldOverLarge.copyWith(color: MyColor.colorBlack),
                        //   ),
                        // ),
                        // Container(
                        //   margin: const EdgeInsets.only(top: 0, bottom: Dimensions.space20),
                        //   width: double.infinity,
                        //   height: 1,
                        //   color: MyColor.colorBlack.withOpacity(0.3),
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const LabelText(text: MyStrings.selectMethod),
                              const SizedBox(height: Dimensions.textToTextSpace),
                              SizedBox(
                                height: 50,
                                child: FilterRowWidget(
                                    borderColor: controller.selectedMethod?.id.toString() == "-1" ? MyColor.textFieldDisableBorderColor : MyColor.textFieldEnableBorderColor, text: "${controller.selectedMethod?.id.toString() == "-1" ? MyStrings.selectMethod : controller.selectedMethod?.name}", press: () => CustomBottomSheet(child: const AddWithdrawMethodBottomSheet()).customBottomSheet(context)),
                              ),
                              const SizedBox(height: Dimensions.space15),
                              const SizedBox(height: Dimensions.space15),
                              CustomTextField(needOutlineBorder: true, isRequired: true, controller: controller.nameController, labelText: MyStrings.provideNickName.tr, hintText: MyStrings.provideNickName.toLowerCase(), onChanged: (value) {}),
                              Visibility(
                                visible: true,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: Dimensions.space15),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount: controller.formList.length,
                                        itemBuilder: (ctx, index) {
                                          withdraw.FormModel? model = controller.formList[index];
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              model.type == 'text'
                                                  ? Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        CustomTextField(
                                                            hintText: (model.name?.tr ?? '').toString().capitalizeFirst,
                                                            needOutlineBorder: true,
                                                            labelText: model.name?.tr ?? '',
                                                            isRequired: model.isRequired == 'optional' ? false : true,
                                                            onChanged: (value) {
                                                              controller.changeSelectedValue(value, index);
                                                            }),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                      ],
                                                    )
                                                  : model.type == 'textarea'
                                                      ? Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            CustomTextField(
                                                                needOutlineBorder: true,
                                                                labelText: model.name?.tr ?? '',
                                                                isRequired: model.isRequired == 'optional' ? false : true,
                                                                hintText: (model.name?.tr ?? '').capitalizeFirst,
                                                                onChanged: (value) {
                                                                  controller.changeSelectedValue(value, index);
                                                                }),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                          ],
                                                        )
                                                      : model.type == 'select'
                                                          ? Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                FormRow(label: model.name?.tr ?? '', isRequired: model.isRequired == 'optional' ? false : true),
                                                                const SizedBox(
                                                                  height: Dimensions.textToTextSpace,
                                                                ),
                                                                CustomDropDownTextField(
                                                                  needLabel: false,
                                                                  onChanged: (value) {
                                                                    controller.changeSelectedValue(value, index);
                                                                  },
                                                                  selectedValue: model.selectedValue,
                                                                  items: model.options?.map((String val) {
                                                                    return DropdownMenuItem(
                                                                      value: val,
                                                                      child: Text(
                                                                        val,
                                                                        style: regularDefault.copyWith(color: MyColor.getLabelTextColor()),
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ],
                                                            )
                                                          : model.type == 'radio'
                                                              ? Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    FormRow(label: model.name?.tr ?? '', isRequired: model.isRequired == 'optional' ? false : true),
                                                                    CustomRadioButton(
                                                                      title: model.name,
                                                                      selectedIndex: controller.formList[index].options?.indexOf(model.selectedValue ?? '') ?? 0,
                                                                      list: model.options ?? [],
                                                                      onChanged: (selectedIndex) {
                                                                        controller.changeSelectedRadioBtnValue(index, selectedIndex);
                                                                      },
                                                                    ),
                                                                  ],
                                                                )
                                                              : model.type == 'checkbox'
                                                                  ? Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        FormRow(label: model.name?.tr ?? '', isRequired: model.isRequired == 'optional' ? false : true),
                                                                        CustomCheckBox(
                                                                          selectedValue: controller.formList[index].cbSelected,
                                                                          list: model.options ?? [],
                                                                          onChanged: (value) {
                                                                            controller.changeSelectedCheckBoxValue(index, value);
                                                                          },
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : model.type == 'file'
                                                                      ? Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            FormRow(label: model.name?.tr ?? '', isRequired: model.isRequired == 'optional' ? false : true),
                                                                            Padding(
                                                                                padding: const EdgeInsets.symmetric(vertical: Dimensions.textToTextSpace),
                                                                                child: SizedBox(
                                                                                  child: InkWell(
                                                                                      onTap: () {
                                                                                        controller.pickFile(index);
                                                                                      },
                                                                                      child: ChooseFileItem(fileName: model.selectedValue ?? MyStrings.chooseFile)),
                                                                                ))
                                                                          ],
                                                                        )
                                                                      : const SizedBox(),
                                              const SizedBox(height: Dimensions.space10),
                                            ],
                                          );
                                        })
                                  ],
                                ),
                              ),
                              const SizedBox(height: Dimensions.space25),
                              GradientRoundedButton(
                                press: () {
                                  controller.submitData();
                                },
                                text: MyStrings.addWithdrawMethod,
                                showLoadingIcon: controller.submitLoading,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
