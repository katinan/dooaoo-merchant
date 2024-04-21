import 'dart:convert';

import 'package:viserpay_merchant/core/utils/method.dart';
import 'package:viserpay_merchant/core/utils/url_container.dart';
import 'package:viserpay_merchant/data/model/authorization/authorization_response_model.dart';
import 'package:viserpay_merchant/data/model/global/response_model/response_model.dart';
import 'package:viserpay_merchant/data/repo/kyc/kyc_repo.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';
import 'package:http/http.dart' as http;

import '../../model/withdraw/edit_withdraw_method_response_model.dart';

class EditWithdrawMethodRepo {
  ApiClient apiClient;
  EditWithdrawMethodRepo({required this.apiClient});

  Future<ResponseModel> getData(String id) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.withdrawMethodEdit}$id";
    print(url);

    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    print(responseModel.responseJson);

    return responseModel;
  }

  List<Map<String, String>> fieldList = [];
  List<ModelDynamicValue> filesList = [];

  Future<AuthorizationResponseModel> submitData(String id, String methodId, String name, String status, List<FormModel> list) async {
    print(id);
    print(methodId);

    apiClient.initToken();
    await modelToMap(list);
    String url = '${UrlContainer.baseUrl}${UrlContainer.withdrawMethodUpdate}';

    var request = http.MultipartRequest('POST', Uri.parse(url));

    Map<String, String> finalMap = {};

    for (var element in fieldList) {
      finalMap.addAll(element);
    }

    request.headers.addAll(<String, String>{'Authorization': 'Bearer ${apiClient.token}'});

    request.fields.addAll({'id': id, 'method_id': methodId, 'name': name, 'status': status});

    for (var file in filesList) {
      request.files.add(http.MultipartFile(file.key ?? '', file.value.readAsBytes().asStream(), file.value.lengthSync(), filename: file.value.path.split('/').last));
    }

    request.fields.addAll(finalMap);

    http.StreamedResponse response = await request.send();

    String jsonResponse = await response.stream.bytesToString();
    AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(jsonResponse));

    return model;
  }

  Future<dynamic> modelToMap(List<FormModel> list) async {
    for (var e in list) {
      if (e.type == 'checkbox') {
        if (e.cbSelected != null && e.cbSelected!.isNotEmpty) {
          for (int i = 0; i < e.cbSelected!.length; i++) {
            fieldList.add({'${e.label}[$i]': e.cbSelected![i]});
          }
        }
      } else if (e.type == 'file') {
        if (e.imageFile != null) {
          filesList.add(ModelDynamicValue(e.label, e.imageFile!));
        }
      } else {
        if (e.selectedValue != null && e.selectedValue.toString().isNotEmpty) {
          fieldList.add({e.label ?? '': e.selectedValue});
        }
      }
    }
  }
}
