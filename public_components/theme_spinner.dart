import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeSpinner {
  static spinnerInput() {
    return SizedBox(
      height: 24.h,
      width: 24.h,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: SpinKitDoubleBounce(
          color: kPrimaryColor,
          size: 24,
        ),
      ),
    );
  }

  static spinner() {
    return SizedBox(
      height: 50.h,
      width: 50.h,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: SpinKitChasingDots(
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
