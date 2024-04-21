

import 'dart:convert';
import 'dart:io';
import 'package:viserpay_merchant/data/model/auth/sign_up_model/registration_response_model.dart';

WithdrawMethodResponseModel withdrawMethodResponseModelFromJson(String str) => WithdrawMethodResponseModel.fromJson(json.decode(str));

String withdrawMethodResponseModelToJson(WithdrawMethodResponseModel data) => json.encode(data.toJson());

class WithdrawMethodResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  WithdrawMethodResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory WithdrawMethodResponseModel.fromJson(Map<String, dynamic> json) => WithdrawMethodResponseModel(
        remark: json["remark"],
        status: json["status"],
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "remark": remark,
        "status": status,
        "message": message?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  List<WithdrawMethod>? withdrawMethod;

  Data({
    this.withdrawMethod,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        withdrawMethod: json["withdraw_method"] == null
            ? []
            : List<WithdrawMethod>.from(json["withdraw_method"]!.map(
                (x) => WithdrawMethod.fromJson(x),
              )));
  }

  Map<String, dynamic> toJson() => {
        "withdraw_method": withdrawMethod == null ? [] : List<WithdrawMethod>.from(withdrawMethod!.map((x) => x.toJson())),
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
  Form? form;

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
    this.form,
  });

  factory WithdrawMethod.fromJson(Map<String, dynamic> json) => WithdrawMethod(
        id: json["id"],
        formId: json["form_id"].toString(),
        name: json["name"],
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
        form: json["form"] == null ? null : Form.fromJson(json["form"]["form_data"]),
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

class Form {
  Form({List<FormModel>? list}) {
    _list = list;
  }

  List<FormModel>? _list = [];
  List<FormModel>? get list => _list;

  Form.fromJson(dynamic json) {

    try {
      var map = Map.from(json).map((key, value) => MapEntry(key, value));
      List<FormModel>? list = map.entries
          .map(
            (e) => FormModel(e.value['name'], e.value['label'], e.value['is_required'].toString(), e.value['extensions'], (e.value['options'] as List).map((e) => e as String).toList(), e.value['type'].toString(), ''),
          )
          .toList();

      if (list.isNotEmpty) {
        list.removeWhere((element) => element.toString().isEmpty);
        _list?.addAll(list);
      }
      _list;
    } finally {}
  }
}

class FormModel {
  String? name;
  String? label;
  String? isRequired;
  String? extensions;
  List<String>? options;
  String? type;
  dynamic selectedValue;
  File? imageFile;
  List<String>? cbSelected;

  FormModel(this.name, this.label, this.isRequired, this.extensions, this.options, this.type, this.selectedValue, {this.cbSelected, this.imageFile});
}
