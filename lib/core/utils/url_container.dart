class UrlContainer {
  static const String domainUrl = 'https://script.viserlab.com/viserpay';
  static const String baseUrl = '$domainUrl/api/';

  static const String registrationEndPoint = 'merchant/register';
  static const String loginEndPoint = 'merchant/login';
  static const String logoutUrl = 'merchant/logout';


  static const String forgetPasswordEndPoint = 'merchant/password/email';
  static const String passwordVerifyEndPoint = 'merchant/password/verify-code';
  static const String resetPasswordEndPoint = 'merchant/password/reset';
  static const String verify2FAUrl = 'merchant/verify-g2fa';

  static const String otpVerify = 'merchant/otp-verify';
  static const String otpResend = 'merchant/otp-resend';

  static const String verifyEmailEndPoint = 'merchant/verify-email';
  static const String verifySmsEndPoint = 'merchant/verify-mobile';
  static const String resendVerifyCodeEndPoint = 'merchant/resend-verify/email';

  static const String authorizationCodeEndPoint = 'merchant/authorization';

  static const String dashBoardUrl = 'merchant/dashboard';
  static const String transactionEndpoint = 'merchant/transactions';

  static const String accountDisable = "merchant/account/delete";

  //withdraw
  static const String withdrawHistoryUrl = 'merchant/withdraw/history';
  static const String withdrawMoneyUrl = 'merchant/withdraw/methods';
  static const String submitWithdrawMoneyUrl = 'merchant/withdraw/money';
  static const String withdrawPreviewUrl = 'merchant/withdraw/preview';
  static const String withdrawMoneySubmitUrl = 'merchant/withdraw/money/submit';
  static const String addWithdrawMethodUrl = 'merchant/withdraw/add-method';
  static const String withdrawMethodUrl = 'merchant/withdraw/methods';
  static const String withdrawMethodEdit = 'merchant/withdraw/edit-method/';
  static const String withdrawMethodUpdate = 'merchant/withdraw/method/update';

  //kyc
  static const String kycFormUrl = 'merchant/kyc-form';
  static const String kycSubmitUrl = 'merchant/kyc-submit';

  static const String generalSettingEndPoint = 'general-setting';
  static const String moduleSettingEndPoint = 'module-setting';

  //privacy policy
  static const String privacyPolicyEndPoint = 'policy-pages';

  //profile
  static const String getProfileEndPoint = 'merchant/user-info';
  static const String updateProfileEndPoint = 'merchant/profile-setting';
  static const String profileCompleteEndPoint = 'merchant/data-submit';

  //change password
  static const String changePasswordEndPoint = 'merchant/change-password';
  static const String countryEndPoint = 'get-countries';

  static const String deviceTokenEndPoint = 'merchant/get/device/token';
  static const String languageUrl = 'language/';

  static const String walletsEndPoint = "merchant/wallets";
  static const String qrCodeEndPoint = "merchant/qr-code";
  static const String qrScanEndPoint = "qr-code/scan";

  static const String qrCodeImageDownload = "merchant/qr-code/download";

  static const String twoFactor = "merchant/twofactor";
  static const String twoFactorEnable = "merchant/twofactor/enable";
  static const String twoFactorDisable = "merchant/twofactor/disable";

  static const String countryFlagImageLink = 'https://flagpedia.net/data/flags/h24/{countryCode}.webp';
}
