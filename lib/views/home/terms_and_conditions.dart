
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gas_station_customer/views/utilities/utilities.dart';

class TermAndCondition extends StatefulWidget {
  const TermAndCondition({Key? key}) : super(key: key);

  @override
  State<TermAndCondition> createState() => _TermAndConditionState();
}

class _TermAndConditionState extends State<TermAndCondition> {
  String? data = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Accumsan in nisl nisi scelerisque eu ultrices vitae. Iaculis eu non diam phasellus vestibulum lorem sed. Duis convallis convallis tellus id interdum velit laoreet id donec. Commodo quis imperdiet massa tincidunt nunc pulvinar.Lectus mauris ultrices eros in cursus. Id eu nisl nunc mi ipsum faucibus. Morbi tincidunt ornare massa eget egestas purus viverra accumsan in. Senectus et netus et malesuada fames ac turpis.Congue mauris rhoncus aenean vel elit scelerisque mauris. Et magnis dis parturient montes nascetur ridiculus. Ipsum dolor sit amet consectetur adipiscing elit duis tristique sollicitudin. Ultrices vitae auctor eu augue ut. Gravida neque convallis a cras semper auctor. Id diam maecenas ultricies mi eget mauris pharetra et. Volutpat commodo sed egestas egestas fringilla.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text('Terms & Condition',style: TextStyle(fontSize: 18.0,)),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            data == null || data == '' ? Container() : Html(
              data: data,
              style: {
                data.toString() : Style(
                    color: AppColors.secondary
                )
              },
            ),
          ],
        ),
      ),
    );
  }

}
