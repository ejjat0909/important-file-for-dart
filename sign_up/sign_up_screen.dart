import 'dart:io';
import 'package:auf/bloc/user_bloc.dart';
import 'package:auf/form_bloc/register_hero_form_bloc.dart';
import 'package:auf/form_bloc/registration_fee_form_bloc.dart';
import 'package:auf/helpers/general_method.dart';
import 'package:auf/models/default_response_model.dart';
import 'package:auf/models/user/user_model.dart';
import 'package:auf/public_components/button_primary.dart';
import 'package:auf/public_components/custom_dialog.dart';
import 'package:auf/public_components/space.dart';
import 'package:auf/public_components/theme_app_bar.dart';
import 'package:auf/public_components/theme_snack_bar.dart';
import 'package:auf/screens/sign_in/sign_in_screen.dart';
import 'package:auf/screens/sign_up/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constant.dart';

class SignUpScreen extends StatefulWidget {
  int activeStepper;
  final UserModel? userModel;
  SignUpScreen({super.key, this.activeStepper = 1, this.userModel});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String transactionStatus = TransactionStatus.pending;
  bool _isLoading = false;
  WebViewController? webViewController;
  late AnimationController _controller;
  RegisterHeroFormBloc? formBloc;
  RegistrationFeeFormBloc? registrationFeeFormBloc;
  String? billId;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //callback function when back button is pressed
        return showCancelRegistrationPopup(context);
      },
      child: Scaffold(
        backgroundColor: kWhite,
        key: scaffoldKey,
        appBar: ThemeAppBar(
          "Registration",
          onBackPressed: () async {
            //callback function when back button is pressed
            if (await showCancelRegistrationPopup(context)) {
              Navigator.of(context).pop();
            }
          },
        ),
        bottomNavigationBar: // Button Continue
            Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
          // Button will only not available if at verify email step
          child: widget.activeStepper != 4
              ? Row(
                  children: [
                    prefixButtonWidget(),
                    Expanded(
                      child: ButtonPrimary(
                        getButtonText(),
                        onPressed: () {
                          handleButtonOnPressed.call();
                        },
                        isLoading: _isLoading,
                        loadingText: getLoadingText(),
                      ),
                    ),
                  ],
                )
              : null,
        ),
        body: BlocProvider(
          create: (context) => RegisterHeroFormBloc(),
          child: Builder(builder: (context) {
            // If formbloc null the initialize
            formBloc ??= BlocProvider.of<RegisterHeroFormBloc>(context);
            return FormBlocListener<RegisterHeroFormBloc, String, String>(
              // On submit
              onSubmitting: (context, state) {
                // Remove focus from input field
                FocusScope.of(context).unfocus();
                // Set loading true
                setState(() {
                  _isLoading = true;
                });
              },
              onSuccess: (context, state) {
                // Set loading false
                setState(() {
                  _isLoading = false;
                  widget.activeStepper = 4;
                });
              },
              // Validation failed
              onSubmissionFailed: (context, state) {
                // Set loading false
                setState(() {
                  _isLoading = false;
                });
              },
              onFailure: (context, state) {
                // Set loading to false
                setState(() {
                  _isLoading = false;
                });

                ThemeSnackBar.showSnackBar(
                    context, state.failureResponse ?? "");
                return;
              },
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Body(
                  activeStepper: widget.activeStepper,
                  formBloc: formBloc!,
                  userModel: widget.userModel,
                  callBackTransactionStatusValue: () {
                    return transactionStatus;
                  },
                  callBackSetWebViewController: (WebViewController wb) {
                    // Set the web view controller
                    webViewController = wb;
                  },
                  callBackSetActiveStepper: (int as) {
                    // Change tab
                    setState(() {
                      widget.activeStepper = as;
                    });
                  },
                  callBackSetRegistrationFeeFormBloc: (value) {
                    // if null then assign value
                    registrationFeeFormBloc ??= value;
                  },
                  callBackSetIsLoading: (bool value) {
                    // Change loading state
                    setState(() {
                      _isLoading = value;
                    });
                  },
                  callBackSetBillId: (String? value) {
                    billId = value;
                  },
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  handleButtonOnPressed() async {
    // Account Details Step
    if (widget.activeStepper == 1) {
      // Validate all inputs here
      if (await formBloc!.referralCode.validate() &&
          await formBloc!.icNo.validate() &&
          await formBloc!.email.validate() &&
          await formBloc!.phoneNo.validate() &&
          await formBloc!.password.validate() &&
          await formBloc!.password.validate() &&
          await formBloc!.confirmPassword.validate()) {
        // Go to next step

        setState(() {
          widget.activeStepper = 2;
        });
      }

      // User Details Step
    } else if (widget.activeStepper == 2) {
      // Validate all inputs here
      if (await formBloc!.title.validate() &&
          await formBloc!.name.validate() &&
          await formBloc!.address.validate() &&
          await formBloc!.division.validate()) {
        // Go to next step
        setState(() {
          widget.activeStepper = 3;
        });
      }
    } else if (widget.activeStepper == 3) {
      // if active stepper is 3, means the button is already register button,
      // so submit the form
      return formBloc!.submit();

      // If active stepper is 5, means the button is Proceed Payment,
      //so submit the payment form form bloc
    } else if (widget.activeStepper == 5) {
      return registrationFeeFormBloc!.submit();

      // Go to next step to show Payment Gateway UI
    } else if (widget.activeStepper == 6) {
      // Get url from the payment gateway url
      String? url = await webViewController?.currentUrl();

      if (url != null) {
        var uri = Uri.dataFromString(url); //converts string to a uri
        // Get status from the params
        Map<String, String> params =
            uri.queryParameters; // query parameters automatically populated
        transactionStatus = params['status_id'] ?? TransactionStatus.fail;
      }

      if (transactionStatus == TransactionStatus.success) {
        CustomDialog.show(
          context,
          dismissOnTouchOutside: false,
          title: "Payment Success",
          description:
              "Thank you; your payment was received successfully, and your account has been made active. You may log in now.",
          btnOkText: "Okay",
          btnOkOnPress: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (c) => SignInScreen()),
                (route) => false);
          },
          icon: Iconsax.check,
          dialogType: DialogType.success,
        );
      } else {
        CustomDialog.show(
          context,
          dismissOnTouchOutside: false,
          title: "Payment Failed",
          description: "Your payment is failed, please try again.",
          btnOkText: "Okay",
          btnOkOnPress: () => Navigator.of(context).pop(),
          icon: FontAwesomeIcons.exclamation,
          dialogType: DialogType.danger,
        );
      }
    }
  }

  String getButtonText() {
    if (widget.activeStepper == 1 || widget.activeStepper == 2) {
      return "Next";
    } else if (widget.activeStepper == 3) {
      return "Register";
    } else if (widget.activeStepper == 5) {
      return "Proceed Payment";
    } else if (widget.activeStepper == 6) {
      return "Validate Payment";
    }
    return "";
  }

  getLoadingText() {
    if (widget.activeStepper == 3) {
      return "Registering...";
    } else if (widget.activeStepper == 5) {
      return "Generating Bill...";
    } else if (widget.activeStepper == 6) {
      return "Validating Payment...";
    }
    return "";
  }

  Widget prefixButtonWidget() {
    // If at account details or user details step, show back button
    if (widget.activeStepper == 2 || widget.activeStepper == 3) {
      return Container(
        width: 60,
        child: ScaleTap(
          onPressed: () {
            setState(() {
              widget.activeStepper--;
            });
          },
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Iconsax.undo,
            ),
          ),
        ),
      );
      // If at payment gateway step, show refresh button
    } else if (widget.activeStepper == 6) {
      return Container(
        width: 60,
        child: ScaleTap(
          onPressed: () async {
            if (billId != null) {
              _controller.forward();
              webViewController?.loadUrl(runBillToyyibpayUrl + billId!);
              await Future.delayed(const Duration(seconds: 2));
              _controller.reset();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: RotationTransition(
              turns: Tween(begin: 7.0, end: 0.0).animate(_controller),
              child: const Icon(
                Iconsax.refresh,
              ),
            ),
          ),
        ),
      );
    }

    return Space(0);
  }
}
