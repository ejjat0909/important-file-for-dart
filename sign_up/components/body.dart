// import 'dart:ffi';
import 'package:auf/form_bloc/register_hero_form_bloc.dart';
import 'package:auf/form_bloc/registration_fee_form_bloc.dart';
import 'package:auf/models/user/user_model.dart';
import 'package:auf/screens/sign_up/components/account_details_step.dart';
import 'package:auf/screens/sign_up/components/bank_details_step.dart';
import 'package:auf/screens/sign_up/components/email_verify_step.dart';
import 'package:auf/screens/sign_up/components/pay_fee_registration_step.dart';
import 'package:auf/screens/sign_up/components/payment_gateway_step.dart';
import 'package:auf/screens/sign_up/components/user_details_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:webview_flutter/src/webview.dart';

import '../../../constant.dart';
import '../../../public_components/space.dart';

class Body extends StatefulWidget {
  // General
  int activeStepper;
  final ValueSetter<int> callBackSetActiveStepper;
  final UserModel? userModel;
  // For register hero tab (bank details step)
  final RegisterHeroFormBloc formBloc;
  // For payment gateway step
  final ValueChanged<WebViewController> callBackSetWebViewController;
  // For pay fee registration step
  final ValueChanged<RegistrationFeeFormBloc>
      callBackSetRegistrationFeeFormBloc;
  final ValueChanged<bool> callBackSetIsLoading;
  // For payment summary step
  final ValueGetter<String> callBackTransactionStatusValue;
  final ValueSetter<String?> callBackSetBillId;

  Body({
    super.key,
    required this.activeStepper,
    required this.formBloc,
    required this.callBackSetWebViewController,
    required this.userModel,
    required this.callBackSetActiveStepper,
    required this.callBackSetRegistrationFeeFormBloc,
    required this.callBackSetIsLoading,
    required this.callBackTransactionStatusValue,
    required this.callBackSetBillId,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int totalStepperCount = 6;
  int delayAnimationDuration = 200;
  String? billId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Step ${widget.activeStepper} of $totalStepperCount",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        fontFamily: "Poppins"),
                  ),
                ],
              ),
              Space(10),
              StepProgressIndicator(
                totalSteps: totalStepperCount,
                size: 6.0,
                currentStep: widget.activeStepper,
                selectedColor: kPrimaryColor,
                unselectedColor: kGrey.shade300,
                roundedEdges: const Radius.circular(20),
              ),
              Space(30),
            ],
          ),
          Expanded(child: componentSelector(widget.formBloc)),
        ],
      ),
    );
  }

  Widget componentSelector(RegisterHeroFormBloc formBloc) {
    // Account Details Step
    if (widget.activeStepper == 1) {
      return AccountDetailsStep(formBloc: formBloc);
      // User Details Step
    } else if (widget.activeStepper == 2) {
      return UserDetailsStep(formBloc: formBloc);
      // Bank Details Step
    } else if (widget.activeStepper == 3) {
      return BankDetailsStep(formBloc: formBloc);
      // Email Verify Step
    } else if (widget.activeStepper == 4) {
      return EmailVerifyStep(
        activeStepper: widget.activeStepper,
        userModel: widget.userModel ?? UserModel(email: formBloc.email.value),
        // To change the tab
        callBackSetActiveStepper: widget.callBackSetActiveStepper,
      );
      // Payment fee confirmation
    } else if (widget.activeStepper == 5) {
      return PayFeeRegistrationStep(
        activeStepper: widget.activeStepper,
        email: widget.userModel != null
            ? widget.userModel!.email!
            : formBloc.email.value,
        // To change the tab
        callBackChangeActiveStepper: widget.callBackSetActiveStepper,
        // To et the registration fee form bloc at sign up page
        // because the button to cubmit is at there
        callBackSetRegistrationFeeFormBloc:
            widget.callBackSetRegistrationFeeFormBloc,
        // To change either it is loading or not
        callBackSetIsLoading: widget.callBackSetIsLoading,

        callBackSetBillId: (String? value) {
          billId = value;
          widget.callBackSetBillId(value);
        },
      );
      // Payment Gateway UI
    } else if (widget.activeStepper == 6) {
      return PaymentGatewayStep(
        activeStepper: widget.activeStepper,
        callBackSetWebViewController: widget.callBackSetWebViewController,
        billId: billId,
      );
      // Registration Summary
    }
    return Space(0);
  }
}
