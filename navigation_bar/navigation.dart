import 'package:auf/bloc/user_bloc.dart';
import 'package:auf/constant.dart';
import 'package:auf/helpers/general_method.dart';
import 'package:auf/providers/user_data_notifier.dart';
import 'package:auf/screens/dashboard/dashboard.dart';
import 'package:auf/screens/downline/downline_screen.dart';
import 'package:auf/screens/navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:auf/screens/product/product_screen.dart';
import 'package:auf/screens/profile/profile.dart';
import 'package:auf/screens/report/report.dart';
import 'package:auf/screens/sales/sales_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Navigation extends StatefulWidget {
  static const routeName = '/navigation';
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  final _pageController = PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // check access token either valid or not
    WidgetsBinding.instance.addPostFrameCallback((_) => checkAccessToken());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //callback function when back button is pressed
        return showExitAppPopup(context);
      },
      child: Scaffold(
        backgroundColor: kBgColor,
        bottomNavigationBar: CustomBottomNavigationBar(
          iconList: [
            Icons.home_outlined,
            Icons.document_scanner_rounded,
            FontAwesomeIcons.boxOpen,
            Icons.share,
            Icons.person,
          ],
          tabName: [
            "Home",
            "Report",
            "Product",
            "Downlines",
            "Profile",
          ],
          onChange: (index) {
            _pageController.jumpToPage(index);
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedIndex: _selectedIndex,
        ),
        // bottomNavigationBar: StylishBottomBar(
        //   padding: EdgeInsets.symmetric(vertical: 10),
        //   items: [
        //     BubbleBarItem(
        //       icon: Icon(
        //         FontAwesomeIcons.house,
        //         color: Colors.grey,
        //         size: 25,
        //       ),
        //       backgroundColor: kBgSuccess,
        //       activeIcon: Icon(
        //         FontAwesomeIcons.house,
        //         color: kPrimaryColor,
        //         size: 25,
        //       ),
        //       title: Text(
        //         'Home',
        //         style: TextStyle(color: kPrimaryColor),
        //       ),
        //     ),
        //     BubbleBarItem(
        //       icon: Icon(
        //         FontAwesomeIcons.file,
        //         color: Colors.grey,
        //         size: 25,
        //       ),
        //       backgroundColor: kBgSuccess,
        //       activeIcon: Icon(
        //         FontAwesomeIcons.solidFile,
        //         color: kPrimaryColor,
        //         size: 25,
        //       ),
        //       title: Text(
        //         'Report',
        //         style: TextStyle(color: kPrimaryColor),
        //       ),
        //     ),
        //     BubbleBarItem(
        //       icon: Icon(
        //         FontAwesomeIcons.dollarSign,
        //         color: Colors.grey,
        //         size: 25,
        //       ),
        //       backgroundColor: kBgSuccess,
        //       activeIcon: Icon(
        //         FontAwesomeIcons.dollarSign,
        //         color: kPrimaryColor,
        //         size: 25,
        //       ),
        //       title: Text(
        //         'Sales',
        //         style: TextStyle(color: kPrimaryColor),
        //       ),
        //     ),
        //     BubbleBarItem(
        //       icon: Icon(
        //         Icons.share_outlined,
        //         color: Colors.grey,
        //         size: 25,
        //       ),
        //       backgroundColor: kBgSuccess,
        //       activeIcon: Icon(
        //         Icons.share,
        //         color: kPrimaryColor,
        //         size: 25,
        //       ),
        //       title: Text(
        //         'Downlines',
        //         style: TextStyle(color: kPrimaryColor),
        //       ),
        //     ),

        //   ],
        //   iconSize: 32,
        //   barAnimation: BarAnimation.liquid,
        //   iconStyle: IconStyle.animated,
        //   currentIndex: _currentPage,
        //   onTap: (index) {
        //     _pageController.jumpToPage(index!);
        //     setState(() {
        //       _currentPage = index;
        //     });
        //   },
        // ),

        //Body content of selected option from navigation bar
        body: PageView(
          controller: _pageController,
          children: const [
            Dashboard(),
            Report(),
            ProductScreen(),
            DownlineScreen(),
            Profile(),
          ],
          onPageChanged: (index) {
            // Use a better state management solution
            // setState is used for simplicity
            setState(() => _selectedIndex = index);
          },
        ),
      ),
    );
  }

  void checkAccessToken() async {
    UserBloc userBloc = UserBloc();
    await userBloc.me(context);
  }
}
