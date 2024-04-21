import 'package:viserpay_merchant/core/utils/method.dart';
import 'package:viserpay_merchant/core/utils/url_container.dart';
import 'package:viserpay_merchant/data/model/global/response_model/response_model.dart';
import 'package:viserpay_merchant/data/services/api_service.dart';

class TransactionRepo {
  ApiClient apiClient;
  TransactionRepo({required this.apiClient});

  Future<ResponseModel> getTransactionData(int page, {String searchText = "", String transactionType = "", String operationType = "", String historyFrom = "", String walletCurrency = ""}) async {
    if (transactionType.isEmpty || transactionType.toLowerCase() == "all type") {
      transactionType = "";
    } else {
      transactionType = transactionType == 'plus'
          ? 'plus'
          : transactionType == 'minus'
              ? 'minus'
              : '';
    }

    if (operationType.isEmpty || operationType.toLowerCase() == "all operations") {
      operationType = "";
    }

    if (historyFrom.isEmpty || historyFrom.toLowerCase() == "all time") {
      historyFrom = "";
    }

    if (walletCurrency.isEmpty || walletCurrency.toLowerCase() == "all currency") {
      walletCurrency = "";
    }

    String url = "${UrlContainer.baseUrl}${UrlContainer.transactionEndpoint}?page=$page&type=$transactionType&remark=$operationType&time=${getOnlynumber(historyFrom)}&search=$searchText";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }
}

String getOnlynumber(String time) {
  if (time.contains("days")) {
    return time.split("days")[0];
  } else if (time.contains("month")) {
    return (int.parse(time.split("month")[0]) * 30).toString();
  } else if (time.contains("year")) {
    return (365).toString();
  }
  return "All Time";
}
