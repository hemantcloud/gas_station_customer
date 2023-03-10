import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_customer/views/home/dashboard.dart';
import 'package:gas_station_customer/views/utilities/utilities.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:page_transition/page_transition.dart';
class Success extends StatefulWidget {
  const Success({Key? key}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  TextEditingController amountController = TextEditingController();
  late final _ratingController;
  late double _rating;
  double _userRating = 3.0;
  int _ratingBarMode = 2;
  double _initialRating = 5.0;
  bool _isRTLMode = false;
  bool _isVertical = false;
  IconData? _selectedIcon;
  var reviewController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: const Color(0xFFEEE7F6),
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: AppColors.white,
            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          toolbarHeight: 70.0,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primary,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
            child: Container(
              height: 60.0,
              // color: Colors.black,
              margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              // padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent, width: 0.0),
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Container(
                      width: 25.0,
                      height: 25.0,
                      child: SvgPicture.asset('assets/icons/left.svg',color: AppColors.white,),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            'Payment Successful',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0,
                              color: AppColors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '27 February 2023 at 21:52',
                            style: TextStyle(color: AppColors.white,fontSize: 10.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0,),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: AppColors.white,
            ),
            child: Column(
              children: [
                SvgPicture.asset('assets/icons/success.svg'),
                const Text(
                  'Transaction Completed Successfully',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: AppColors.black
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: const Color(0xFFF4F5F7),
                    // border: Border.all(
                    //   width: 1.0,
                    //   color: AppColors.border,
                    //   style: BorderStyle.solid,
                    // ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/station_image1.png',width: 100.0,),
                      const SizedBox(width: 10.0),
                      Expanded(
                        flex: 1,
                        child: Column(
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
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'What do you think ?',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: AppColors.black,
                      fontWeight: FontWeight.w600
                  ),
                ),
                const Text(
                  'please give your rating by clicking on\nthe stars below',
                  style: TextStyle(color: AppColors.secondary),
                  textAlign: TextAlign.center,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: _ratingBar(_ratingBarMode),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent, width: 0.0),
                    borderRadius: BorderRadius.circular(5.0),
                    color: const Color(0xFFF4F5F7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: reviewController,
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                              fontSize: 14.0,
                              color: AppColors.secondary,
                          ),
                          cursorColor: AppColors.primary,
                          decoration: const InputDecoration(
                            hintText: 'Write your comment',
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
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        alignment: Alignment.topCenter,
                        duration: const Duration(milliseconds: 1000),
                        isIos: true,
                        child: Dashboard(bottomIndex: 0),
                      ),
                      (route) => false,
                    );
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Container(
                    height: 55.0,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(19.0)),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Skip Rating',
                    style: TextStyle(color: AppColors.primary),
                    textAlign: TextAlign.center,
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
  Widget _ratingBar(int mode) {
    switch (mode) {
      case 1:
        return RatingBar.builder(
          initialRating: _initialRating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          unratedColor: Colors.amber.withAlpha(50),
          itemCount: 5,
          itemSize: 50.0,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            _selectedIcon ?? Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );
      case 2:
        return RatingBar(
          initialRating: _initialRating,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          ratingWidget: RatingWidget(
            full: _image('assets/icons/star.png'),
            half: _image('assets/icons/star.png'),
            // half: _image('assets/heart_half.png'), note-----------half image converted to full image
            empty: _image('assets/icons/star_empty.png'),
          ),
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );
      case 3:
        return RatingBar.builder(
          initialRating: _initialRating,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return const Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Colors.red,
                );
              case 1:
                return const Icon(
                  Icons.sentiment_dissatisfied,
                  color: Colors.redAccent,
                );
              case 2:
                return const Icon(
                  Icons.sentiment_neutral,
                  color: Colors.amber,
                );
              case 3:
                return const Icon(
                  Icons.sentiment_satisfied,
                  color: Colors.lightGreen,
                );
              case 4:
                return const Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.green,
                );
              default:
                return Container();
            }
          },
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );
      default:
        return Container();
    }
  }

  Widget _image(String asset) {
    return Image.asset(
      asset,
      height: 20.0,
      width: 20.0,
      color:
      asset == 'assets/icons/star.png' ?
      Colors.amber : const Color(0xFFC5C5C5),
    );
  }
}
