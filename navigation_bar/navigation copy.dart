import 'package:auf/bloc/user_bloc.dart';
import 'package:auf/constant.dart';
import 'package:auf/helpers/general_method.dart';
import 'package:auf/screens/dashboard/dashboard.dart';
import 'package:auf/screens/downline/downline_screen.dart';
import 'package:auf/screens/navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:auf/screens/profile/profile.dart';
import 'package:auf/screens/report/report.dart';
import 'package:flutter/material.dart';

class NavigationOld extends StatefulWidget {
  static const routeName = '/navigation';
  @override
  _NavigationOldState createState() => _NavigationOldState();
}

class _NavigationOldState extends State<NavigationOld> {
  int _selectedItem = 0;
  //Options or page show in body when selected
  static const List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Report(),
    DownlineScreen(),
    Profile(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // check access token either valid or not
    checkAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //callback function when back button is pressed
        return showExitAppPopup(context);
      },
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(
          iconList: [
            Icons.home_outlined,
            Icons.document_scanner_rounded,
            Icons.share,
            Icons.person,
          ],
          tabName: [
            "Dashboard",
            "Report",
            "Downlines",
            "Profile",
          ],
          onChange: (val) {
            setState(() {
              _selectedItem = val;
            });
          },
          selectedIndex: 0,
        ),
        //Body content of selected option from navigation bar
        body: Center(
          child: _widgetOptions.elementAt(_selectedItem),
        ),
      ),
    );
  }

  void checkAccessToken() async {
    UserBloc userBloc = UserBloc();
    await userBloc.me(context);
  }
}
