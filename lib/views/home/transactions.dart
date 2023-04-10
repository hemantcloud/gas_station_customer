import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_customer/models/transactions_model.dart';
import 'package:gas_station_customer/views/utilities/loader.dart';
import 'package:gas_station_customer/views/utilities/urls.dart';
import 'package:gas_station_customer/views/utilities/utilities.dart';
import 'package:internet_popup/internet_popup.dart';

// apis
import 'dart:async';
import 'dart:convert' as convert;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
// apis

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  bool isConnected = false;
  TextEditingController amountController = TextEditingController();
  List<Transactions>? transactionList = [];
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool isLoading = false;
  int page = 1;

  late String authToken;
  late String userId;
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
    if(isConnected) {
      initApiCall();
      apiRefresh();
    }
  }
  initApiCall(){
    transactionList!.clear();
    Future.delayed(Duration(seconds: 0),(){
      setState(()=> WidgetsBinding.instance.addPostFrameCallback((_) => transactionsApi(context)));
      //  Notificationapi(context);
    });
  }
  apiRefresh() async{
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (!isLoading) {
          // isLoading = !isLoading;
          page = page+1;
          isLoading = !isLoading;
          print("page>>>>>>>><<<<<<<${page}");

          setState(()=> WidgetsBinding.instance.addPostFrameCallback((_) => transactionsApi(context)));
        }
      }
    });
    // Future.delayed(const Duration(seconds: 0), () {
    //   notificationController.getNotificationApiCall(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEEE7F6),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColors.primary,
          title: const Text('Transactions',style: TextStyle(fontSize: 18.0,)),
          elevation: 0.0,
        ),
        body: transactionList!.isEmpty ? const Center(child: Text("No transaction yet!"),) : SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactionList!.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   PageTransition(
                      //     type: PageTransitionType.rightToLeftWithFade,
                      //     alignment: Alignment.topCenter,
                      //     duration: const Duration(milliseconds: 1000),
                      //     isIos: true,
                      //     child: const StationProfile(),
                      //   ),
                      // );
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        color: Colors.white,
                        // border: Border.all(
                        //   width: 1.0,
                        //   color: AppColors.border,
                        //   style: BorderStyle.solid,
                        // ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFe6e6e6),
                            offset: Offset(
                              0.0,
                              0.0,
                            ),
                            blurRadius: 4.0,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(transactionList![index].type == "Debit" ? "assets/icons/debit.svg" : "assets/icons/credit.svg",width: 50.0,),
                          const SizedBox(width: 10.0),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transactionList![index].title.toString(),
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  "${Utilities().DatefomatToDate(transactionList![index].createdAt!)} ${Utilities().DatefomatToMonth(transactionList![index].createdAt!)} ${Utilities().DatefomatToYear(transactionList![index].createdAt!)}",
                                  // "${Utilities().DatefomatToDate(transactionList![index].createdAt!)}",
                                  style: TextStyle(color: AppColors.secondary,fontSize: 12.0),
                                ),
                                Text(
                                  "ID : ${transactionList![index].customerUniqueid.toString()}",
                                  style: const TextStyle(color: AppColors.secondary,fontSize: 12.0),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            "\$${transactionList![index].amount!.replaceAll("-", "").replaceAll("+", "")}",
                            style: TextStyle(
                                color: transactionList![index].type == 'Debit' ? AppColors.red : AppColors.green,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
  // transactionsApi
  Future<void> transactionsApi(BuildContext context) async {
    Loader.progressLoadingDialog(context, true);
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var request = {};
    request['page'] = page;
    var response = await http.post(Uri.parse(Urls.transactions),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    TransactionsModel res = await TransactionsModel.fromJson(jsonResponse);
    if(res.status == true){
      // transactionList = res.data!.transactions;
      // setState(() {});
      var data = jsonResponse['data']['transactions'];

      if (data != null) {
        print("data>>>${data}");
        data.forEach((e) {
          Transactions nModel = Transactions.fromJson(e);
          // print("NotificationModel...${nModel.date}");
          transactionList!.add(nModel);
          setState((){});
        });
      }
    }else{
      Utilities().toast(res.message);
      setState(() {});
    }
    return;
  }
  // transactionsApi
}