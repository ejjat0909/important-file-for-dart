import 'package:auf/constant.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onChange;
  final List<IconData> iconList;
  final List<String> tabName;

  CustomBottomNavigationBar(
      {required this.selectedIndex,
      required this.iconList,
      required this.onChange,
      required this.tabName});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _navBarItemList = [];
    //Get icon list and add into _navBarItemList
    for (var i = 0; i < widget.iconList.length; i++) {
      _navBarItemList
          .add(buildNavBarItem(widget.iconList[i], widget.tabName[i], i));
    }
    //Show item in icon in row inside bottom navigation bar
    return Row(
      children: _navBarItemList,
    );
  }

  //Update selected page's icon and update index for body content used
  Widget buildNavBarItem(IconData icon, String tabName, int index) {
    return GestureDetector(
      onTap: () {
        widget.onChange(index);
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width /
            widget
                .iconList.length, //Suitable for device size and number of icon
        decoration: index == widget.selectedIndex
            ? BoxDecoration(
                border: Border(
                  top: BorderSide(
                      width: 1,
                      color: kPrimaryColor), //Top border line for selected icon
                ),
                color: index == widget.selectedIndex
                    ? kBgSuccess //Color of selected background
                    : Colors.white,
              )
            : BoxDecoration(color: kWhite),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            index == 3
                ? Transform.rotate(
                    angle: 366,
                    child: Icon(
                      icon,
                      color: index == widget.selectedIndex
                          ? kPrimaryColor
                          : Colors.grey, //Color of selected icon
                    ),
                  )
                : Icon(
                    icon,
                    color: index == widget.selectedIndex
                        ? kPrimaryColor
                        : Colors.grey, //Color of selected icon
                  ),
            index == widget.selectedIndex
                ? Text(
                    tabName,
                    style: TextStyle(color: kPrimaryColor, fontSize: 12),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
