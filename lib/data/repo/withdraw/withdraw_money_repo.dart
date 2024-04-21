import 'package:viserpay_merchant/core/utils/method.dart';
import 'package:viserpay_merchant/core/utils/url_container.dart';
import 'package:viserpay_merchant/data/model/global/response_model/response_model.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';

class WithdrawMoneyRepo {
  ApiClient apiClient;
  WithdrawMoneyRepo({required this.apiClient});

  Future<ResponseModel> getData(int page) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.addWithdrawMethodUrl}?page=$page";

    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> submitWithdrawMoney({required String methodId, required String userMethodId, required String amount}) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.submitWithdrawMoneyUrl}";
    Map<String, String> params = {"method_id": methodId, "user_method_id": userMethodId, "amount": amount};

    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, params, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getPreviewData({required String trx}) async {
    print(trx);

    String url = "${UrlContainer.baseUrl}${UrlContainer.withdrawPreviewUrl}/$trx";
    print(url);

    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> submitData({required String otpType, required String trx}) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.withdrawMoneySubmitUrl}";
    Map<String, String> params = {"otp_type": otpType, "trx": trx};

    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, params, passHeader: true);
    return responseModel;
  }
}
