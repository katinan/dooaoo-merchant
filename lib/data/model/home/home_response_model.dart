import '../auth/sign_up_model/registration_response_model.dart';

class HomeResponseModel {
  HomeResponseModel({
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

  HomeResponseModel.fromJson(dynamic json) {
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
    Merchant? merchant,
    List<LatestTrx>? latestTrx,
    Last7DayMoneyInOut? last7DayMoneyInOut,
    String? totalWithdraw,
  }) {
    _merchant = merchant;
    _latestTrx = latestTrx;
    _last7DayMoneyInOut = last7DayMoneyInOut;
    _totalWithdraw = totalWithdraw;
  }

  Data.fromJson(dynamic json) {
    _merchant = json['merchant'] != null ? Merchant.fromJson(json['merchant']) : null;

    if (json['latest_trx'] != null) {
      _latestTrx = [];
      json['latest_trx'].forEach((v) {
        _latestTrx?.add(LatestTrx.fromJson(v));
      });
    }
    _last7DayMoneyInOut = json['last_7_day_money_in_out'] != null ? Last7DayMoneyInOut.fromJson(json['last_7_day_money_in_out']) : null;
    _totalWithdraw = json['total_withdraw'].toString();
  }
  Merchant? _merchant;
  List<LatestTrx>? _latestTrx;
  Last7DayMoneyInOut? _last7DayMoneyInOut;
  String? _totalWithdraw;

  Merchant? get merchant => _merchant;
  List<LatestTrx>? get latestTrx => _latestTrx;
  Last7DayMoneyInOut? get last7DayMoneyInOut => _last7DayMoneyInOut;
  String? get totalWithdraw => _totalWithdraw;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_merchant != null) {
      map['merchant'] = _merchant?.toJson();
    }

    if (_latestTrx != null) {
      map['latest_trx'] = _latestTrx?.map((v) => v.toJson()).toList();
    }
    if (_last7DayMoneyInOut != null) {
      map['last_7_day_money_in_out'] = _last7DayMoneyInOut?.toJson();
    }

    map['total_withdraw'] = _totalWithdraw;
    return map;
  }
}

class Last7DayMoneyInOut {
  Last7DayMoneyInOut({
    String? totalMoneyIn,
    String? totalMoneyOut,
  }) {
    _totalMoneyIn = totalMoneyIn;
    _totalMoneyOut = totalMoneyOut;
  }

  Last7DayMoneyInOut.fromJson(dynamic json) {
    _totalMoneyIn = json['totalMoneyIn'].toString();
    _totalMoneyOut = json['totalMoneyOut'].toString();
  }
  String? _totalMoneyIn;
  String? _totalMoneyOut;

  String? get totalMoneyIn => _totalMoneyIn;
  String? get totalMoneyOut => _totalMoneyOut;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalMoneyIn'] = _totalMoneyIn;
    map['totalMoneyOut'] = _totalMoneyOut;
    return map;
  }
}

class LatestTrx {
  LatestTrx({
    int? id,
    String? userId,
    String? userType,
    dynamic receiverId,
    dynamic receiverType,
    String? currencyId,
    String? walletId,
    String? beforeCharge,
    String? amount,
    String? charge,
    String? postBalance,
    String? trxType,
    String? chargeType,
    String? trx,
    String? details,
    String? remark,
    String? createdAt,
    String? updatedAt,
    String? apiDetails,
    dynamic receiverUser,
    dynamic receiverAgent,
    dynamic receiverMerchant,
  }) {
    _id = id;
    _userId = userId;
    _userType = userType;
    _receiverId = receiverId;
    _receiverType = receiverType;
    _currencyId = currencyId;
    _walletId = walletId;
    _beforeCharge = beforeCharge;
    _amount = amount;
    _charge = charge;
    _postBalance = postBalance;
    _trxType = trxType;
    _chargeType = chargeType;
    _trx = trx;
    _details = details;
    _remark = remark;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _apiDetails = apiDetails;
    _receiverUser = receiverUser;
    _receiverAgent = receiverAgent;
    _receiverMerchant = receiverMerchant;
  }

  LatestTrx.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _userType = json['user_type'].toString();
    _receiverId = json['receiver_id'].toString();
    _receiverType = json['receiver_type'].toString();
    _currencyId = json['currency_id'].toString();
    _walletId = json['wallet_id'].toString();
    _beforeCharge = json['before_charge'].toString();
    _amount = json['amount'].toString();
    _charge = json['charge'].toString();
    _postBalance = json['post_balance'].toString();
    _trxType = json['trx_type'].toString();
    _chargeType = json['charge_type'].toString();
    _trx = json['trx'];
    _details = json['details'].toString();
    _remark = json['remark'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _apiDetails = json['apiDetails'];
    _receiverUser = json['receiver_user'];
    _receiverAgent = json['receiver_agent'];
    _receiverMerchant = json['receiver_merchant'];
  }
  int? _id;
  String? _userId;
  String? _userType;
  dynamic _receiverId;
  dynamic _receiverType;
  String? _currencyId;
  String? _walletId;
  String? _beforeCharge;
  String? _amount;
  String? _charge;
  String? _postBalance;
  String? _trxType;
  String? _chargeType;
  String? _trx;
  String? _details;
  String? _remark;
  String? _createdAt;
  String? _updatedAt;
  String? _apiDetails;
  dynamic _receiverUser;
  dynamic _receiverAgent;
  dynamic _receiverMerchant;

