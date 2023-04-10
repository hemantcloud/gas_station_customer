// ignore_for_file: use_build_context_synchronously

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_customer/models/submit_phone_model.dart';
import 'package:gas_station_customer/views/authentication/otp_verification_phone.dart';
import 'package:gas_station_customer/views/home/terms_and_conditions.dart';
import 'package:gas_station_customer/views/utilities/loader.dart';
import 'package:gas_station_customer/views/utilities/urls.dart';
import 'package:gas_station_customer/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;
// apis
import 'dart:async';
import 'dart:convert' as convert;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
// apis

const List<String> list = <String>[
  'Select State',
  'Alabama',
  'Alaska',
  'Arizona',
  'Arkansas',
  'California',
  'Colorado',
  'Connecticut',
  'Delaware',
  'Florida',
  'Georgia',
  'Hawaii',
  'Idaho',
  'Illinois',
  'Indiana',
  'Iowa',
  'Kansas',
  'Kentucky',
  'Louisiana',
  'Maine',
  'Maryland',
  'Massachusetts',
  'Michigan',
  'Minnesota',
  'Mississippi',
  'Missouri',
  'Montana',
  'Nebraska',
  'Nevada',
  'New Hampshire',
  'New Jersey',
  'New Mexico',
  'New York',
  'North Carolina',
  'North Dakota',
  'Ohio',
  'Oklahoma',
  'Oregon',
  'Pennsylvania',
  'Rhode Island',
  'South Carolina',
  'South Dakota',
  'Tennessee',
  'Texas',
  'Utah',
  'Vermont',
  'Virginia',
  'Washington',
  'West Virginia',
  'Wisconsin',
  'Wyoming',
];

