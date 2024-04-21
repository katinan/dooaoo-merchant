import 'package:get/get.dart';
import 'package:viserpay_merchant/view/screens/Profile/profile_screen.dart';
import 'package:viserpay_merchant/view/screens/account/change-password/change_password_screen.dart';
import 'package:viserpay_merchant/view/screens/account/delete-account/delete_account_screen.dart';
import 'package:viserpay_merchant/view/screens/auth/email_verification_page/email_verification_screen.dart';
import 'package:viserpay_merchant/view/screens/auth/forget_password/forget_password/forget_password.dart';
import 'package:viserpay_merchant/view/screens/auth/forget_password/reset_password/reset_password_screen.dart';
import 'package:viserpay_merchant/view/screens/auth/forget_password/verify_forget_password/verify_forget_password_screen.dart';
import 'package:viserpay_merchant/view/screens/auth/kyc/kyc.dart';
import 'package:viserpay_merchant/view/screens/auth/login/login_screen.dart';
import 'package:viserpay_merchant/view/screens/auth/profile_complete/profile_complete_screen.dart';
import 'package:viserpay_merchant/view/screens/auth/registration/registration_screen.dart';
import 'package:viserpay_merchant/view/screens/auth/sms_verification_page/sms_verification_screen.dart';
import 'package:viserpay_merchant/view/screens/auth/two_factor_screen/two_factor_setup_screen.dart';
import 'package:viserpay_merchant/view/screens/auth/two_factor_screen/two_factor_verification_screen.dart';
import 'package:viserpay_merchant/view/screens/bottom_nav_section/home/home_screen.dart';
import 'package:viserpay_merchant/view/screens/bottom_nav_section/menu/menu_screen.dart';
import 'package:viserpay_merchant/view/screens/edit_profile/edit_profile_screen.dart';
import 'package:viserpay_merchant/view/screens/language/language_screen.dart';
import 'package:viserpay_merchant/view/screens/otp/otp_screen.dart';
import 'package:viserpay_merchant/view/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:viserpay_merchant/view/screens/qr_scan/my_qr_code.dart';
import 'package:viserpay_merchant/view/screens/splash/splash_screen.dart';
import 'package:viserpay_merchant/view/screens/transaction/transaction_history_screen.dart';
import 'package:viserpay_merchant/view/screens/withdrawals/withdraw_history/withdraw_history_screen.dart';
import 'package:viserpay_merchant/view/screens/withdrawals/withdraw_method/add_withdraw_method.dart';
import 'package:viserpay_merchant/view/screens/withdrawals/withdraw_method/edit_withdraw_method.dart';
import 'package:viserpay_merchant/view/screens/withdrawals/withdraw_method/withdraw_method_screen.dart';
import 'package:viserpay_merchant/view/screens/withdrawals/withdraw_money/withdraw_money_screen.dart';
import 'package:viserpay_merchant/view/screens/withdrawals/withdraw_preview/withdraw_preview_screen.dart';

class RouteHelper {
  static const String splashScreen = "/splash_screen";
  static const String onboardScreen = "/onboard_screen";
  static const String loginScreen = "/login_screen";
  static const String forgotPasswordScreen = "/forgot_password_screen";
  static const String changePasswordScreen = "/change_password_screen";
  static const String registrationScreen = "/registration_screen";
  static const String otpScreen = "/otp_screen";
  static const String bottomNavBar = "/bottom_nav_bar";
  static const String menuScreen = "/menu_screen";
  static const String myWalletScreen = "/my_wallet_screen";
  static const String homeScreen = "/home_screen";

  static const String profileCompleteScreen = "/profile_complete_screen";

  static const String emailVerificationScreen = '/verify_email_screen';
  static const String smsVerificationScreen = '/verify_sms_screen';
  static const String verifyPassCodeScreen = '/verify_pass_code_screen';
  static const String twoFactorScreen = "/two-factor-screen";
  static const String resetPasswordScreen = '/reset_pass_screen';