  int? get id => _id;
  String? get userId => _userId;
  String? get userType => _userType;
  dynamic get receiverId => _receiverId;
  dynamic get receiverType => _receiverType;
  String? get currencyId => _currencyId;
  String? get walletId => _walletId;
  String? get beforeCharge => _beforeCharge;
  String? get amount => _amount;
  String? get charge => _charge;
  String? get postBalance => _postBalance;
  String? get trxType => _trxType;
  String? get chargeType => _chargeType;
  String? get trx => _trx;
  String? get details => _details;
  String? get remark => _remark;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get apiDetails => _apiDetails;
  dynamic get receiverUser => _receiverUser;
  dynamic get receiverAgent => _receiverAgent;
  dynamic get receiverMerchant => _receiverMerchant;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['user_type'] = _userType;
    map['receiver_id'] = _receiverId;
    map['receiver_type'] = _receiverType;
    map['currency_id'] = _currencyId;
    map['wallet_id'] = _walletId;
    map['before_charge'] = _beforeCharge;
    map['amount'] = _amount;
    map['charge'] = _charge;
    map['post_balance'] = _postBalance;
    map['trx_type'] = _trxType;
    map['charge_type'] = _chargeType;
    map['trx'] = _trx;
    map['details'] = _details;
    map['remark'] = _remark;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['apiDetails'] = _apiDetails;

    map['receiver_user'] = _receiverUser;
    map['receiver_agent'] = _receiverAgent;
    map['receiver_merchant'] = _receiverMerchant;
    return map;
  }
}

class Wallets {
  Wallets({
    int? id,
    String? userId,
    String? userType,
    String? currencyId,
    String? currencyCode,
    String? balance,
    String? createdAt,
    String? updatedAt,
    String? transactions,
  }) {
    _id = id;
    _userId = userId;
    _userType = userType;
    _currencyId = currencyId;
    _currencyCode = currencyCode;
    _balance = balance;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _transactions = transactions;
  }

  Wallets.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _userType = json['user_type'.toString()];
    _currencyId = json['currency_id'].toString();
    _currencyCode = json['currency_code'].toString();
    _balance = json['balance'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _transactions = json['transactions'].toString();
  }
  int? _id;
  String? _userId;
  String? _userType;
  String? _currencyId;
  String? _currencyCode;
  String? _balance;
  String? _createdAt;
  String? _updatedAt;
  String? _transactions;

  int? get id => _id;
  String? get userId => _userId;
  String? get userType => _userType;
  String? get currencyId => _currencyId;
  String? get currencyCode => _currencyCode;
  String? get balance => _balance;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get transactions => _transactions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['user_type'] = _userType;
    map['currency_id'] = _currencyId;
    map['currency_code'] = _currencyCode;
    map['balance'] = _balance;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['transactions'] = _transactions;
    return map;
  }
}

class Merchant {
  Merchant({
    int? id,
    String? firstname,
    String? lastname,
    String? username,
    String? email,
    String? countryCode,
    String? mobile,
    String? refBy,
    String? balance,
    String? password,
    String? image,
    Address? address,
    String? status,
    String? kv,
    // List<KycData>? kycData,
    String? ev,
    String? sv,
    String? profileComplete,
    String? verCode,
    String? verCodeSendAt,
    String? ts,
    String? tv,
    dynamic tsc,
    dynamic banReason,
    String? publicApiKey,
    String? secretApiKey,
    dynamic rememberToken,
    String? createdAt,
    String? updatedAt,
    String? getImage,
  }) {
    _id = id;
    _firstname = firstname;
    _lastname = lastname;
    _username = username;
    _email = email;
    _countryCode = countryCode;
    _mobile = mobile;
    _refBy = refBy;
    _balance = balance;
    _password = password;
    _image = image;
    _address = address;
    _status = status;
    _kv = kv;
    // _kycData = kycData;
    _ev = ev;
    _sv = sv;
    _profileComplete = profileComplete;
    _verCode = verCode;
    _verCodeSendAt = verCodeSendAt;
    _ts = ts;
    _tv = tv;
    _tsc = tsc;
    _banReason = banReason;
    _publicApiKey = publicApiKey;
    _secretApiKey = secretApiKey;
    _rememberToken = rememberToken;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _getImage = getImage;
  }

