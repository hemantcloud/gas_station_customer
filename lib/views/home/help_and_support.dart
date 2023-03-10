import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_customer/views/authentication/forgot_password.dart';
import 'package:gas_station_customer/views/authentication/register.dart';
import 'package:gas_station_customer/views/home/dashboard.dart';
import 'package:gas_station_customer/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        title: const Text('Help and Support',style: TextStyle(fontSize: 18.0,)),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.05,
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset('assets/images/help_and_support.png',width: MediaQuery.of(context).size.width * 0.4,),
            ),
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.1,bottom: 10.0),
              alignment: Alignment.center,
              child: const Text(
                'How can we help you',
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                style: TextStyle(
                    color: AppColors.secondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SvgPicture.asset(
                    'assets/images/call_us.svg',
                    height: 150.0,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SvgPicture.asset(
                    'assets/images/email_us.svg',
                    height: 150.0,
                  ),
                ),
              ],
            ),
            /*Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0F9FB),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
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
                  ),
                ),
              ],
            ),*/
          ],
        ),
      ),
    );
  }
}
