import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_customer/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';
const List<String> list = <String>[
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
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController address1controller = TextEditingController();
  TextEditingController address2controller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController zipcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController cpasswordcontroller = TextEditingController();
  bool _isHidden = false;
  bool _isHidden2 = false;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.1),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
            TextFormField(
              controller: namecontroller,
              cursorColor: AppColors.primary,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Full Name',
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
              controller: emailcontroller,
              cursorColor: AppColors.primary,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
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
                labelText: 'Address Line 2 *',
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
              controller: citycontroller,
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
            const SizedBox(height: 10.0),
            const Text(
              'State',
              style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0
              ),
            ),
            const SizedBox(height: 10.0),
            const DropdownButtonExample(),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: zipcontroller,
              cursorColor: AppColors.primary,
              keyboardType: TextInputType.streetAddress,
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
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: phonecontroller,
              cursorColor: AppColors.primary,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
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
              controller: passwordcontroller,
              obscureText: _isHidden == true ? true : false,
              cursorColor: AppColors.primary,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: 'Password',
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
              controller: cpasswordcontroller,
              obscureText: _isHidden2 == true ? true : false,
              cursorColor: AppColors.primary,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
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
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'I Agree to ',style: TextStyle(color: AppColors.black)),
                      TextSpan(
                          text: 'Terms of Services',
                          style: TextStyle(color: AppColors.primary,fontWeight: FontWeight.w600)
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
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
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(19.0)),
                ),
                child: const Text(
                  'Sign Up',
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
}
class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

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