  Merchant.fromJson(dynamic json) {
    _id = json['id'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _username = json['username'];
    _email = json['email'];
    _countryCode = json['country_code'].toString();
    _mobile = json['mobile'].toString();
    _refBy = json['ref_by'].toString();
    _balance = json['balance'].toString();
    _password = json['password'];
    _image = json['image'];
    _address = json['address'] != null ? Address.fromJson(json['address']) : null;
    _status = json['status'].toString();
    _kv = json['kv'].toString();
    _ev = json['ev'].toString();
    _sv = json['sv'].toString();
    _profileComplete = json['profile_complete'].toString();
    _verCode = json['ver_code'].toString();
    _verCodeSendAt = json['ver_code_send_at'];
    _ts = json['ts'].toString();
    _tv = json['tv'].toString();
    _tsc = json['tsc'].toString();
    _banReason = json['ban_reason'].toString();
    _publicApiKey = json['public_api_key'].toString();
    _secretApiKey = json['secret_api_key'].toString();
    _rememberToken = json['remember_token'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _getImage = json['get_image'];
  }
  int? _id;
  String? _firstname;
  String? _lastname;
  String? _username;
  String? _email;
  String? _countryCode;
  String? _mobile;
  String? _refBy;
  String? _balance;
  String? _password;
  String? _image;
  Address? _address;
  String? _status;
  String? _kv;
  List<KycData>? _kycData;
  String? _ev;
  String? _sv;
  String? _profileComplete;
  String? _verCode;
  String? _verCodeSendAt;
  String? _ts;
  String? _tv;
  dynamic _tsc;
  dynamic _banReason;
  String? _publicApiKey;
  String? _secretApiKey;
  dynamic _rememberToken;
  String? _createdAt;
  String? _updatedAt;
  String? _getImage;

  int? get id => _id;
  String? get firstname => _firstname;
  String? get lastname => _lastname;
  String? get username => _username;
  String? get email => _email;
  String? get countryCode => _countryCode;
  String? get mobile => _mobile;
  String? get refBy => _refBy;
  String? get balance => _balance;
  String? get password => _password;
  String? get image => _image;
  Address? get address => _address;
  String? get status => _status;
  String? get kv => _kv;
  List<KycData>? get kycData => _kycData;
  String? get ev => _ev;
  String? get sv => _sv;
  String? get profileComplete => _profileComplete;
  String? get verCode => _verCode;
  String? get verCodeSendAt => _verCodeSendAt;
  String? get ts => _ts;
  String? get tv => _tv;
  dynamic get tsc => _tsc;
  dynamic get banReason => _banReason;
  String? get publicApiKey => _publicApiKey;
  String? get secretApiKey => _secretApiKey;
  dynamic get rememberToken => _rememberToken;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get getImage => _getImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['firstname'] = _firstname;
    map['lastname'] = _lastname;
    map['username'] = _username;
    map['email'] = _email;
    map['country_code'] = _countryCode;
    map['mobile'] = _mobile;
    map['ref_by'] = _refBy;
    map['balance'] = _balance;
    map['password'] = _password;
    map['image'] = _image;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    map['status'] = _status;
    map['kv'] = _kv;
    if (_kycData != null) {
      map['kyc_data'] = _kycData?.map((v) => v.toJson()).toList();
    }
    map['ev'] = _ev;
    map['sv'] = _sv;
    map['profile_complete'] = _profileComplete;
    map['ver_code'] = _verCode;
    map['ver_code_send_at'] = _verCodeSendAt;
    map['ts'] = _ts;
    map['tv'] = _tv;
    map['tsc'] = _tsc;
    map['ban_reason'] = _banReason;
    map['public_api_key'] = _publicApiKey;
    map['secret_api_key'] = _secretApiKey;
    map['remember_token'] = _rememberToken;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['get_image'] = _getImage;
    return map;
  }
}

class KycData {
  KycData({
    String? name,
    String? type,
    String? value,
  }) {
    _name = name;
    _type = type;
    _value = value;
  }

  KycData.fromJson(dynamic json) {
    _name = json['name'];
    _type = json['type'];
    _value = json['value'];
  }
  String? _name;
  String? _type;
  String? _value;

  String? get name => _name;
  String? get type => _type;
  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['type'] = _type;
    map['value'] = _value;
    return map;
  }
}

class Address {
  Address({
    String? address,
    String? city,
    String? state,
    String? zip,
    String? country,
  }) {
    _address = address;
    _city = city;
    _state = state;
    _zip = zip;
    _country = country;
  }

  Address.fromJson(dynamic json) {
    _address = json['address'] != null ? json['address'].toString() : "";
    _city = json['city'] != null ? json['city'].toString() : "";
    _state = json['state'] != null ? json['state'].toString() : "";
    _zip = json['zip'] != null ? json['zip'].toString() : "";
    _country = json['country'] != null ? json['country'].toString() : "";
  }
  String? _address;
  String? _city;
  String? _state;
  String? _zip;
  String? _country;

  String? get address => _address;
  String? get city => _city;
  String? get state => _state;
  String? get zip => _zip;
  String? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['city'] = _city;
    map['state'] = _state;
    map['zip'] = _zip;
    map['country'] = _country;
    return map;
  }
}
