import '../auth/sign_up_model/registration_response_model.dart';

class WithdrawPreviewResponseModel {
  WithdrawPreviewResponseModel({
    String? remark,
    String? status,
    Message? message,
    Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  WithdrawPreviewResponseModel.fromJson(dynamic json) {
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
    List<String>? otpType,
    Withdraw? withdraw,
    String? remainingBalance,
  }){
    _otpType = otpType;
    _withdraw = withdraw;
    _remainingBalance = remainingBalance;
  }

  Data.fromJson(dynamic json) {
    _otpType = json['otp_type'] != null ? json['otp_type'].cast<String>() : [];
    _withdraw = json['withdraw'] != null ? Withdraw.fromJson(json['withdraw']) : null;
    _remainingBalance = json['remaining_balance'] != null ? json['remaining_balance'].toString() : "";
  }
  List<String>? _otpType;
  Withdraw? _withdraw;
  String? _remainingBalance;

  List<String>? get otpType => _otpType;
  Withdraw? get withdraw => _withdraw;
  String? get remainingBalance => _remainingBalance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['otp_type'] = _otpType;
    if (_withdraw != null) {
      map['withdraw'] = _withdraw?.toJson();
    }
    map['remaining_balance'] = map['method_id'] = _remainingBalance;
    return map;
  }

}

class Withdraw {
  Withdraw({
    int? id,
    String? methodId,
    String? userId,
    String? userType,
    String? amount,
    String? currencyId,
    String? walletId,
    String? currency,
    String? rate,
    String? charge,
    String? trx,
    String? finalAmount,
    String? afterCharge,
    String? status,
    dynamic adminFeedback,
    String? createdAt,
    String? updatedAt,
    Method? method,
    }){
    _id = id;
    _methodId = methodId;
    _userId = userId;
    _userType = userType;
    _amount = amount;
    _currencyId = currencyId;
    _walletId = walletId;
    _currency = currency;
    _rate = rate;
    _charge = charge;
    _trx = trx;
    _finalAmount = finalAmount;
    _afterCharge = afterCharge;
    _status = status;
    _adminFeedback = adminFeedback;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _method = method;
  }

  Withdraw.fromJson(dynamic json) {
    _id = json['id'];
    _methodId = json['method_id'].toString();
    _userId = json['user_id'].toString();
    _userType = json['user_type'].toString();
    _amount = json['amount'] != null ? json['amount'].toString() : "";
    _currencyId = json['currency_id'].toString();
    _walletId = json['wallet_id'].toString();
    _currency = json['currency'] != null ? json['currency'].toString() : "";
    _rate = json['rate'].toString();
    _charge = json['charge'].toString();
    _trx = json['trx'].toString();
    _finalAmount = json['final_amount'] != null ? json['final_amount'].toString() : "";
    _afterCharge = json['after_charge'].toString();
    _status = json['status'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _method = json['method'] != null ? Method.fromJson(json['method']) : null;
  }
  int? _id;
  String? _methodId;
  String? _userId;
  String? _userType;
  String? _amount;
  String? _currencyId;
  String? _walletId;
  String? _currency;
  String? _rate;
  String? _charge;
  String? _trx;
  String? _finalAmount;
  String? _afterCharge;
  String? _status;
  dynamic _adminFeedback;
  String? _createdAt;
  String? _updatedAt;
  Method? _method;

  int? get id => _id;
  String? get methodId => _methodId;
  String? get userId => _userId;
  String? get userType => _userType;
  String? get amount => _amount;
  String? get currencyId => _currencyId;
  String? get walletId => _walletId;
  String? get currency => _currency;
  String? get rate => _rate;
  String? get charge => _charge;
  String? get trx => _trx;
  String? get finalAmount => _finalAmount;
  String? get afterCharge => _afterCharge;
  String? get status => _status;
  dynamic get adminFeedback => _adminFeedback;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Method? get method => _method;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['method_id'] = _methodId;
    map['user_id'] = _userId;
    map['user_type'] = _userType;
    map['amount'] = _amount;
    map['currency_id'] = _currencyId;
    map['wallet_id'] = _walletId;
    map['currency'] = _currency;
    map['rate'] = _rate;
    map['charge'] = _charge;
    map['trx'] = _trx;
    map['final_amount'] = _finalAmount;
    map['after_charge'] = _afterCharge;
    map['status'] = _status;
    map['admin_feedback'] = _adminFeedback;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_method != null) {
      map['method'] = _method?.toJson();
    }
    return map;
  }

}


class Method {
  Method({
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
    List<String>? userGuards,
    List<String>? currencies,
    String? createdAt,
    String? updatedAt,}){
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
  }

  Method.fromJson(dynamic json) {
    _id = json['id'];
    _formId = json['form_id'].toString();
    _name = json['name'];
    _minLimit = json['min_limit'] != null ? json['min_limit'].toString() : "";
    _maxLimit = json['max_limit'] != null ? json['max_limit'].toString() : "";
    _fixedCharge = json['fixed_charge'] != null ? json['fixed_charge'].toString() : "";
    _rate = json['rate'] !=null? json['rate'].toString() : '';
    _percentCharge = json['percent_charge'].toString();
    _currency = json['currency'] != null ? json['currency'].toString() : "";
    _description = json['description'].toString();
    _status = json['status'].toString();
    _userGuards = json['user_guards'] != null ? json['user_guards'].cast<String>() : [];
    _currencies = json['currencies'] != null ? json['currencies'].cast<String>() : [];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
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