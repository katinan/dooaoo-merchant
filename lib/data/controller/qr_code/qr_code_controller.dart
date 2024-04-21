import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:viserpay_merchant/core/utils/my_strings.dart';
import 'package:viserpay_merchant/data/model/global/response_model/response_model.dart';
import 'package:viserpay_merchant/data/model/qr_code/qr_code_download_response_model.dart';
import 'package:viserpay_merchant/data/model/qr_code/qr_code_response_model.dart';
import 'package:viserpay_merchant/data/repo/qr_code/qr_code_repo.dart';
import 'package:viserpay_merchant/view/components/file_download_dialog/download_dialogue.dart';
import 'package:viserpay_merchant/view/components/snack_bar/show_custom_snackbar.dart';

class QrCodeController extends GetxController {
  QrCodeRepo qrCodeRepo;
  QrCodeController({required this.qrCodeRepo});

  bool isLoading = false;
  QrCodeResponseModel model = QrCodeResponseModel();

  String qrCode = "";

  String name = "";

  Future<void> loadData() async {
    name = qrCodeRepo.apiClient.getCurrencyOrUsername(isCurrency: false);
    isLoading = true;
    update();
    print(isLoading);
    ResponseModel responseModel = await qrCodeRepo.getQrData();
    if (responseModel.statusCode == 200) {
      model = QrCodeResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status.toString().toLowerCase() == "success") {
        qrCode = model.data?.qrCode ?? "";
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.requestFail]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isLoading = false;
    update();
  }

  Future<void> shareImage() async {
    final box = Get.context!.findRenderObject() as RenderBox?;

    await Share.share(
      qrCode,
      subject: MyStrings.share.tr,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  String downloadUrl = "";
  String downloadFileName = "";
  bool downloadLoading = false;
  Future<void> downloadImage() async {
    downloadLoading = true;
    update();
    try {
      bool permission = await _checkPermission();
      if (permission) {
        ResponseModel responseModel = await qrCodeRepo.qrCodeDownLoad();
        if (responseModel.statusCode == 200) {
          QrCodeDownloadResponseModel model = QrCodeDownloadResponseModel.fromJson(jsonDecode(responseModel.responseJson));
          if (model.status.toString().toLowerCase() == "success") {
            downloadUrl = model.data?.downloadLink ?? "";
            downloadFileName = model.data?.downloadFileName ?? "";
            if (downloadUrl.isNotEmpty && downloadUrl != 'null') {
              showDialog(
                context: Get.context!,
                builder: (context) => DownloadingDialog(
                  isImage: true,
                  isPdf: false,
                  url: downloadUrl,
                  fileName: downloadFileName,
                ),
              );
            }
          }
        } else {
          CustomSnackBar.error(errorList: [responseModel.message]);
        }
      } else {
        update();
        CustomSnackBar.error(errorList: [MyStrings.pleaseGivemePermission]);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      downloadLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    _checkPermission();
    super.onInit();
  }

  // TargetPlatform? platform;

  Future<bool> _checkPermission() async {
    var platform = Platform.isAndroid;
    var platform2 = Platform.isIOS;

    if (platform == true || platform2 == true) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        return result == PermissionStatus.granted;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
}
