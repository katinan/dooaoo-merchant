import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:viserpay_merchant/core/utils/my_color.dart';
import 'package:viserpay_merchant/data/model/language/language_model.dart';
import 'package:viserpay_merchant/data/model/language/main_language_response_model.dart';
import 'package:viserpay_merchant/view/screens/bottom_nav_section/menu/widget/language_dialog_body.dart';

void showLanguageDialog(String languageList, Locale selectedLocal, BuildContext context, {bool fromSplash = false}) {
  var language = jsonDecode(languageList);
  MainLanguageResponseModel model = MainLanguageResponseModel.fromJson(language);

  List<MyLanguageModel> langList = [];

  if (model.data?.languages != null && model.data!.languages!.isNotEmpty) {
    for (var listItem in model.data!.languages!) {
      MyLanguageModel model = MyLanguageModel(languageCode: listItem.code ?? '', countryCode: listItem.name ?? '', languageName: listItem.name ?? '', imageUrl: '');
      langList.add(model);
    }
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: MyColor.getScreenBgColor(),
          content: LanguageDialogBody(langList: langList, fromSplashScreen: fromSplash),
        );
      });
}
