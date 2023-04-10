import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_customer/views/home/account.dart';
import 'package:gas_station_customer/views/home/home.dart';
import 'package:gas_station_customer/views/home/transactions.dart';
import 'package:gas_station_customer/views/home/wallet.dart';
import 'package:gas_station_customer/views/utilities/utilities.dart';
class Dashboard extends StatefulWidget {
  int bottomIndex;
  Dashboard({Key? key, required this.bottomIndex}) : super(key: key);
  @override
  State<Dashboard> createState() => _HomeState();
}
var widgetOptions = [
  const Home(),
  const Wallet(),
  const Transaction(),
  const Account(),
];


class _HomeState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {

    void _onItemTapped(int index) {
      setState(() {
        widget.bottomIndex = index;
        // print("index>>>>${_selectedIndex}");
      });
    }
    return Scaffold(
      body: widgetOptions[
      widget.bottomIndex
      ],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: widget.bottomIndex == 0 ?
              SvgPicture.asset('assets/icons/home.svg',width: 20.0,height: 20.0,color: AppColors.primary,) :
              SvgPicture.asset('assets/icons/home.svg',width: 20.0,height: 20.0,color: AppColors.secondary,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: widget.bottomIndex == 1 ?
            SvgPicture.asset('assets/icons/wallet.svg',width: 20.0,height: 20.0,color: AppColors.primary,) :
            SvgPicture.asset('assets/icons/wallet.svg',width: 20.0,height: 20.0,color: AppColors.secondary,),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: widget.bottomIndex == 2 ?
            SvgPicture.asset('assets/icons/transaction.svg',width: 20.0,height: 20.0,color: AppColors.primary,) :
            SvgPicture.asset('assets/icons/transaction.svg',width: 20.0,height: 20.0,color: AppColors.secondary,),
            label: 'Transaction',
          ),
          BottomNavigationBarItem(
            icon: widget.bottomIndex == 3 ?
            SvgPicture.asset('assets/icons/account.svg',width: 20.0,height: 20.0,color: AppColors.primary,) :
            SvgPicture.asset('assets/icons/account.svg',width: 20.0,height: 20.0,color: AppColors.secondary,),
            label: 'Account',
          ),
        ],
        currentIndex: widget.bottomIndex,
        elevation: 0.0,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.yellow,
        onTap: _onItemTapped,
      ),
    );
  }
}
