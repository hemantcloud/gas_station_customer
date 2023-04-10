import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_customer/models/categories_model.dart';
import 'package:gas_station_customer/models/wallet_balance_model.dart';
import 'package:gas_station_customer/views/home/qr.dart';
import 'package:gas_station_customer/views/home/merchants.dart';
import 'package:gas_station_customer/views/home/notification.dart';
import 'package:gas_station_customer/views/utilities/loader.dart';
import 'package:gas_station_customer/views/utilities/urls.dart';
import 'package:gas_station_customer/views/utilities/utilities.dart';
import 'package:internet_popup/internet_popup.dart';
import 'package:page_transition/page_transition.dart';

// apis
import 'dart:async';
import 'dart:convert' as convert;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
// apis
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isConnected = false;
  late String authToken;
  late String userId;
  int balance = 0;
  List<CategoriesData> categoriesList = [];
  CategoriesModel res = new CategoriesModel();
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
    // categoriesApi(context);
    if(isConnected) {
      walletBalanceApi(context);
      categoriesApi(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            // statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          toolbarHeight: 60.0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(/*top: 20.0, */bottom: 0.0),
            child: Container(
              height: 60.0,
              margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              // padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent, width: 0.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    // onTap: () => filterBottomSheet(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: const BorderRadius.all(Radius.circular(19.0)),
                        border: Border.all(width: 1,color: AppColors.primary),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 5.0),
                            child: Text(
                              '\$$balance',
                              style: const TextStyle(color: AppColors.primary),
                            ),
                          ),
                          // const SizedBox(height: 5.0),
                          SvgPicture.asset('assets/icons/wallet.svg',color: AppColors.primary,width: 16.0),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'All Categories',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
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
                          child: const QR(),
                        ),
                      );
                    },
                    child: SvgPicture.asset('assets/icons/qr.svg'),
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
                    child: Row(
                      children: [
                        const SizedBox(width: 15.0),
                        SvgPicture.asset('assets/icons/bell.svg'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          elevation: 0.0,
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration.zero,() {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  walletBalanceApi(context);
                  categoriesApi(context);
                });
                setState(() {});
              },
            );
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                categoriesList.isEmpty ?
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: Text("Data not found"),
                  ),
                ) :
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2/2,
                    childAspectRatio: 8/9,
                  ),
                  itemCount: categoriesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    // final splitted = categorieslist[index].bg!.split('#');
                    // String color = '0xFF${splitted[1].toLowerCase()}';
                    return  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            alignment: Alignment.topCenter,
                            duration: const Duration(milliseconds: 1000),
                            isIos: true,
                            child: Merchants(categoryId: categoriesList[index].id!),
                          ),
                        );
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Padding(
                        padding:  const EdgeInsets.only(top: 10.0,bottom: 0.0,right: 5.0,left: 5.0,),
                        child: Container(
                          height: 170.0,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.0),
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFFbfbfbf),width: 1,style: BorderStyle.solid),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFFbfbfbf),
                                offset: Offset(
                                  0.0,
                                  0.0,
                                ),
                                blurRadius: 4.0,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 90.0,
                                height: 90.0,
                                padding: const EdgeInsets.all(20.0),
                                decoration: const BoxDecoration(
                                    color:  Color(0xFFEEE9FF),
                                    shape: BoxShape.circle
                                ),
                                child: Image.network(
                                  categoriesList[index].icon.toString(),
                                  width: 58.0,
                                  height: 58.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 10.0,),
                              Text(
                                categoriesList[index].name.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                /*InkWell(
                  onTap: () {
                    exit(0);
                  },
                  child: Container(
                    width: 30.0,
                    height: 30.0,
                    color: Colors.red,
                    child: Text("data"),
                  ),
                ),*/
              ],
            ),
          ),
        ),
        // extendBodyBehindAppBar: true,
      ),
    );
  }
  // categoriesapi api
  Future<void> categoriesApi(BuildContext context) async {
    Loader.progressLoadingDialog(context, true);
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.get(Uri.parse(Urls.categoriesUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-CLIENT": Urls.x_client_token,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    res = await CategoriesModel.fromJson(jsonResponse);
    if (res.status == true) {
      categoriesList = res.data!;
      setState(() {});
    } else {
      Utilities().toast(res.message.toString());
      setState(() {});
    }
    return;
  }
  // categoriesapi api
  // walletBalanceApi
  Future<void> walletBalanceApi(BuildContext context) async {
    // Loader.ProgressloadingDialog(context, true);
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
    // Loader.ProgressloadingDialog(context, false);
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
}