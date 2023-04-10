// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_customer/models/merchant_details_after_scan_model.dart';
import 'package:gas_station_customer/models/pay_model.dart';
import 'package:gas_station_customer/models/wallet_balance_model.dart';
import 'package:gas_station_customer/views/home/success.dart';
import 'package:gas_station_customer/views/utilities/loader.dart';
import 'package:gas_station_customer/views/utilities/urls.dart';
import 'package:gas_station_customer/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';

// apis
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
// apis

class Pay extends StatefulWidget {
  String merchantId;
  Pay({Key? key,required this.merchantId}) : super(key: key);

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  TextEditingController amountController = TextEditingController();
  FocusNode focusAmt = FocusNode();
  late String authToken;
  late String userId;
  int balance = 0;
  MerchantData? merchantData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    all_process();
  }
  Future<void> all_process() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      authToken = prefs.getString('authToken')!;
      userId = prefs.getString('userId')!;
      print('my auth token is >>>>> {$authToken}');
      print('my user id is >>>>> {$userId}');
    });
    walletBalanceApi(context);
    merchantDetailAfterScanApi(context,widget.merchantId);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    focusAmt.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEEE7F6),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primary,
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.only(top: 15.0,bottom: 15.0),
              child: SvgPicture.asset('assets/icons/left.svg',color: Colors.white,),
            ),
          ),
          title: const Text('Pay Now',style: TextStyle(fontSize: 18.0,)),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0,),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: merchantData == null ?
                      const CircleAvatar(
                        maxRadius: 22.0,
                        backgroundImage: AssetImage('assets/images/profile_default.png'),
                      ) :
                      CircleAvatar(
                        maxRadius: 22.0,
                        backgroundImage: NetworkImage(merchantData!.profileImage!),
                      ),
                    ),
                    const SizedBox(width: 0.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          merchantData == null ? "" : merchantData!.fullName!,
                          style: const TextStyle(
                              fontSize: 16.0,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        /*Text(
                          merchantData == null ? "" : merchantData!.fullName!,
                          style: TextStyle(color: AppColors.secondary),
                        ),*/
                      ],
                    )
                  ],
                ),
                const Divider(
                  color: AppColors.secondary,
                  thickness: 0.3,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
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
                          focusNode: focusAmt,
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
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15.0),
                  margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary, width: 1.0),
                    borderRadius: BorderRadius.circular(5.0),
                    // color: const Color(0xFFEAEAEA),
                    // color: Colors.red,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/wallet.svg',color: AppColors.primary,width: 25.0),
                      const SizedBox(width: 10.0),
                      const Expanded(
                        flex: 1,
                        child: Text('Wallet Balance',style: TextStyle(color: AppColors.primary)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('\$$balance USD',style: const TextStyle(color: AppColors.primary),textAlign: TextAlign.right,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          color: const Color(0xFFEEE7F6),
          child: InkWell(
            onTap: () {
              focusAmt.unfocus();
              String amt = amountController.text;
              if(amt.isEmpty){
                Utilities().toast("Payment must be at least ₹1.");
              }else {
                Pay(context, widget.merchantId);
              }
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              height: 55.0,
              margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.all(Radius.circular(19.0)),
              ),
              child: const Text(
                'Proceed to Pay',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
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
  // merchantDetailAfterScanApi
  Future<void> merchantDetailAfterScanApi(BuildContext context, String merchantID) async {
    Loader.progressLoadingDialog(context, true);
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var request = {};
    request['merchant_id'] = merchantID;
    var response = await http.post(Uri.parse(Urls.merchantDetailsAfterScan),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    MerchantDetailsAfterScanModel res = await MerchantDetailsAfterScanModel.fromJson(jsonResponse);
    if(res.status == true){
      merchantData = res.data;
      setState(() {});
    }else{
      Utilities().toast(res.message);
      setState(() {});
    }
    return;
  }
  // merchantDetailAfterScanApi
  // Pay
  Future<void> Pay(BuildContext context, String merchantID) async {
    Loader.progressLoadingDialog(context, true);
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var request = {};
    request['merchant_id'] = merchantID;
    request['pay_amount'] = amountController.text;
    var response = await http.post(Uri.parse(Urls.pay),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    PayModel res = await PayModel.fromJson(jsonResponse);
    if(res.status == true){
      Utilities().toast(res.message);
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          alignment: Alignment.topCenter,
          duration: const Duration(milliseconds: 1000),
          isIos: true,
          child: Success(merchanId: merchantData!.id!,profileImage: merchantData!.profileImage!,name: merchantData!.fullName!),
        ),
      );
      setState(() {});
    }else{
      Utilities().toast(res.message);
      setState(() {});
    }
    return;
  }
  // Pay
}
