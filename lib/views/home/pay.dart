import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_customer/views/home/success.dart';
import 'package:gas_station_customer/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';
class Pay extends StatefulWidget {
  const Pay({Key? key}) : super(key: key);

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/station_profile.png'),
                        maxRadius: 22.0,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Quick Stop Station',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          'Gas Station',
                          style: TextStyle(color: AppColors.secondary),
                        ),
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
                      const Expanded(
                        flex: 1,
                        child: Text('\$2000 USD',style: TextStyle(color: AppColors.primary),textAlign: TextAlign.right,),
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
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeftWithFade,
                  alignment: Alignment.topCenter,
                  duration: const Duration(milliseconds: 1000),
                  isIos: true,
                  child: const Success(),
                ),
              );
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
}