  static const String transactionHistoryScreen = "/transaction_history_screen";
  static const String myQRCodeScreen = "/my_qr_code_screen";

  static const String withdrawMoneyScreen = "/withdraw_money_screen";
  static const String withdrawPreviewScreen = "/withdraw_preview_screen";
  static const String withdrawHistoryScreen = "/withdraw_history_screen";
  static const String addWithdrawMethodScreen = "/add_withdraw_method_screen";
  static const String withdrawMethodScreen = "/withdraw_method_screen";
  static const String editWithdrawMethod = "/withdraw_method_edit_screen";

  static const String profileScreen = "/profile_screen";
  static const String editProfileScreen = "/edit_profile_screen";
  static const String kycScreen = "/kyc_screen";

  static const String privacyScreen = "/privacy_screen";
  static const String removeAccountScreen = "/remove_account_screen";
  static const String languageScreen = "/languages_screen";

  static const String twoFactorSetupScreen = "/two-factor-setup-screen";

  List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: forgotPasswordScreen, page: () => const ForgetPasswordScreen()),
    GetPage(name: changePasswordScreen, page: () => const ChangePasswordScreen()),
    GetPage(name: registrationScreen, page: () => const RegistrationScreen()),
    GetPage(name: profileCompleteScreen, page: () => const ProfileCompleteScreen()),
    GetPage(name: bottomNavBar, page: () => const HomeScreen()),
    // GetPage(name: bottomNavBar, page: () => const BottomNavBar()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: menuScreen, page: () => const MenuScreen()),

    GetPage(name: withdrawMoneyScreen, page: () => const WithdrawMoneyScreen()),
    GetPage(name: withdrawPreviewScreen, page: () => const WithdrawPreviewScreen()),
    GetPage(name: withdrawHistoryScreen, page: () => WithdrawHistoryScreen(isShowBackBtn: Get.arguments ?? true)),
    GetPage(name: withdrawMethodScreen, page: () => const WithdrawMethodScreen()),
    GetPage(name: addWithdrawMethodScreen, page: () => const AddWithdrawMethodScreen()),
    GetPage(name: editWithdrawMethod, page: () => const EditWithdrawMethod()),

    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(name: editProfileScreen, page: () => const EditProfileScreen()),
    GetPage(name: transactionHistoryScreen, page: () => const TransactionHistoryScreen()),
    GetPage(name: kycScreen, page: () => const KycScreen()),

    GetPage(
        name: emailVerificationScreen,
        page: () => EmailVerificationScreen(
              needSmsVerification: Get.arguments[0],
              isProfileCompleteEnabled: Get.arguments[1],
              needTwoFactor: Get.arguments[2],
            )),
    GetPage(name: smsVerificationScreen, page: () => const SmsVerificationScreen()),
    GetPage(name: verifyPassCodeScreen, page: () => const VerifyForgetPassScreen()),
    GetPage(name: resetPasswordScreen, page: () => const ResetPasswordScreen()),
    GetPage(name: twoFactorScreen, page: () => TwoFactorVerificationScreen(isProfileCompleteEnable: Get.arguments)),

    GetPage(name: otpScreen, page: () => OtpScreen(actionId: Get.arguments[0], nextRoute: Get.arguments[1], otpType: Get.arguments[2])),
    GetPage(name: kycScreen, page: () => const KycScreen()),
    GetPage(name: privacyScreen, page: () => const PrivacyPolicyScreen()),
    GetPage(name: myQRCodeScreen, page: () => const MyQrCodeScreen()),
    GetPage(name: removeAccountScreen, page: () => const DisableAccountScreen()),
    GetPage(name: languageScreen, page: () => const LanguageScreen()),
    GetPage(name: twoFactorSetupScreen, page: () => const TwoFactorSetupScreen()),
  ];
}
