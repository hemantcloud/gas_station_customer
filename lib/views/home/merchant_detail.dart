// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_customer/models/merchant_details_model.dart';
import 'package:gas_station_customer/views/home/qr.dart';
import 'package:gas_station_customer/views/utilities/loader.dart';
import 'package:gas_station_customer/views/utilities/urls.dart';
import 'package:gas_station_customer/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';

// apis
import 'dart:async';
import 'dart:convert' as convert;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
// apis

class MerchantDetail extends StatefulWidget {
  int merchantId;
  String profileImage;
  String merchantName;
  String categoryName;
  String rating;
  String? about;
  String distance;
  double latitude;
  double longitude;
  MerchantDetail({Key? key,required this.merchantId,required this.profileImage,required this.merchantName,required this.categoryName,required this.rating,required this.about,required this.distance,required this.latitude,required this.longitude}) : super(key: key);

  @override
  State<MerchantDetail> createState() => _MerchantDetailState();
}

class _MerchantDetailState extends State<MerchantDetail> {
  TextEditingController otpController = TextEditingController();
  late String authToken;
  late String userId;
  List<Discounts> discountList = [];
  String aboutData = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
      allProcess();
    });
  }
  allProcess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("widget.merchantId is ----------${widget.merchantId}");
    authToken = prefs.getString('authToken')!;
    userId = prefs.getString('userId')!;
    print('my auth token is >>>>> {$authToken}');
    print('my user id is >>>>> {$userId}');
    merchantProfileApi(context, widget.merchantId);
    print("widget.rating is -----------${widget.rating}");
    print("widget.rating type is -----------${widget.rating.runtimeType}");
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
              child: SvgPicture.asset('assets/icons/left.svg',color: Colors.white,),
            ),
          ),
          toolbarHeight: 50.0,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/station_profile_bg.png"),
              alignment: Alignment.topCenter,
              fit: BoxFit.contain
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.yellow,width: 2,style: BorderStyle.solid),
                      borderRadius: const BorderRadius.all(Radius.circular(11.0)),
                      image: DecorationImage(
                        image: NetworkImage(widget.profileImage),
                        fit: BoxFit.cover,
                        alignment: Alignment.center
                      )
                    ),
                    width: 130.0,
                    height: 130.0,
                    // child: Image.network(
                    //   widget.profileImage,
                    //   height: MediaQuery.of(context).size.width * 0.37,
                    // ),
                  ),
                ),
                flex: 35,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                    ),
                    boxShadow: [
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
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 70.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.only(bottom: 20.0),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF4F5F7),
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.merchantName,
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    Text(
                                      widget.categoryName,
                                      style: const TextStyle(color: AppColors.secondary),
                                    ),
                                    Row(
                                      children: [
                                        widget.rating == "0.0" ?
                                        Container() :
                                        SvgPicture.asset('assets/icons/star.svg'),
                                        widget.rating == "0.0" ?
                                        Container() :
                                        const SizedBox(width: 5.0),
                                        widget.rating == "0.0" ?
                                        const Text(
                                          "No ratings yet",
                                          style: TextStyle(color: AppColors.black,fontSize: 10.0),
                                        ) :
                                        Text(
                                          widget.rating,
                                          style: const TextStyle(color: AppColors.black,fontSize: 10.0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    openMap(widget.latitude, widget.longitude);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 10.0,),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.0),
                                      // color: AppColors.disabledButtonColor,
                                      color: AppColors.primary,
                                    ),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/icons/up_arrow.svg'),
                                        const SizedBox(width: 5.0),
                                        Text(
                                          '${widget.distance} KM',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ),
                        const Text(
                          'About',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Text(
                          aboutData == null || aboutData.isEmpty ? 'No data found' : aboutData!,
                          style: const TextStyle(color: AppColors.secondary),
                        ),
                        const Divider(
                          color: AppColors.secondary,
                          thickness: 0.4,
                        ),
                        const Text(
                          'Discount',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        discountList.isEmpty ? const Text("No discounts yet?",style: TextStyle(color: AppColors.secondary),) : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: discountList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  discountList[index].title!,
                                  style: const TextStyle(color: AppColors.black),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  discountList[index].description!,
                                  style: const TextStyle(color: AppColors.secondary),
                                ),
                                const Divider(
                                  color: AppColors.secondary,
                                  thickness: 0.4,
                                ),
                                const SizedBox(height: 10.0),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                flex: 60,
              ),
            ],
          ),
        ),
        extendBodyBehindAppBar: true,
        floatingActionButton: InkWell(
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
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
            height: 55.0,
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.1,right: MediaQuery.of(context).size.height * 0.05),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(19.0),
              ),
            ),
            child: Row(
              children: [
                Image.asset('assets/icons/scan_to_pay.png'),
                const Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Scan to Pay',
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
  // merchantsListApi
  Future<void> merchantProfileApi(BuildContext context, int merchantId) async {
    Loader.progressLoadingDialog(context, true);
    var request = {};
    request['merchant_id'] = merchantId;
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Urls.merchantDetail),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    MerchantDetailsModel res = await MerchantDetailsModel.fromJson(jsonResponse);
    if(res.status == true){
      discountList = res.data!.discounts!;
      if(res.data!.about == null){
        aboutData = '';
      }else{
        aboutData = res.data!.about!;
      }
      setState(() {});
    }else{
      Utilities().toast(res.message);
      setState(() {});
    }
    return;
  }
  // merchantsListApi
  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
