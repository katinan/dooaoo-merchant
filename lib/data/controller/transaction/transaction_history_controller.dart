import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/data/model/global/response_model/response_model.dart';
import 'package:viserpay_merchant/data/model/transctions/transaction_response_model.dart';
import 'package:viserpay_merchant/data/repo/transaction/transaction_repo.dart';
import 'package:viserpay_merchant/view/components/snack_bar/show_custom_snackbar.dart';

class TransactionHistoryController extends GetxController {
  TransactionRepo transactionRepo;
  TransactionHistoryController({required this.transactionRepo});

  bool isLoading = true;

  List<String> transactionTypeList = [MyStrings.allType, MyStrings.plus, MyStrings.minus];
  List<String> operationTypeList = [];
  List<String> historyFormList = [];
  List<String> walletCurrencyList = [];

  List<TransactionsData> transactionList = [];

  String trxSearchText = "";
  String? nextPageUrl;
  int page = 0;
  String currency = "";
  String currencySym = "";

  TextEditingController trxController = TextEditingController();

  String selectedTransactionType = MyStrings.allType;
  String selectedOperationType = "";
  String selectedHistoryFrom = "";
  String selectedWalletCurrency = "";

  setSelectedTransactionType(String? trxType) {
    selectedTransactionType = trxType ?? "";
    update();
  }

  setSelectedOperationType(String? operationType) {
    selectedOperationType = operationType ?? "";
    update();
  }

  setSelectedHistoryFrom(String? historyFrom) {
    selectedHistoryFrom = historyFrom ?? "";
    update();
  }

  setSelectedWalletCurrency(String? walletCurrency) {
    selectedWalletCurrency = walletCurrency ?? "";
    update();
  }

  void loadDefaultData(String trxType) {
    if (trxType.isNotEmpty) {
      selectedTransactionType = trxType;
      isSearch = true;
    } else {
      selectedTransactionType = MyStrings.allType;
    }

    initialSelectedValue();
  }

  void initialSelectedValue() async {
    page = 0;
    currency = transactionRepo.apiClient.getCurrencyOrUsername(isCurrency: true);
    currencySym = transactionRepo.apiClient.getCurrencyOrUsername(isSymbol: true);
    selectedOperationType = "";
    selectedHistoryFrom = "";
    selectedWalletCurrency = "";

    trxController.text = "";
    trxSearchText = "";
    transactionList.clear();
    isLoading = true;
    update();
    await loadTransactionData();
    isLoading = false;
    update();
  }

  Future<void> loadTransactionData() async {
    page = page + 1;

    if (page == 1) {
      historyFormList.clear();
      walletCurrencyList.clear();
      transactionList.clear();

      operationTypeList.clear();
      operationTypeList.insert(0, MyStrings.allOpartion);
      historyFormList.insert(0, MyStrings.allTime);
    }

    ResponseModel responseModel = await transactionRepo.getTransactionData(page, searchText: trxSearchText, transactionType: selectedTransactionType.toLowerCase(), operationType: selectedOperationType.toLowerCase(), historyFrom: selectedHistoryFrom.toLowerCase(), walletCurrency: selectedWalletCurrency.toLowerCase());

    if (responseModel.statusCode == 200) {
      TransactionResponseModel model = TransactionResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      nextPageUrl = model.data?.transactions?.nextPageUrl;

      if (model.status.toString().toLowerCase() == "success") {
        List<TransactionsData>? tempDataList = model.data?.transactions?.data;
        if (tempDataList != null && tempDataList.isNotEmpty) {
          transactionList.addAll(tempDataList);
        }

        List<String>? tempOperationList = model.data?.operations;
        if (tempOperationList != null || tempOperationList!.isNotEmpty) {
          operationTypeList.clear();
          operationTypeList.insert(0, MyStrings.allOpartion);
          operationTypeList.addAll(tempOperationList);
        }
        if (tempOperationList.isNotEmpty) {
          selectedOperationType = operationTypeList[0];
          setSelectedOperationType(selectedOperationType);
        }

        List<String>? tempHistoryFromList = model.data?.times;
        if (tempHistoryFromList != null || tempHistoryFromList!.isNotEmpty) {
          historyFormList.addAll(tempHistoryFromList);
        }
        if (tempHistoryFromList.isNotEmpty) {
          selectedHistoryFrom = historyFormList[0];
          setSelectedHistoryFrom(selectedHistoryFrom);
        }

        List<String>? tempWalletCurrencyList = model.data?.currencies;
        if (tempWalletCurrencyList != null || tempWalletCurrencyList!.isNotEmpty) {
          walletCurrencyList.addAll(tempWalletCurrencyList);
        }
        if (tempWalletCurrencyList.isNotEmpty) {
          selectedWalletCurrency = walletCurrencyList[0];
          setSelectedWalletCurrency(selectedWalletCurrency);
        }
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    update();
  }

  Future<void> loadFilteredTransactions() async {
    page = page + 1;

    if (page == 1) {
      transactionList.clear();
    }

    ResponseModel responseModel = await transactionRepo.getTransactionData(page, searchText: trxSearchText, transactionType: selectedTransactionType.toLowerCase(), operationType: selectedOperationType.toLowerCase(), historyFrom: selectedHistoryFrom.toLowerCase(), walletCurrency: selectedWalletCurrency.toLowerCase());

    if (responseModel.statusCode == 200) {
      TransactionResponseModel model = TransactionResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      nextPageUrl = model.data?.transactions?.nextPageUrl;

      if (model.status.toString().toLowerCase() == "success") {
        List<TransactionsData>? tempDataList = model.data?.transactions?.data;
        if (tempDataList != null && tempDataList.isNotEmpty) {
          transactionList.addAll(tempDataList);
        }
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    update();
  }

  bool filterLoading = false;

  Future<void> filterData() async {
    trxSearchText = trxController.text;
    page = 0;
    filterLoading = true;
    update();
    transactionList.clear();
    await loadFilteredTransactions();
    filterLoading = false;
    update();
  }

  bool hasNext() {
    return nextPageUrl != null && nextPageUrl!.isNotEmpty && nextPageUrl != 'null' ? true : false;
  }

  bool isSearch = false;
  void changeSearchIcon() {
    isSearch = !isSearch;
    update();

    if (!isSearch) {
      selectedTransactionType = MyStrings.allType;
      initialSelectedValue();
    }
  }
}
