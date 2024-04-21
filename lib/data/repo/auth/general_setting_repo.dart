import 'dart:convert';

import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/method.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/core/utils/url_container.dart';
import 'package:viserpay_merchant/data/model/general_setting/module_settings_response_model.dart';
import 'package:viserpay_merchant/data/model/global/response_model/response_model.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';


class GeneralSettingRepo {

  ApiClient apiClient;
  GeneralSettingRepo({required this.apiClient});

  Future<dynamic> getGeneralSetting() async {

    try{
      String url='${UrlContainer.baseUrl}${UrlContainer.generalSettingEndPoint}';
      ResponseModel response= await apiClient.request(url,Method.getMethod, null,passHeader: false);
      return response;
    }catch(e){
      return ResponseModel(false, MyStrings.somethingWentWrong.tr, 300, '');
    }
  }

  Future<dynamic> getLanguage(String languageCode) async {
    try{
      String url='${UrlContainer.baseUrl}${UrlContainer.languageUrl}$languageCode';
      ResponseModel response= await apiClient.request(url,Method.getMethod, null,passHeader: false);
      return response;

    }catch(e){
      return ResponseModel(false, MyStrings.somethingWentWrong, 300, '');
    }

  }

  Future<dynamic> loadAndStoreModuleSetting() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.moduleSettingEndPoint}';
    ResponseModel response = await apiClient.request(url, Method.getMethod, null, passHeader: false);

    if (response.statusCode == 200) {
      ModuleSettingsResponseModel model = ModuleSettingsResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        apiClient.storeModuleSetting(model);
      }
    }
  }
}
