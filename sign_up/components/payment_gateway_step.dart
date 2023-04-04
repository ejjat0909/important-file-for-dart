import 'dart:async';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:auf/constant.dart';
import 'package:auf/form_bloc/register_hero_form_bloc.dart';
import 'package:auf/public_components/input_decoration.dart';
import 'package:auf/public_components/space.dart';
import 'package:auf/public_components/theme_spinner.dart';

class PaymentGatewayStep extends StatefulWidget {
  int activeStepper;
  final String? billId;
  final ValueSetter<WebViewController> callBackSetWebViewController;

  PaymentGatewayStep({
    Key? key,
    required this.activeStepper,
    required this.billId,
    required this.callBackSetWebViewController,
  }) : super(key: key);

  @override
  State<PaymentGatewayStep> createState() => _PaymentGatewayStepState();
}

class _PaymentGatewayStepState extends State<PaymentGatewayStep> {
  int delayAnimationDuration = 200;
  late String url;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    url = runBillToyyibpayUrl + widget.billId!;
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
          widget.callBackSetWebViewController(webViewController);
        },
        onProgress: (int progress) {
          print('WebView is loading (progress : $progress%)');
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
        gestureNavigationEnabled: true,
        backgroundColor: kWhite,
      ),
    );
  }
}
