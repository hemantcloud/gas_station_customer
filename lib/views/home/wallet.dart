import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_customer/models/add_wallet_balance_model.dart';
import 'package:gas_station_customer/models/wallet_balance_model.dart';
import 'package:gas_station_customer/views/home/dashboard.dart';
import 'package:gas_station_customer/views/home/success.dart';
import 'package:gas_station_customer/views/utilities/loader.dart';
import 'package:gas_station_customer/views/utilities/urls.dart';
import 'package:gas_station_customer/views/utilities/utilities.dart';
import 'package:internet_popup/internet_popup.dart';
import 'package:page_transition/page_transition.dart';

// apis
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
// apis


class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool isConnected = false;
  TextEditingController amountController = TextEditingController();
  late String authToken;
  late String userId;
  int balance = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allProcess();
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
    if(isConnected){
      walletBalanceApi(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEEE7F6),
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primary,
          title: const Text('My Wallet',style: TextStyle(fontSize: 18.0,)),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0,),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: const Text(
                        'Wallet Balance',
                        style: TextStyle(color: AppColors.black,fontSize: 16.0),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                          '\$$balance',
                          style: TextStyle(color: AppColors.primary,fontSize: 20.0,fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(
                      color: AppColors.secondary,
                      thickness: 0.3,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      padding: const EdgeInsets.only(top: 10.0),
                      child: const Text(
                        'Topup Wallet',
                        style: TextStyle(color: AppColors.black,fontSize: 16.0),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary, width: 1.0),
                        borderRadius: BorderRadius.circular(5.0),
                        // color: const Color(0xFFEAEAEA),
                        // color: Colors.red,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: amountController,
                              style: const TextStyle(fontSize: 14.0, color: AppColors.black),
                              cursorColor: AppColors.primary,
                              decoration: myInputDecoration('Enter Amount'),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: const Text(
                        'Recommended',
                        style: TextStyle(color: AppColors.black,)
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 10.0),
                        InkWell(
                          onTap: () {
                            amountController.text = 1000.toString();
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 0.0),
                            margin: const EdgeInsets.only(right: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: const BorderRadius.all(Radius.circular(19.0)),
                              border: Border.all(width: 1,color: AppColors.primary),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(right: 5.0),
                              child: const Text(
                                '\$1000',
                                style: TextStyle(color: AppColors.primary),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            amountController.text = 2000.toString();
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 0.0),
                            margin: const EdgeInsets.only(right: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: const BorderRadius.all(Radius.circular(19.0)),
                              border: Border.all(width: 1,color: AppColors.primary),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(right: 5.0),
                              child: const Text(
                                '\$2000',
                                style: TextStyle(color: AppColors.primary),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            amountController.text = 5000.toString();
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 0.0),
                            margin: const EdgeInsets.only(right: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: const BorderRadius.all(Radius.circular(19.0)),
                              border: Border.all(width: 1,color: AppColors.primary),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(right: 5.0),
                              child: const Text(
                                '\$5000',
                                style: TextStyle(color: AppColors.primary),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        String amt = amountController.text;
                        if(amt.isEmpty){
                          Utilities().toast("Payment must be at least ₹1.");
                        }else{
                          addWalletBalanceApi(context);
                        }
                        // Navigator.pushAndRemoveUntil(
                        //   context,
                        //   PageTransition(
                        //     type: PageTransitionType.rightToLeftWithFade,
                        //     alignment: Alignment.topCenter,
                        //     duration: const Duration(milliseconds: 1000),
                        //     isIos: true,
                        //     child: const Login(),
                        //   ),
                        //   (route) => false,
                        // );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        margin: const EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.all(Radius.circular(19.0)),
                        ),
                        child: const Text(
                          'PROCEED TO TOPUP',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
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
                  padding: const EdgeInsets.symmetric(vertical: 16.0,),
                  margin: const EdgeInsets.only(top: 20.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 10.0),
                      SvgPicture.asset('assets/icons/transaction2.svg'),
                      const SizedBox(width: 10.0),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Wallet Transaction History',
                          style: TextStyle(color: AppColors.black,fontSize: 16.0),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/right.svg',width: 12.0),
                      const SizedBox(width: 10.0),
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
  // walletBalanceApi
  Future<void> walletBalanceApi(BuildContext context) async {
    Loader.progressLoadingDialog(context, true);
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Urls.walletBalance),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    WalletBalanceModel res = await WalletBalanceModel.fromJson(jsonResponse);
    if(res.status == true){
      balance = int.parse(res.data!.balance!);
      setState(() {});
    }else{
      Utilities().toast(res.message);
      setState(() {});
    }
    return;
  }
  // walletBalanceApi
  // walletBalanceApi
  Future<void> addWalletBalanceApi(BuildContext context) async {
    Loader.progressLoadingDialog(context, true);
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var request = {};
    request['amount'] = amountController.text;
    var response = await http.post(Uri.parse(Urls.addWalletBalance),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    AddWalletBalanceModel res = await AddWalletBalanceModel.fromJson(jsonResponse);
    if(res.status == true){
      Utilities().toast(res.message);
      walletBalanceApi(context);
      amountController.clear();
      setState(() {});
    }else{
      Utilities().toast(res.message);
      setState(() {});
    }
    return;
  }
  // walletBalanceApi
}
