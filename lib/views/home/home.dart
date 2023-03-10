import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_customer/views/home/qr.dart';
import 'package:gas_station_customer/views/home/vendors.dart';
import 'package:gas_station_customer/views/home/notification.dart';
import 'package:gas_station_customer/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Categories> categorieslist = [
    Categories(icon: 'assets/icons/gas_station2.svg', name: 'Gas Staion', bg: '#EEE9FF'),
    Categories(icon: 'assets/icons/health_and_fitness.svg', name: 'Health & Fitness', bg: '#FFE5DA'),
    Categories(icon: 'assets/icons/lifestyle.svg', name: 'Lifestyle', bg: '#F5FFD9'),
    Categories(icon: 'assets/icons/restaurant.svg', name: 'Restaurant', bg: '#D9FFDD'),
    Categories(icon: 'assets/icons/shopping.svg', name: 'Shopping', bg: '#FCD9FF'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        // toolbarHeight: 60.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 0.0),
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
                          child: const Text(
                            '\$2000',
                            style: TextStyle(color: AppColors.primary),
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
                const SizedBox(width: 10.0),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        alignment: Alignment.topCenter,
                        duration: const Duration(milliseconds: 1000),
                        isIos: true,
                        child: const NotificationScreen(),
                      ),
                    );
                  },
                  child: SvgPicture.asset('assets/icons/bell.svg'),
                ),
              ],
            ),
          ),
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2/2,
                childAspectRatio: 8/9,
              ),
              itemCount: categorieslist.length,
              itemBuilder: (BuildContext context, int index) {
                final splitted = categorieslist[index].bg!.split('#');
                String color = '0xFF${splitted[1].toLowerCase()}';
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        alignment: Alignment.topCenter,
                        duration: const Duration(milliseconds: 1000),
                        isIos: true,
                        child: const Vendors(),
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
                            decoration: BoxDecoration(
                                color:  Color(int.parse(color)),
                                shape: BoxShape.circle
                            ),
                            child: SvgPicture.asset(
                              categorieslist[index].icon.toString(),
                              width: 58.0,
                              height: 58.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 10.0,),
                          Text(
                            categorieslist[index].name.toString(),
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
          ],
        ),
      ),
      // extendBodyBehindAppBar: true,
    );
  }
}
class Categories{
  String? icon;
  String? name;
  String? bg;
  Categories({required this.icon,required this.name,required this.bg});
}
