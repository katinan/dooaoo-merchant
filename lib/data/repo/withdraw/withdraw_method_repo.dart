import 'package:viserpay_merchant/core/utils/method.dart';
import 'package:viserpay_merchant/core/utils/url_container.dart';
import 'package:viserpay_merchant/data/model/global/response_model/response_model.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';

class WithdrawMethodRepo {
  ApiClient apiClient;
  WithdrawMethodRepo({required this.apiClient});

  Future<ResponseModel> getMethodData(int page) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.withdrawMethodUrl}";

    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getData(int page) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.addWithdrawMethodUrl}?page=$page";

    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }
}
