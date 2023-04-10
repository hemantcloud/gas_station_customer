import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_customer/models/merchants_model.dart';
import 'package:gas_station_customer/views/home/notification.dart';
import 'package:gas_station_customer/views/home/merchant_detail.dart';
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
class Merchants extends StatefulWidget {
  int categoryId;
  Merchants({Key? key,required this.categoryId}) : super(key: key);

  @override
  State<Merchants> createState() => _MerchantsState();
}

class _MerchantsState extends State<Merchants> {
  late String authToken;
  late String userId;
  List<Users>? merchantsList = [];
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool isLoading = false;
  int page = 1;

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
    print("widget.categoryId is ----------${widget.categoryId}");
    authToken = prefs.getString('authToken')!;
    userId = prefs.getString('userId')!;
    print('my auth token is >>>>> {$authToken}');
    print('my user id is >>>>> {$userId}');
    initApiCall();
    apiRefresh();
    setState(() {});
  }
  initApiCall(){
    merchantsList!.clear();
    Future.delayed(Duration(seconds: 0),(){
      setState(()=> WidgetsBinding.instance.addPostFrameCallback((_) => merchantsListApi(context, widget.categoryId, "", true)));
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

          setState(()=> WidgetsBinding.instance.addPostFrameCallback((_) => merchantsListApi(context, widget.categoryId, "", true)));
        }
      }
    });
    // Future.delayed(const Duration(seconds: 0), () {
    //   notificationController.getNotificationApiCall(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        toolbarHeight: 80.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50.0,
                      margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent, width: 0.0),
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color(0xFFEAEAEA),
                        // color: Colors.red,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: SvgPicture.asset(
                              'assets/icons/search.svg',
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              onChanged: (val){
                                print("valonc is ------------------$val");
                                merchantsListApi(context,widget.categoryId,val,false);
                              },
                              onSubmitted: (val){
                                print("val is ------------------$val");
                                merchantsListApi(context,widget.categoryId,val,false);
                              },
                              controller: searchController,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w500,
                              ),
                              cursorColor: AppColors.primary,
                              decoration: const InputDecoration(
                                hintText: 'Search Keywords...',
                                hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
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
                    child: SvgPicture.asset('assets/icons/bell.svg'),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
            ],
          ),
        ),
        elevation: 0.0,
      ),
      body: merchantsList!.isEmpty ? const Center(child: Text("Data not found"),) : SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: merchantsList!.length,
          itemBuilder: (BuildContext context, int index) {
            double doubleDistance = 0.0;
            if(merchantsList![index].distance == null){
              doubleDistance = 0.0;
            }else{
              doubleDistance = double.parse(merchantsList![index].distance.toString());
            }
            String doubleDistance2 = doubleDistance.toStringAsFixed(2);
            // print("doubleDistance2 is ----------$doubleDistance2");
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    alignment: Alignment.topCenter,
                    duration: const Duration(milliseconds: 1000),
                    isIos: true,
                    child: MerchantDetail(
                      merchantId: int.parse(merchantsList![index].id.toString()),
                      profileImage: merchantsList![index].profileImage.toString(),
                      merchantName: merchantsList![index].fullName.toString(),
                      categoryName: merchantsList![index].categoryName.toString(),
                      about: merchantsList![index].about,
                      rating: merchantsList![index].avgRating.toString(),
                      distance: doubleDistance2,
                      latitude: double.parse(merchantsList![index].latitude.toString()),
                      longitude: double.parse(merchantsList![index].longitude.toString()),
                    ),
                  ),
                );
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                      color: Colors.transparent,
                      // border: Border.all(
                      //   width: 1.0,
                      //   color: AppColors.border,
                      //   style: BorderStyle.solid,
                      // ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 60.0,
                          height: 60.0,
                          foregroundDecoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(merchantsList![index].profileImage.toString()),
                              fit: BoxFit.cover
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(5.0))
                          ),
                          // child: Image.network(merchantsList![index].profileImage!,width: 60.0,),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                merchantsList![index].fullName.toString(),
                                // " dsfds fdsf dsf dsf dsf dsf dsf dsf dsf dsf",
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                merchantsList![index].categoryName!,
                                style: const TextStyle(color: AppColors.secondary),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  merchantsList![index].avgRating == "0.0" ?
                                  Container() :
                                  SvgPicture.asset('assets/icons/star.svg'),
                                  merchantsList![index].avgRating == "0.0" ?
                                  Container() :
                                  const SizedBox(width:5.0),
                                  Text(
                                    merchantsList![index].avgRating == "0.0" ? "No ratings yet" : merchantsList![index].avgRating!,
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: merchantsList![index].avgRating == "0.0" ? 12.0 : 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            openMap(double.parse(merchantsList![index].latitude.toString()), double.parse(merchantsList![index].longitude.toString()));
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Row(
                              children: [
                                const SizedBox(width: 10.0),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 10.0,),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14.0),
                                    // color: AppColors.red,
                                    color: AppColors.primary,
                                  ),
                                  child: Text(
                                    '$doubleDistance2 KM',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 0.1,
                    color: AppColors.secondary,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      extendBodyBehindAppBar: true,
    );
  }
  // merchantsListApi
  Future<void> merchantsListApi(BuildContext context, int categoryId, String val,bool isLoad) async {
    if(isLoad){
      Loader.progressLoadingDialog(context, true);
    }
    var request = {};
    request['category_id'] = categoryId;
    request['search'] = val;
    request['page'] = page;
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Urls.merchants),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    if(isLoad) {
      Loader.progressLoadingDialog(context, false);
    }
    MerchantsModel res = await MerchantsModel.fromJson(jsonResponse);
    if(res.status == true){
      // merchantsList = res.data!.users;
      // setState(() {});
      var data = jsonResponse['data']['users'];

      if (data != null) {
        print("data>>>${data}");
        data.forEach((e) {
          Users nModel = Users.fromJson(e);
          // print("NotificationModel...${nModel.date}");
          merchantsList!.add(nModel);
          setState((){});
        });
      }
    }else{
      Utilities().toast(res.message);
      setState(() {});
    }
    return;
  }
  // merchantsListApi
  // merchantsListApi
  /*Future<void> searchApi(BuildContext context, String keyw) async {
    Loader.ProgressloadingDialog(context, true);
    var request = {};
    request['search'] = keyw;
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Urls.searchMerchants),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.ProgressloadingDialog(context, false);
    SearchMerchantsModel res = await SearchMerchantsModel.fromJson(jsonResponse);
    if(res.status == true){
      merchantsList!.clear();
      merchantsList = res.data!.user!;
      setState(() {});
    }else{
      Utilities().toast(res.message);
      setState(() {});
    }
    return;
  }*/
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