// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_customer/views/authentication/create_password.dart';
import 'package:gas_station_customer/views/authentication/forgot_password.dart';
import 'package:gas_station_customer/views/home/qr.dart';
import 'package:gas_station_customer/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';

class StationProfile extends StatefulWidget {
  const StationProfile({Key? key}) : super(key: key);

  @override
  State<StationProfile> createState() => _StationProfileState();
}

class _StationProfileState extends State<StationProfile> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
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
                        borderRadius: const BorderRadius.all(Radius.circular(11.0))
                    ),
                    child: Image.asset(
                      'assets/images/station_profile.png',
                      width: MediaQuery.of(context).size.width * 0.37,
                    ),
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
                                    const Text(
                                      'Quick Stop Station',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    const Text(
                                      'Gas Station',
                                      style: TextStyle(color: AppColors.secondary),
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset('assets/icons/star.svg'),
                                        const SizedBox(width: 5.0),
                                        const Text(
                                          '4.5',
                                          style: TextStyle(color: AppColors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
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
                                      const Text(
                                        '3 KM',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
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
                        const Text(
                          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets.",
                          style: TextStyle(color: AppColors.secondary),
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
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "50% off on purchase",
                                  style: TextStyle(color: AppColors.black),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley.",
                                  style: TextStyle(color: AppColors.secondary),
                                ),
                                Divider(
                                  color: AppColors.secondary,
                                  thickness: 0.4,
                                ),
                                SizedBox(height: 10.0),
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
}
