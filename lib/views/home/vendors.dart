import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_customer/views/home/vendors.dart';
import 'package:gas_station_customer/views/home/station_profile.dart';
import 'package:gas_station_customer/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';
class Vendors extends StatefulWidget {
  const Vendors({Key? key}) : super(key: key);

  @override
  State<Vendors> createState() => _VendorsState();
}

class _VendorsState extends State<Vendors> {
  List<Categories> categorieslist = [
    Categories(icon: 'assets/icons/gas_station2.svg', name: 'Gas Staion', bg: '#EEE9FF'),
    Categories(icon: 'assets/icons/health_and_fitness.svg', name: 'Health & Fitness', bg: '#FFE5DA'),
    Categories(icon: 'assets/icons/lifestyle.svg', name: 'Lifestyle', bg: '#F5FFD9'),
    Categories(icon: 'assets/icons/restaurant.svg', name: 'Restaurant', bg: '#D9FFDD'),
    Categories(icon: 'assets/icons/shopping.svg', name: 'Shopping', bg: '#FCD9FF'),
  ];
  TextEditingController searchController = TextEditingController();

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
                            child: TextFormField(
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
                      /*Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        alignment: Alignment.topCenter,
                        duration: const Duration(milliseconds: 1000),
                        isIos: true,
                        child: const Home(),
                      ),
                    );*/
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        alignment: Alignment.topCenter,
                        duration: const Duration(milliseconds: 1000),
                        isIos: true,
                        child: const StationProfile(),
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
                            Image.asset('assets/images/station_image1.png',width: 60.0,),
                            const SizedBox(width: 10.0),
                            Expanded(
                              flex: 1,
                              child: Column(
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
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 10.0,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.0),
                                // color: AppColors.disabledButtonColor,
                                color: AppColors.primary,
                              ),
                              child: const Text(
                                '3 KM',
                                style: TextStyle(
                                  color: Colors.white,
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
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
class Categories{
  String? icon;
  String? name;
  String? bg;
  Categories({required this.icon,required this.name,required this.bg});
}
