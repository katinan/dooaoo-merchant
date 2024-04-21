import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:viserpay_merchant/core/helper/shared_preference_helper.dart';
import 'package:viserpay_merchant/core/utils/method.dart';
import 'package:viserpay_merchant/core/utils/url_container.dart';
import 'package:viserpay_merchant/data/model/auth/sign_up_model/registration_response_model.dart';
import 'package:viserpay_merchant/data/model/auth/sign_up_model/sign_up_model.dart';
import 'package:viserpay_merchant/data/model/global/response_model/response_model.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';

class RegistrationRepo {
  ApiClient apiClient;

  RegistrationRepo({required this.apiClient});

  Future<RegistrationResponseModel> registerUser(SignUpModel model) async {
    final map = modelToMap(model);

    String url = '${UrlContainer.baseUrl}${UrlContainer.registrationEndPoint}';

    final res = await apiClient.request(url, Method.postMethod, map, passHeader: true, isOnlyAcceptType: true);

    final json = jsonDecode(res.responseJson);

    RegistrationResponseModel responseModel = RegistrationResponseModel.fromJson(json);

    return responseModel;
  }

  Map<String, dynamic> modelToMap(SignUpModel model) {
    Map<String, dynamic> bodyFields = {
      'mobile': model.mobile,
      'email': model.email,
      'agree': model.agree.toString(),
      'username': model.username,
      'password': model.password,
      'password_confirmation': model.password, //password and confirm password check from front end panel
      'country_code': model.countryCode, //model.country_code,
      'country': model.country, //model.country,
      "mobile_code": model.mobileCode
    };

    return bodyFields;
  }

  Future<dynamic> getCountryList() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.countryEndPoint}';
    ResponseModel model = await apiClient.request(url, Method.getMethod, null);
    return model;
  }

}