const List<String> listF = <String>[
  'Daily',
  'Monthly',
  'Quarterly',
  'Yearly',
];
String dropdownValue = list.first;
String dropdownValueF = listF.first;
/*Alabama,
Alaska,
Arizona,
Arkansas,
California,
Colorado,
Connecticut,
Delaware,
Florida,
Georgia,
Hawaii,
Idaho,
Illinois,
Indiana,
Iowa,
Kansas,
Kentucky,
Louisiana,
Maine,
Maryland,
Massachusetts,
Michigan,
Minnesota,
Mississippi,
Missouri,
Montana,
Nebraska,
Nevada,
New Hampshire,
New Jersey,
New Mexico,
New York,
North Carolina,
North Dakota,
Ohio,
Oklahoma,
Oregon,
Pennsylvania,
Rhode Island,
South Carolina,
South Dakota,
Tennessee,
Texas,
Utah,
Vermont,
Virginia,
Washington,
West Virginia,
Wisconsin,
Wyoming,*/
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController address1controller = TextEditingController();
  TextEditingController address2controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  TextEditingController categoriesController = TextEditingController();
  bool _isHidden = false;
  bool _isHidden2 = false;
  bool _isChecked = false;
  String deviceType = '';
  String deviceId = '';
  String text = "Loading...";
  loc.LocationData? locationData;
  String? lat;
  String? long;
  String? fcmToken;
  String? timeZone;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
      allProcess();
    });
  }
  Future<void> allProcess() async {
    loadInfo();
    getPermission();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fcmToken = prefs.getString("fcmToken");
    print("fcmToken is ---------$fcmToken");
    getTimeZone();
  }
  Future getPermission() async {
    if (await Permission.location.isGranted) {
      getLatLong();
    } else {
      Permission.location.request();
    }
  }
  Future getLatLong() async {
    locationData = await loc.Location.instance.getLocation();
    lat = locationData!.latitude.toString();
    long = locationData!.longitude.toString();
    print('lat : ---------' + locationData!.latitude.toString());
    print('long : ---------' + locationData!.longitude.toString());
  }
  getTimeZone() async{
    timeZone = await FlutterNativeTimezone.getLocalTimezone();
    print("timeZone is -----------$timeZone");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.2,bottom: 10.0),
              alignment: Alignment.center,
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 26.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Center(
              child: SvgPicture.asset('assets/icons/gas_station.svg'),
            ),
            TextFormField(
              controller: nameController,
              cursorColor: AppColors.primary,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'Full Name *',
                labelStyle: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0
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
                labelText: 'Email *',
                labelStyle: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0
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
              controller: phoneController,
              cursorColor: AppColors.primary,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number *',
                labelStyle: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border),
                ),
                counterText: "",
              ),
              maxLength: 10,
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: address1controller,
              cursorColor: AppColors.primary,
              keyboardType: TextInputType.streetAddress,
              decoration: const InputDecoration(
                labelText: 'Address Line 1 *',
                labelStyle: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0
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
              controller: address2controller,
              cursorColor: AppColors.primary,
              keyboardType: TextInputType.streetAddress,
              decoration: const InputDecoration(
                labelText: 'Address Line 2',
                labelStyle: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0
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
              controller: cityController,
              textCapitalization: TextCapitalization.words,
              cursorColor: AppColors.primary,
              keyboardType: TextInputType.streetAddress,
              decoration: const InputDecoration(
                labelText: 'City *',
                labelStyle: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'State *',
              style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0
              ),
            ),
            const DropdownButtonExample(),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: zipController,
              cursorColor: AppColors.primary,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Zip Code *',
                labelStyle: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border),
                ),
                counterText: "",
              ),
              maxLength: 6,
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: passwordController,
              obscureText: _isHidden == true ? false : true,
              cursorColor: AppColors.primary,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: 'Password *',
                labelStyle: const TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border),
                ),
                // hintText: '••••••••',
                // hintStyle: const TextStyle(color: AppColors.black),
                suffixIcon: InkWell(
                  onTap: () {
                    _isHidden = !_isHidden;
                    setState(() {});
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: _isHidden == false
                      ? Image.asset('assets/icons/hide.png',color: AppColors.secondary)
                      : Image.asset('assets/icons/show.png',color: AppColors.secondary),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: cPasswordController,
              obscureText: _isHidden2 == true ? false : true,
              cursorColor: AppColors.primary,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: 'Confirm Password *',
                labelStyle: const TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border),
                ),
                // hintText: '••••••••',
                // hintStyle: const TextStyle(color: AppColors.black),
                suffixIcon: InkWell(
                  onTap: () {
                    _isHidden2 = !_isHidden2;
                    setState(() {});
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: _isHidden2 == false
                      ? Image.asset('assets/icons/hide.png',color: AppColors.secondary)
                      : Image.asset('assets/icons/show.png',color: AppColors.secondary),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _isChecked = !_isChecked;
                    });
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Container(
                    child: _isChecked == true ?
                    SvgPicture.asset('assets/icons/checked.svg') :
                    SvgPicture.asset('assets/icons/uncheck.svg'),
                  ),
                ),
                const SizedBox(width: 10.0),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: 'I Agree to ',style: TextStyle(color: AppColors.black)),
                      TextSpan(
                        text: 'Terms of Services',
                        style: const TextStyle(color: AppColors.primary,fontWeight: FontWeight.w600),
                        recognizer: TapGestureRecognizer()..onTap = () => {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const TermAndCondition()),
                          )
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            InkWell(
              onTap: () async {
                String name = nameController.text;
                String email = emailController.text;
                String phone = phoneController.text;
                String address1 = address1controller.text;
                String city = cityController.text;
                String zip = zipController.text;
                String pass = passwordController.text;
                String cPass = cPasswordController.text;
                // RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                if(name.isEmpty){
                  Utilities().toast('Please enter name');
                } else if(email.isEmpty){
                  Utilities().toast('Please enter email ID');
                } else if(!email.contains("@gmail.com")){
                  Utilities().toast('Please enter valid email address');
                } else if(phone.isEmpty){
                  Utilities().toast('Please enter Phone number');
                } else if(phone.length < 10){
                  Utilities().toast('Please enter valid Phone number');
                } else if(address1.isEmpty){
                  Utilities().toast('Please enter Address Line 1');
                } else if(city.isEmpty){
                  Utilities().toast('Please enter city');
                } else if(dropdownValue == "Select State"){
                  Utilities().toast('Please Select State');
                } else if(dropdownValueF == ""){
                  Utilities().toast('Please Select Withdrawal Frequency');
                } else if(zip.isEmpty){
                  Utilities().toast('Please enter zip code');
                } else if(pass.isEmpty){
                  Utilities().toast('Please enter password');
                } else if(pass.length < 6){
                  Utilities().toast('Please enter strong password');
                } else if(cPass.isEmpty){
                  Utilities().toast('Please enter confirm password');
                } else if(cPass.length < 6){
                  Utilities().toast('Please enter confirm strong password');
                } else if(pass != cPass){
                  Utilities().toast('Password must be same as above');
                } else if(!_isChecked){
                  Utilities().toast('Please agree the terms of services');
                }else {
                  if(lat == null && long == null){
                    getPermission();
                  // }else if(await Permission.location.isPermanentlyDenied || await Permission.location.isRestricted || await Permission.location.isDenied) {
                  //   Utilities().toast('Please Enable location to continue.');
                  }else{
                    submitPhoneApi(context);
                    // waitingAlert(context);
                  }
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
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Already have an account? ',style: TextStyle(color: AppColors.black)),
                      TextSpan(
                          text: 'Login',
                          style: TextStyle(color: AppColors.primary)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  /// loads device info
  void loadInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      // e.g. "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:61.0) Gecko/20100101 Firefox/61.0"
      print('Web - Running on ${webBrowserInfo.userAgent}');
      setState(() {
        text = webBrowserInfo.toMap().toString();
      });
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('iOS - Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"
      deviceId = iosInfo.model.toString();
      deviceType = 'ios';
      setState(() {
        text = iosInfo.toMap().toString();
      });
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      /*print('Android - Running on ${androidInfo.id}'); // e.g. "Moto G (4)"
      print('androidInfo.model -------${androidInfo.model}');
      print('androidInfo.type -------${androidInfo.type}');
      print('androidInfo.device -------${androidInfo.device}');
      print('androidInfo.board -------${androidInfo.board}');
      print('androidInfo.bootloader -------${androidInfo.bootloader}');
      print('androidInfo.brand -------${androidInfo.brand}');
      print('androidInfo.display -------${androidInfo.display}');
      print('androidInfo.fingerprint -------${androidInfo.fingerprint}');
      print('androidInfo.hardware -------${androidInfo.hardware}');
      print('androidInfo.host -------${androidInfo.host}');
      print('androidInfo.isPhysicalDevice -------${androidInfo.isPhysicalDevice}');
      print('androidInfo.manufacturer -------${androidInfo.manufacturer}');
      print('androidInfo.product -------${androidInfo.product}');
      print('androidInfo.tags -------${androidInfo.tags}');*/
      deviceId = androidInfo.id;
      print("deviceid is ---------------$deviceId");
      deviceType = 'android';
      print("devicetype is ---------------$deviceType");
      setState(() {
        text = androidInfo.toMap().toString();
      });
    } else if (Platform.isWindows) {
      WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
      print(windowsInfo.toMap().toString());
      setState(() {
        text = windowsInfo.toMap().toString();
      });
    } else if (Platform.isMacOS) {
      MacOsDeviceInfo macOSInfo = await deviceInfo.macOsInfo;
      print(macOSInfo.toMap().toString());
      setState(() {
        text = macOSInfo.toMap().toString();
      });
    } else if (Platform.isLinux) {
      LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
      print(linuxInfo.toMap().toString());
      setState(() {
        text = linuxInfo.toMap().toString();
      });
    }
  }
  // submitContactNumberApi api
  Future<void> submitPhoneApi(BuildContext context) async {
    Loader.progressLoadingDialog(context, true);
    var request = {};
    request['country_code'] = "91";
    request['mobile_number'] = phoneController.text;
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Urls.submitPhone),
        body: convert.jsonEncode(request),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-CLIENT": Urls.x_client_token,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    SubmitPhoneModel res = await SubmitPhoneModel.fromJson(jsonResponse);
    if (res.status == true) {
      Utilities().toast(res.message.toString());
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          alignment: Alignment.topCenter,
          duration: const Duration(milliseconds: 1000),
          isIos: true,
          child: OtpVerificationPhone(
              fullName: nameController.text,
              countryCode: "91",
              mobileNumber: phoneController.text,
              email: emailController.text,
              password: passwordController.text,
              cPassword: cPasswordController.text,
              address1: address1controller.text,
              address2: address2controller.text,
              city: cityController.text,
              state: dropdownValue,
              zip: zipController.text,
              deviceType: deviceType,
              deviceId: deviceId,
              fcmToken: fcmToken!,
              timezone: timeZone!,
              lat: lat!,
              long: long!
          ),
        ),
      );
      setState(() {});
    } else {
      Utilities().toast(res.message.toString());
      setState(() {});
    }
    return;
  }
// submitContactNumberApi api
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownValue,
      icon: SvgPicture.asset('assets/icons/down.svg',width: 20.0),
      elevation: 16,
      style: const TextStyle(color: AppColors.black,fontSize: 16.0,fontFamily: 'Poppins'),
      underline: Container(
        height: 1,
        color: AppColors.border,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class DropdownButtonExampleF extends StatefulWidget {
  const DropdownButtonExampleF({super.key});

  @override
  State<DropdownButtonExampleF> createState() => _DropdownButtonExampleFState();
}

class _DropdownButtonExampleFState extends State<DropdownButtonExampleF> {

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownValueF,
      icon: SvgPicture.asset('assets/icons/down.svg',width: 20.0),
      elevation: 16,
      style: const TextStyle(color: AppColors.black,fontSize: 16.0,fontFamily: 'Poppins'),
      underline: Container(
        height: 1,
        color: AppColors.border,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValueF = value!;
        });
      },
      items: listF.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
