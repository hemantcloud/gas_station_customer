import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_customer/views/forgot_password.dart';
import 'package:gas_station_customer/views/register.dart';
import 'package:gas_station_customer/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  String phone = '9685326984';
  String mail = 'hemantcloudwapp@gmail.com';
  String select = 'phone';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
          child: SvgPicture.asset('assets/icons/left.svg'),
        ),
        toolbarHeight: 50.0,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.3,
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SvgPicture.asset('assets/icons/gas_station.svg'),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.1),
              child: const Text(
                'Forgot Password',
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.05),
              child: const Text(
                'Select credential which should we use to recover your password.',
                style: TextStyle(color: AppColors.secondary2),
                textAlign: TextAlign.start,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  select = 'phone';
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: AppColors.secondary3,
                ),
                child: Row(
                  children: [
                    select == 'phone' ?
                    SvgPicture.asset('assets/icons/selected.svg') :
                    SvgPicture.asset('assets/icons/unselected.svg'),
                    SizedBox(width: 10.0),
                    SvgPicture.asset('assets/icons/phone.svg'),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        'XXX XXX ${phone.substring(6,10)}',
                        style: TextStyle(color: AppColors.black,fontSize: 16.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            InkWell(
              onTap: () {
                setState(() {
                  select = 'mail';
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: AppColors.secondary3,
                ),
                child: Row(
                  children: [
                    select == 'mail' ?
                    SvgPicture.asset('assets/icons/selected.svg') :
                    SvgPicture.asset('assets/icons/unselected.svg'),
                    SizedBox(width: 10.0),
                    SvgPicture.asset('assets/icons/mail.svg'),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        '****${mail.substring(mail.length - 15)}',
                        style: TextStyle(color: AppColors.black,fontSize: 16.0),
                      ),
                    )
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
                    child: const ForgotPassword(),
                  ),
                );*/
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                height: 55.0,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(19.0)),
                ),
                child: const Text(
                  'Send OTP',
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
    );
  }
}
