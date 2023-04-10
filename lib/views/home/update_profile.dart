import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_customer/models/profile_model.dart';
import 'package:gas_station_customer/models/update_profile_model.dart';
import 'package:gas_station_customer/views/home/change_password.dart';
import 'package:gas_station_customer/views/home/dashboard.dart';
import 'package:gas_station_customer/views/utilities/loader.dart';
import 'package:gas_station_customer/views/utilities/urls.dart';
import 'package:gas_station_customer/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';
// apis
import 'dart:async';
import 'dart:convert' as convert;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
// apis

class UpdateProfile extends StatefulWidget {
  Data userData;
  UpdateProfile({Key? key,required this.userData}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  late String authToken;
  late String userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
      allProcess();
    });
  }
  allProcess() async {
    setData();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      authToken = prefs.getString('authToken')!;
      userId = prefs.getString('userId')!;
      print('my auth token is >>>>> {$authToken}');
      print('my user id is >>>>> {$userId}');
    });
  }
  setData(){
    fullNameController.text = widget.userData.fullName!.isNotEmpty ? widget.userData.fullName! : '';
    emailController.text = widget.userData.email!.isNotEmpty ? widget.userData.email! : '';
    address1Controller.text = widget.userData.address1 == null ? '' : widget.userData.address1!.isNotEmpty ? widget.userData.address1! : '';
    address2Controller.text = widget.userData.address2 == null ? '' : widget.userData.address2!.isNotEmpty ? widget.userData.address2! : '';
    phoneController.text = widget.userData.mobileNumber!.isNotEmpty ? widget.userData.mobileNumber! : '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          title: const Text('Update Profile',style: TextStyle(fontSize: 18.0,)),
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
              Container(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.1),
                child: const Text(
                  'Update Profile',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 26.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              TextFormField(
                controller: fullNameController,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: emailController,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  // hintText: '••••••••',
                  // hintStyle: const TextStyle(color: AppColors.black),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: address1Controller,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Address 1 *',
                  labelStyle: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  // hintText: '••••••••',
                  // hintStyle: const TextStyle(color: AppColors.black),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: address2Controller,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Address 2 *',
                  labelStyle: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  // hintText: '••••••••',
                  // hintStyle: const TextStyle(color: AppColors.black),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: phoneController,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Phone number *',
                  labelStyle: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  counterText: "",
                  // hintText: '••••••••',
                  // hintStyle: const TextStyle(color: AppColors.black),
                ),
                maxLength: 10,
              ),
              const SizedBox(height: 10.0),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      alignment: Alignment.topCenter,
                      duration: const Duration(milliseconds: 1000),
                      isIos: true,
                      child: const ChangePassword(),
                    ),
                  );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: const Text(
                    'Change Password?',
                    style: TextStyle(color: AppColors.primary,fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              InkWell(
                onTap: () {
                  String name = fullNameController.text;
                  String email = emailController.text;
                  String phone = phoneController.text;
                  if(name.isEmpty){
                    Utilities().toast("Please enter full name");
                  } else if(email.isEmpty){
                    Utilities().toast('Please enter email ID');
                  } else if(!email.contains("@") || !email.contains(".com")){
                    Utilities().toast('Please enter valid email address');
                  } else if(phone.isEmpty){
                    Utilities().toast('Please enter email ID');
                  }else{
                    updateProfileApi(context);
                  }
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 55.0,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.all(Radius.circular(19.0)),
                  ),
                  child: const Text(
                    'Update',
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
    );
  }
  Future<void> updateProfileApi(BuildContext context) async {
    Loader.progressLoadingDialog(context, true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var request = {};
    request['full_name'] = fullNameController.text;
    request['email'] = emailController.text;
    request['address_1'] = address1Controller.text;
    request['address_2'] = address2Controller.text;
    request['country_code'] = "1";
    request['mobile_number'] = phoneController.text;
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Urls.updateProfile),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    UpdateProfileModel res = await UpdateProfileModel.fromJson(jsonResponse);
    if (res.status == true) {
      Utilities().toast(res.message);
      Navigator.of(context).pop();
      setState(() {});
    } else {
      Utilities().toast(res.message);
      setState(() {});
    }
    return;
  }
}
