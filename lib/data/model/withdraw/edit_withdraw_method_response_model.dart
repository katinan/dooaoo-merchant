import 'dart:io';

import '../auth/sign_up_model/registration_response_model.dart';

class EditWithdrawMethodResponseModel {
  EditWithdrawMethodResponseModel({
    String? remark,
    String? status,
    Message? message,
    Data? data,
  }) {
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  EditWithdrawMethodResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  Data? _data;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    MainWithdrawMethod? withdrawMethod,
    Form? form,
    String? filePath,
  }) {
    _withdrawMethod = withdrawMethod;
    _form = form;
    _filePath = filePath;
  }

  Data.fromJson(dynamic json) {
    _withdrawMethod = json['withdraw_method'] != null ? MainWithdrawMethod.fromJson(json['withdraw_method']) : null;

    _form = json['form']['form_data'] != null ? Form.fromJson(json['form']['form_data']) : null;
    _filePath = json['file_path'];
  }
  MainWithdrawMethod? _withdrawMethod;
  Form? _form;
  String? _filePath;

  MainWithdrawMethod? get withdrawMethod => _withdrawMethod;
  Form? get form => _form;
  String? get filePath => _filePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_withdrawMethod != null) {
      map['withdraw_method'] = _withdrawMethod?.toJson();
    }
    map['file_path'] = _filePath;
    return map;
  }
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
          ).toList();

      if (list.isNotEmpty) {
        list.removeWhere((element) => element.toString().isEmpty);
        _list?.addAll(list);
      }
      _list;
    } catch(e) {}
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

class MainWithdrawMethod {
  MainWithdrawMethod({
    int? id,
    String? name,
    String? userId,
    String? userType,
    String? methodId,
    String? currencyId,
    List<UserData>? userData,
    String? status,
    String? createdAt,
    String? updatedAt,
    WithdrawMethod? withdrawMethod,
  }) {
    _id = id;
    _name = name;
    _userId = userId;
    _userType = userType;
    _methodId = methodId;
    _currencyId = currencyId;
    _userData = userData;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _withdrawMethod = withdrawMethod;
  }

  MainWithdrawMethod.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _userId = json['user_id'].toString();
    _userType = json['user_type'].toString();
    _methodId = json['method_id'].toString();
    _currencyId = json['currency_id'].toString();
    if (json['user_data'] != null) {
      _userData = [];
      json['user_data'].forEach((v) {
        _userData?.add(UserData.fromJson(v));
      });
    }
    _status = json['status'].toString();
    _createdAt = json['created_at'].toString();
    _updatedAt = json['updated_at'].toString();
    _withdrawMethod = json['withdraw_method'] != null ? WithdrawMethod.fromJson(json['withdraw_method']) : null;
  }

  int? _id;
  String? _name;
  String? _userId;
  String? _userType;
  String? _methodId;
  String? _currencyId;
  List<UserData>? _userData;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  WithdrawMethod? _withdrawMethod;

  int? get id => _id;
  String? get name => _name;
  String? get userId => _userId;
  String? get userType => _userType;
  String? get methodId => _methodId;
  String? get currencyId => _currencyId;
  List<UserData>? get userData => _userData;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  WithdrawMethod? get withdrawMethod => _withdrawMethod;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['user_id'] = _userId;
    map['user_type'] = _userType;
    map['method_id'] = _methodId;
    map['currency_id'] = _currencyId;
    if (_userData != null) {
      map['user_data'] = _userData?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_withdrawMethod != null) {
      map['withdraw_method'] = _withdrawMethod?.toJson();
    }
    return map;
  }
}

class WithdrawMethod {
  WithdrawMethod({
    int? id,
    String? formId,
    String? name,
    String? minLimit,
    String? maxLimit,
    String? fixedCharge,
    String? rate,
    String? percentCharge,
    dynamic currency,
    String? description,
    String? status,
    List<String>? currencies,
    String? createdAt,
    String? updatedAt,
    Form? form,
  }) {
    _id = id;
    _formId = formId;
    _name = name;
    _minLimit = minLimit;
    _maxLimit = maxLimit;
    _fixedCharge = fixedCharge;
    _rate = rate;
    _percentCharge = percentCharge;
    _currency = currency;
    _description = description;
    _status = status;
    _userGuards = userGuards;
    _currencies = currencies;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _form = form;
  }

  WithdrawMethod.fromJson(dynamic json) {
    _id = json['id'];
    _formId = json['form_id'].toString();
    _name = json['name'].toString();
    _minLimit = json['min_limit'].toString();
    _maxLimit = json['max_limit'].toString();
    _fixedCharge = json['fixed_charge'].toString();
    _rate = json['rate'].toString();
    _percentCharge = json['percent_charge'].toString();
    _currency = json['currency'].toString();
    _description = json['description'].toString();
    _status = json['status'].toString();
    _createdAt = json['created_at'].toString();
    _updatedAt = json['updated_at'].toString();
    _form = json['form']['form_data'] != null ? Form.fromJson(json['form']['form_data']) : null;
  }
  int? _id;
  String? _formId;
  String? _name;
  String? _minLimit;
  String? _maxLimit;
  String? _fixedCharge;
  String? _rate;
  String? _percentCharge;
  dynamic _currency;
  String? _description;
  String? _status;
  List<String>? _userGuards;
  List<String>? _currencies;
  String? _createdAt;
  String? _updatedAt;
  Form? _form;

  int? get id => _id;
  String? get formId => _formId;
  String? get name => _name;
  String? get minLimit => _minLimit;
  String? get maxLimit => _maxLimit;
  String? get fixedCharge => _fixedCharge;
  String? get rate => _rate;
  String? get percentCharge => _percentCharge;
  dynamic get currency => _currency;
  String? get description => _description;
  String? get status => _status;
  List<String>? get userGuards => _userGuards;
  List<String>? get currencies => _currencies;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Form? get form => _form;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['form_id'] = _formId;
    map['name'] = _name;
    map['min_limit'] = _minLimit;
    map['max_limit'] = _maxLimit;
    map['fixed_charge'] = _fixedCharge;
    map['rate'] = _rate;
    map['percent_charge'] = _percentCharge;
    map['currency'] = _currency;
    map['description'] = _description;
    map['status'] = _status;
    map['user_guards'] = _userGuards;
    map['currencies'] = _currencies;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;

    return map;
  }
}

class UserData {
  UserData({
    String? name,
    String? type,
    dynamic value,
  }) {
    _name = name;
    _type = type;
    _value = value;
  }

  UserData.fromJson(dynamic json) {
    _name = json['name'];
    _type = json['type'];
    _value = json['value'];
  }
  String? _name;
  String? _type;
  dynamic _value;

  String? get name => _name;
  String? get type => _type;
  dynamic get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['type'] = _type;
    map['value'] = _value;
    return map;
  }
}
