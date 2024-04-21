import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/dimensions.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/style.dart';
import 'package:viserpay_merchant/data/controller/withdraw/edit_withdraw_method_controller.dart';
import 'package:viserpay_merchant/data/repo/withdraw/edit_withdraw_method_repo.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';
import 'package:viserpay_merchant/view/components/app-bar/custom_appbar.dart';
import 'package:viserpay_merchant/view/components/buttons/gradient_rounded_button.dart';
import 'package:viserpay_merchant/view/components/buttons/rounded_button.dart';
import 'package:viserpay_merchant/view/components/buttons/rounded_loading_button.dart';
import 'package:viserpay_merchant/view/components/checkbox/custom_check_box.dart';
import 'package:viserpay_merchant/view/components/custom_loader/custom_loader.dart';
import 'package:viserpay_merchant/view/components/custom_radio_button.dart';
import 'package:viserpay_merchant/view/components/form_row.dart';
import 'package:viserpay_merchant/view/components/text-form-field/custom_drop_down_text_field.dart';
import 'package:viserpay_merchant/view/components/text-form-field/custom_text_field.dart';
import 'package:viserpay_merchant/view/screens/auth/kyc/widget/widget/choose_file_list_item.dart';
import '../../../../../data/model/withdraw/edit_withdraw_method_response_model.dart' as withdraw;

class EditWithdrawMethod extends StatefulWidget {
  const EditWithdrawMethod({super.key});

  @override
  State<EditWithdrawMethod> createState() => _EditWithdrawMethodState();
}

class _EditWithdrawMethodState extends State<EditWithdrawMethod> {
  @override
  void initState() {
    final String id = Get.arguments;

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(EditWithdrawMethodRepo(apiClient: Get.find()));
    final controller = Get.put(EditWithdrawMethodController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditWithdrawMethodController>(
      builder: (controller) => Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar: CustomAppBar(
          title: MyStrings.withdrawMethodEdit,
          bgColor: MyColor.getAppBarColor(),
        ),
        body: controller.isLoading
            ? const CustomLoader()
            : SingleChildScrollView(
                padding: Dimensions.screenPaddingHV,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(isRequired: true, needOutlineBorder: true, controller: controller.nameController, labelText: MyStrings.provideNickName.tr, hintText: MyStrings.provideNickName.toLowerCase(), onChanged: (value) {}),
                    const SizedBox(height: Dimensions.space15),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: controller.formList.length,
                        itemBuilder: (ctx, index) {
                          withdraw.FormModel model = controller.formList[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              model.type == 'text'
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomTextField(
                                          controller: TextEditingController(text: model.selectedValue)..selection,
                                          needOutlineBorder: true,
                                          labelText: model.name?.tr ?? '',
                                          onChanged: (value) {
                                            controller.changeSelectedValue(value, index);
                                          },
                                        ),
                                        const SizedBox(height: Dimensions.space15),
                                      ],
                                    )
                                  : model.type == 'textarea'
                                      ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomTextField(
                                                controller: TextEditingController(text: model.selectedValue),
                                                needOutlineBorder: true,
                                                labelText: model.name?.tr ?? '',
                                                onChanged: (value) {
                                                  controller.changeSelectedValue(value, index);
                                                }),
                                            const SizedBox(height: Dimensions.space15),
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
                                                    }).toList()),
                                                const SizedBox(height: Dimensions.space15)
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
                                                        }),
                                                    const SizedBox(height: Dimensions.space15)
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
                                                            }),
                                                        const SizedBox(height: Dimensions.space15)
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
                                                                )),
                                                          ],
                                                        )
                                                      : const SizedBox(),
                            ],
                          );
                        }),
                    const SizedBox(height: Dimensions.space15),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.space12, horizontal: Dimensions.space15),
                      decoration: BoxDecoration(color: MyColor.getCardBgColor(), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            MyStrings.status.tr,
                            style: regularDefault.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w600),
                          ),
                          Switch(value: controller.status == '1', onChanged: (value) => controller.changeStatus())
                        ],
                      ),
                    ),
                    const SizedBox(height: Dimensions.space25),
                    GradientRoundedButton(
                        showLoadingIcon: controller.submitLoading,
                        press: () {
                          controller.submitData();
                        },
                        text: MyStrings.updateMethod),
                  ],
                ),
              ),
      ),
    );
  }
}
