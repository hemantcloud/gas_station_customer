import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_customer/models/logout_model.dart';
import 'package:gas_station_customer/models/profile_model.dart';
import 'package:gas_station_customer/views/authentication/login.dart';
import 'package:gas_station_customer/views/home/dashboard.dart';
import 'package:gas_station_customer/views/home/help_and_support.dart';
import 'package:gas_station_customer/views/home/notification.dart';
import 'package:gas_station_customer/views/home/privacy_policy.dart';
import 'package:gas_station_customer/views/home/terms_and_conditions.dart';
import 'package:gas_station_customer/views/home/update_profile.dart';
import 'package:gas_station_customer/views/utilities/loader.dart';
import 'package:gas_station_customer/views/utilities/urls.dart';
import 'package:gas_station_customer/views/utilities/utilities.dart';
import 'package:internet_popup/internet_popup.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';
// apis
import 'dart:async';
import 'dart:convert' as convert;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
// apis

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool isConnected = false;
  late String authToken;
  late String userId;
  Data? userData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
      allProcess();
    });
  }
  Future<void> allProcess() async {
    InternetPopup().initialize(context: context);
    isConnected = await InternetPopup().checkInternet();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      authToken = prefs.getString('authToken')!;
      userId = prefs.getString('userId')!;
      print('my auth token is >>>>> {$authToken}');
      print('my user id is >>>>> {$userId}');
    });
    if(isConnected) {
      profileApi(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColors.primary,
          title: const Text('Settings',style: TextStyle(fontSize: 18.0,)),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    SvgPicture.asset('assets/icons/gas_station.svg'),
                    const SizedBox(height: 20.0),
                    Text(
                      userData == null ? '' :userData!.fullName.toString(),
                      style: TextStyle(color: AppColors.black,fontSize: 16.0,fontWeight: FontWeight.w600),
                    ),
                    Text(
                      userData == null ? '' :userData!.email.toString(),
                      style: TextStyle(color: AppColors.secondary,),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      alignment: Alignment.topCenter,
                      duration: const Duration(milliseconds: 1000),
                      isIos: true,
                      child: UpdateProfile(userData: userData!),
                    ),
                  ).then((value) {
                    profileApi(context);
                  });
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 58.0,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  decoration: myBoxDecoration(),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/profile.svg'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          color: AppColors.primary,
                          thickness: 1,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Profile',
                          style: TextStyle(color: AppColors.secondary),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/right.svg',width: 10.0),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      alignment: Alignment.topCenter,
                      duration: const Duration(milliseconds: 1000),
                      isIos: true,
                      child: Dashboard(bottomIndex: 2),
                    ),
                  );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 58.0,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  decoration: myBoxDecoration(),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/transaction_history.svg'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          color: AppColors.primary,
                          thickness: 1,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Transaction History',
                          style: TextStyle(color: AppColors.secondary),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/right.svg',width: 10.0),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   PageTransition(
                  //     type: PageTransitionType.rightToLeftWithFade,
                  //     alignment: Alignment.topCenter,
                  //     duration: const Duration(milliseconds: 1000),
                  //     isIos: true,
                  //     child: const Login(),
                  //   ),
                  // );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 58.0,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  decoration: myBoxDecoration(),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/payment_method.svg'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          color: AppColors.primary,
                          thickness: 1,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Payment Method',
                          style: TextStyle(color: AppColors.secondary),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/right.svg',width: 10.0),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      alignment: Alignment.topCenter,
                      duration: const Duration(milliseconds: 1000),
                      isIos: true,
                      child:  NotificationScreen(status: 'back',),
                    ),
                  );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 58.0,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  decoration: myBoxDecoration(),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/notification3.svg'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          color: AppColors.primary,
                          thickness: 1,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Notification',
                          style: TextStyle(color: AppColors.secondary),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/right.svg',width: 10.0),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _share();
                  // Navigator.push(
                  //   context,
                  //   PageTransition(
                  //     type: PageTransitionType.rightToLeftWithFade,
                  //     alignment: Alignment.topCenter,
                  //     duration: const Duration(milliseconds: 1000),
                  //     isIos: true,
                  //     child: const Login(),
                  //   ),
                  // );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 58.0,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  decoration: myBoxDecoration(),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/refer_a_friend.svg'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          color: AppColors.primary,
                          thickness: 1,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Refer a friend',
                          style: TextStyle(color: AppColors.secondary),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/right.svg',width: 10.0),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      alignment: Alignment.topCenter,
                      duration: const Duration(milliseconds: 1000),
                      isIos: true,
                      child: const HelpAndSupport(),
                    ),
                  );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 58.0,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  decoration: myBoxDecoration(),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/help_and_support.svg'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          color: AppColors.primary,
                          thickness: 1,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Help and Support',
                          style: TextStyle(color: AppColors.secondary),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/right.svg',width: 10.0),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      alignment: Alignment.topCenter,
                      duration: const Duration(milliseconds: 1000),
                      isIos: true,
                      child: const PrivacyPolicy(),
                    ),
                  );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 58.0,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  decoration: myBoxDecoration(),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/privacy_policy.svg'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          color: AppColors.primary,
                          thickness: 1,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Privacy Policy',
                          style: TextStyle(color: AppColors.secondary),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/right.svg',width: 10.0),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      alignment: Alignment.topCenter,
                      duration: const Duration(milliseconds: 1000),
                      isIos: true,
                      child: const TermAndCondition(),
                    ),
                  );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 58.0,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  decoration: myBoxDecoration(),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/term_and_condition.svg'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          color: AppColors.primary,
                          thickness: 1,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Terms & Condition',
                          style: TextStyle(color: AppColors.secondary),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/right.svg',width: 10.0),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  dialogueBox(context);
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 58.0,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  decoration: myBoxDecoration(),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/logout.svg'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          color: AppColors.primary,
                          thickness: 1,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Logout',
                          style: TextStyle(color: AppColors.secondary),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/right.svg',width: 10.0),
                    ],
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
  myBoxDecoration(){
    return const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Color(0xFFe6e6e6),
          offset: Offset(
            0.0,
            0.0,
          ),
          blurRadius: 8.0,
          spreadRadius: 0,
        ),
      ],
    );
  }
  void dialogueBox(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(13.0)),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
          backgroundColor: AppColors.white,
          title: Column(
            children: [
              // const Text('?',style: TextStyle(color: AppColors.primary,fontSize: 50.0),),
              // SvgPicture.asset("assets/icons/alert2.svg",width: 100.0,color: AppColors.primary,),
              SvgPicture.asset('assets/icons/logout.svg',height: 60,),
              const SizedBox(height: 20.0),
              const Text(
                'Are you sure\ndo you want to exit',
                style: TextStyle(color: AppColors.secondary,fontSize: 14.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        // margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
                        // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: const BoxDecoration(
                          color: AppColors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: const Text(
                          'No',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        logoutApi(context);
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        // margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
                        // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: const Text(
                          'Yes',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
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
        );
      },
    );
  }
  // logoutApi
  Future<void> logoutApi(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Loader.progressLoadingDialog(context, true);
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.get(Uri.parse(Urls.logout),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    LogoutModel res = await LogoutModel.fromJson(jsonResponse);
    if(res.status == true){
      prefs.setBool('isLogin',false);
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
      Utilities().toast(res.message);
      setState(() {});
    }else{
      Utilities().toast(res.message);
      setState(() {});
    }
    return;
  }
  // logoutApi
  // profileApi api
  Future<void> profileApi(BuildContext context) async {
    Loader.progressLoadingDialog(context, true);
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.get(Uri.parse(Urls.profile),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    ProfileModel res = await ProfileModel.fromJson(jsonResponse);
    if (res.status == true) {
      userData = res.data;
      setState(() {});
    } else {
      Utilities().toast(res.message.toString());
      setState(() {});
    }
    return;
  }
  // profileApi api

  void _share() {
    Share.share('check out my website https://example.com', subject: 'Look what I made!');
  }
}