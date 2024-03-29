// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_customer/models/submit_email_model.dart';
import 'package:gas_station_customer/models/verify_phone_model.dart';
import 'package:gas_station_customer/views/authentication/login.dart';
import 'package:gas_station_customer/views/authentication/otp_verification_email.dart';
import 'package:gas_station_customer/views/authentication/register.dart';
import 'package:gas_station_customer/views/utilities/loader.dart';
import 'package:gas_station_customer/views/utilities/urls.dart';
import 'package:gas_station_customer/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';
// apis
import 'dart:async';
import 'dart:convert' as convert;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// apis

class OtpVerificationPhone extends StatefulWidget {
  String fullName;
  String countryCode;
  String mobileNumber;
  String email;
  String password;
  String cPassword;
  String address1;
  String? address2;
  String city;
  String state;
  String zip;
  String deviceType;
  String deviceId;
  String fcmToken;
  String timezone;
  String lat;
  String long;
  OtpVerificationPhone({
    Key? key,
    required this.fullName,
    required this.countryCode,
    required this.mobileNumber,
    required this.email,
    required this.password,
    required this.cPassword,
    required this.address1,
    this.address2,
    required this.city,
    required this.state,
    required this.zip,
    required this.deviceType,
    required this.deviceId,
    required this.fcmToken,
    required this.timezone,
    required this.lat,
    required this.long,
  }) : super(key: key);

  @override
  State<OtpVerificationPhone> createState() => _OtpVerificationPhoneState();
}

class _OtpVerificationPhoneState extends State<OtpVerificationPhone> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
              child: SvgPicture.asset('assets/icons/left.svg'),
            ),
          ),
          toolbarHeight: 50.0,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.1,
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SvgPicture.asset('assets/icons/gas_station.svg'),
              ),
              Container(
                // alignment: Alignment.center,
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.1),
                child: const Text(
                  'Enter OTP',
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 26.0,
                      fontWeight: FontWeight.w600
                  ),
                  // textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.05),
                child: const Text(
                  'Enter verification code we have sent to your registered Phone number',
                  style: TextStyle(color: AppColors.secondary),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10.0),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: otpController,
                        style: const TextStyle(fontSize: 14.0, color: AppColors.black),
                        cursorColor: AppColors.primary,
                        decoration: myInputDecoration('Enter OTP'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  String otp = otpController.text;
                  if(otp.isEmpty){
                    Utilities().toast('Please enter otp');
                  } else if(otp.length != 4){
                    Utilities().toast('Please enter valid otp');
                  }else {
                    verifyPhoneApi(context);
                  }
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 55.0,
                  margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.05),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.all(Radius.circular(19.0)),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  myInputDecoration(String s) {
    return InputDecoration(
      hintText: s,
      hintStyle: const TextStyle(
        color: AppColors.secondary,
        fontWeight: FontWeight.w500,
      ),
      border: InputBorder.none,
    );
  }
  Future successAlert(context) {
    setState(() {});
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20.0/*,vertical: MediaQuery.of(context).size.height * 0.18*/),
        content: Container(
          // padding: EdgeInsets.symmetric(vertical: 10.0),
          height: 300.0,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: Colors.white),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset('assets/icons/success.svg',height: 120.0,),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: const Text(
                  'Registration Completed\nSuccessfully',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: AppColors.black,
                      fontWeight: FontWeight.w600
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Text(
                'You can login now',
                style: TextStyle(
                  color: AppColors.secondary,
                ),
                textAlign: TextAlign.center,
                // maxLines: 3,
                // overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10.0,),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            alignment: Alignment.topCenter,
                            duration: const Duration(milliseconds: 1000),
                            isIos: true,
                            child: const Login(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.15),
                        // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.all(Radius.circular(19.0)),
                        ),
                        child: const Text(
                          'OK',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  // verifyPhoneApi api
  Future<void> verifyPhoneApi(BuildContext context) async {
    Loader.progressLoadingDialog(context, true);
    var request = {};
    request['country_code'] = widget.countryCode;
    request['mobile_number'] = widget.mobileNumber;
    request['otp'] = otpController.text;
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Urls.verifyPhone),
        body: convert.jsonEncode(request),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-CLIENT": Urls.x_client_token,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    VerifyPhoneModel res = await VerifyPhoneModel.fromJson(jsonResponse);
    if (res.status == true) {
      Utilities().toast(res.message.toString());
      submitEmailApi(context);
      setState(() {});
    } else {
      Utilities().toast(res.message.toString());
      setState(() {});
    }
    return;
  }
  // verifyPhoneApi api
  // submitEmailApi api
  Future<void> submitEmailApi(BuildContext context) async {
    Loader.progressLoadingDialog(context, true);
    var request = {};
    request['email'] = widget.email;
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Urls.submitEmail),
        body: convert.jsonEncode(request),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-CLIENT": Urls.x_client_token,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    SubmitEmailModel res = await SubmitEmailModel.fromJson(jsonResponse);
    if (res.status == true) {
      Utilities().toast(res.message.toString());
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          alignment: Alignment.topCenter,
          duration: const Duration(milliseconds: 1000),
          isIos: true,
          child: OtpVerificationEmail(
              fullName: widget.fullName,
              countryCode: widget.countryCode,
              mobileNumber: widget.mobileNumber,
              otpMobileNumber: otpController.text,
              email: widget.email,
              password: widget.password,
              cPassword: widget.cPassword,
              address1: widget.address1,
              address2: widget.address2,
              city: widget.city,
              state: widget.state,
              zip: widget.zip,
              deviceType: widget.deviceType,
              deviceId: widget.deviceId,
              fcmToken: widget.fcmToken,
              timezone: widget.timezone,
              lat: widget.lat,
              long: widget.long
          ),
        ),
      );
      /*      Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          alignment: Alignment.topCenter,
          duration: const Duration(milliseconds: 1000),
          isIos: true,
          child: OtpVerification(
              fullName: widget.fullName,
              countryCode: widget.countryCode,
              mobileNumber: widget.mobileNumber,
              otpMobileNumber: otpForPhone,
              email: widget.email,
              password: widget.password,
              cPassword: widget.cPassword,
              category: widget.category,
              address1: widget.address1,
              address2: widget.address2,
              city: widget.city,
              state: widget.state,
              zip: widget.zip,
              withdrawalFrequency: widget.withdrawalFrequency,
              mailingAddress: widget.mailingAddress,
              federalIdentificationNumber: widget.federalIdentificationNumber,
              salesTaxIdentificationNumber: widget.salesTaxIdentificationNumber,
              deviceType: widget.deviceType,
              deviceId: widget.deviceId,
              fcmToken: widget.fcmToken,
              timezone: widget.timezone,
              lat: widget.lat,
              long: widget.long,
              profileImage: widget.profileImage
          ),
        ),
        (route) => false,
      );*/
      setState(() {});
    } else {
      Utilities().toast(res.message.toString());
      Navigator.of(context).pop();
      setState(() {});
    }
    return;
  }
// submitEmailApi api
}
