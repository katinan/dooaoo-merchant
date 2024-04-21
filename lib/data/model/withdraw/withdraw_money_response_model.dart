
import 'dart:convert';

import 'package:viserpay_merchant/data/model/auth/sign_up_model/registration_response_model.dart';

WithdrawMoneyResponseModel withdrawMoneyResponseModelFromJson(String str) => WithdrawMoneyResponseModel.fromJson(json.decode(str));

String withdrawMoneyResponseModelToJson(WithdrawMoneyResponseModel data) => json.encode(data.toJson());

class WithdrawMoneyResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  WithdrawMoneyResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory WithdrawMoneyResponseModel.fromJson(Map<String, dynamic> json) => WithdrawMoneyResponseModel(
        remark: json["remark"],
        status: json["status"],
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "remark": remark,
        "status": status,
        "message": message?.toJson(),
      };
}

class Data {
  Methods? methods;

  Data({
    this.methods,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        methods: json["methods"] == null ? null : Methods.fromJson(json["methods"]),
      );
}

class Methods {
  List<Method>? data;
  dynamic nextPageUrl;

  Methods({
    this.data,
    this.nextPageUrl,
  });

  factory Methods.fromJson(Map<String, dynamic> json) => Methods(
        data: json["data"] == null ? [] : List<Method>.from(json["data"]!.map((x) => Method.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );
}

class Method {
  int? id;
  String? name;
  String? userId;
  String? userType;
  String? methodId;
  List<dynamic>? userData;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? minLimit;
  String? maxLimit;
  WithdrawMethod? withdrawMethod;

  Method({
    this.id,
    this.name,
    this.userId,
    this.userType,
    this.methodId,
    this.userData,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.minLimit,
    this.maxLimit,
    this.withdrawMethod,
  });

  factory Method.fromJson(Map<String, dynamic> json) => Method(
        id: json["id"],
        name: json["name"],
        userId: json["user_id"].toString(),
        userType: json["user_type"].toString(),
        methodId: json["method_id"].toString(),
        userData: json["user_data"] == null ? [] : List<dynamic>.from(json["user_data"]!.map((x) => x)),
        status: json["status"].toString(),
        createdAt: json["created_at"] ,
        updatedAt: json["updated_at"] ,
        minLimit: json["min_limit"].toString(),
        maxLimit: json["max_limit"].toString(),
        withdrawMethod: json["withdraw_method"] == null ? null : WithdrawMethod.fromJson(json["withdraw_method"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user_id": userId,
        "user_type": userType,
        "method_id": methodId,
        "user_data": userData == null ? [] : List<dynamic>.from(userData!.map((x) => x)),
        "status": status,
        "created_at": createdAt?.toString(),
        "updated_at": updatedAt?.toString(),
        "min_limit": minLimit,
        "max_limit": maxLimit,
        "withdraw_method": withdrawMethod?.toJson(),
      };
}

class WithdrawMethod {
  int? id;
  String? formId;
  String? name;
  String? minLimit;
  String? maxLimit;
  String? fixedCharge;
  String? rate;
  String? percentCharge;
  String? currency;
  String? description;
  String? status;
  List<String>? userGuards;
  String? createdAt;
  String? updatedAt;

  WithdrawMethod({
    this.id,
    this.formId,
    this.name,
    this.minLimit,
    this.maxLimit,
    this.fixedCharge,
    this.rate,
    this.percentCharge,
    this.currency,
    this.description,
    this.status,
    this.userGuards,
    this.createdAt,
    this.updatedAt,
  });

  factory WithdrawMethod.fromJson(Map<String, dynamic> json) => WithdrawMethod(
        id: json["id"],
        formId: json["form_id"].toString(),
        name: json["name"].toString(),
        minLimit: json["min_limit"].toString(),
        maxLimit: json["max_limit"].toString(),
        fixedCharge: json["fixed_charge"].toString(),
        rate: json["rate"].toString(),
        percentCharge: json["percent_charge"].toString(),
        currency: json["currency"].toString(),
        description: json["description"].toString(),
        status: json["status"].toString(),
        userGuards: json["user_guards"] == null ? [] : List<String>.from(json["user_guards"]!.map((x) => x)),
        createdAt: json["created_at"] ,
        updatedAt: json["updated_at"] ,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "form_id": formId,
        "name": name,
        "min_limit": minLimit,
        "max_limit": maxLimit,
        "fixed_charge": fixedCharge,
        "rate": rate,
        "percent_charge": percentCharge,
        "currency": currency,
        "description": description,
        "status": status,
        "user_guards": userGuards == null ? [] : List<dynamic>.from(userGuards!.map((x) => x)),
        "created_at": createdAt?.toString(),
        "updated_at": updatedAt?.toString(),
      };
}
