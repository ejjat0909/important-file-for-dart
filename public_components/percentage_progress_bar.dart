import 'package:auf/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PercentageProgressBar extends StatelessWidget {
  const PercentageProgressBar({
    Key? key,
    required this.salesPercentage,
    required this.nrqaPercentage,
  }) : super(key: key);

  final int salesPercentage;
  final int nrqaPercentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "Points",
              style: TextStyle(
                color: kDarkGrey,
                fontSize: 12.0,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: LinearProgressIndicator(
                  value: salesPercentage / 100,
                  minHeight: 10.0,
                  color: kPrimaryColor,
                  backgroundColor: const Color.fromRGBO(233, 233, 233, 1),
                  semanticsValue: "$salesPercentage%",
                ),
              ),
            ),
            const SizedBox(width: 5.0),
            Text(
              "$salesPercentage%",
              style: const TextStyle(
                color: kDarkGrey,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            const Text(
              "NRQA",
              style: TextStyle(
                color: kDarkGrey,
                fontSize: 12.0,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: LinearProgressIndicator(
                  value: nrqaPercentage / 100,
                  minHeight: 10.0,
                  color: kPrimaryColor,
                  backgroundColor: const Color.fromRGBO(233, 233, 233, 1),
                  semanticsValue: "$nrqaPercentage%",
                ),
              ),
            ),
            const SizedBox(width: 5.0),
            Text(
              "$nrqaPercentage%",
              style: const TextStyle(
                color: kDarkGrey,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
