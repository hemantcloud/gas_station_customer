// ignore_for_file: constant_identifier_names

class Urls {
  //Base
  static const url = "https://itmates.digital/gasstation/";
  static const baseUrl = "https://itmates.digital/gasstation/api/";
  static const profileImageUrl = "https://itmates.digital/gasstation/public/profileImages/";
  // static const categoryImageUrl = "https://itmates.digital/gasstation_merchant/public/categoryicon";
  static const x_client_token = "e0271afd8a3b8257af70deaceeedsf87rer4";

  //Other Apis
  static const categoriesUrl = "${baseUrl}categories";
  static const submitPhone = "${baseUrl}submitContactNumber_customer";
  static const verifyPhone = "${baseUrl}verifyOtpForMobileno_customer";
  static const submitEmail = "${baseUrl}submitEmail_customer";
  static const verifyEmail = "${baseUrl}verifyOtpForEmail_customer";
  static const register = "${baseUrl}registerUser_customer";
  static const login = "${baseUrl}loginUser_customer";
  static const logout = "${baseUrl}logoutUser_customer";
  static const changePassword = "${baseUrl}changepassword_customer";
  static const submitEmailForgotPassword = "${baseUrl}sendEmailForgotPassword_customer";
  static const verifyOtpForgotPassword = "${baseUrl}verifyotpforchangepass_customer";
  static const resetPassword = "${baseUrl}resetpassword_customer";
  static const submitPhoneForgotPassword = "${baseUrl}sendMobileForgotPassword_customer";
  static const profile = "${baseUrl}profileUser_customer";
  static const updateProfile = "${baseUrl}updateprofile_customer";
  static const termsConditions = "${baseUrl}termsCondtions";
  static const privacyPolicy = "${baseUrl}privacypolicy";
  static const helpSupport = "${baseUrl}supportSetting";
  static const merchants = "${baseUrl}nearByselectcategory_customer";
  static const merchantDetail = "${baseUrl}merchantdetail_customer";
  static const walletBalance = "${baseUrl}walletBalance_customer";
  static const addWalletBalance = "${baseUrl}addWalletBalnace_customer";
  static const merchantDetailsAfterScan = "${baseUrl}scanPay_customer";
  static const pay = "${baseUrl}payNow_customer";
  static const rating = "${baseUrl}submitrating_customer";
  static const transactions = "${baseUrl}transactionHistory_customer";
  static const notification = "${baseUrl}notificationlist_customer";
}