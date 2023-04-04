import 'dart:async';
import 'dart:io';
import 'package:animated_switcher_plus/animated_switcher_plus.dart';
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
import 'package:im_animations/im_animations.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:auf/constant.dart';
import 'package:auf/form_bloc/register_hero_form_bloc.dart';
import 'package:auf/form_bloc/registration_fee_form_bloc.dart';
import 'package:auf/public_components/input_decoration.dart';
import 'package:auf/public_components/space.dart';
import 'package:auf/public_components/theme_snack_bar.dart';
import 'package:auf/public_components/theme_spinner.dart';

class PayFeeRegistrationStep extends StatefulWidget {
  int activeStepper;
  String email;
  final ValueSetter<int> callBackChangeActiveStepper;
  final ValueSetter<RegistrationFeeFormBloc> callBackSetRegistrationFeeFormBloc;
  final ValueSetter<bool> callBackSetIsLoading;
  final ValueSetter<String?> callBackSetBillId;

  PayFeeRegistrationStep({
    Key? key,
    required this.activeStepper,
    required this.email,
    required this.callBackChangeActiveStepper,
    required this.callBackSetRegistrationFeeFormBloc,
    required this.callBackSetIsLoading,
    required this.callBackSetBillId,
  }) : super(key: key);

  @override
  State<PayFeeRegistrationStep> createState() => _PayFeeRegistrationStepState();
}

class _PayFeeRegistrationStepState extends State<PayFeeRegistrationStep> {
  int delayAnimationDuration = 200;
  String? afterDiscountValue = null;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: BlocProvider(
          create: (context) => RegistrationFeeFormBloc(widget.email, (value) {
            // Handle when discount update
            setState(() {
              afterDiscountValue = value;
            });
          }),
          child: Builder(builder: (context) {
            final RegistrationFeeFormBloc formBloc =
                BlocProvider.of<RegistrationFeeFormBloc>(context);

            widget.callBackSetRegistrationFeeFormBloc(formBloc);

            return FormBlocListener<RegistrationFeeFormBloc, String, String>(
              // On submit
              onSubmitting: (context, state) {
                // Remove focus from input field
                FocusScope.of(context).unfocus();
                // Set loading true
                widget.callBackSetIsLoading(true);
              },
              onSuccess: (context, state) {
                // Set loading false
                widget.callBackSetIsLoading(false);

                // Update bill id
                widget.callBackSetBillId(state.successResponse);

                // Navigate to show Payment Gateway UI
                widget.callBackChangeActiveStepper(6);
              },
              // Validation failed
              onSubmissionFailed: (context, state) {
                // Set loading false
                widget.callBackSetIsLoading(false);
              },
              onFailure: (context, state) {
                // Set loading to false
                widget.callBackSetIsLoading(false);

                ThemeSnackBar.showSnackBar(
                    context, state.failureResponse ?? "Server error");
                return;
              },
              child: Column(
                children: [
                  DelayedDisplay(
                    delay: Duration(milliseconds: delayAnimationDuration),
                    child: const Text(
                      "Registration Fee",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Space(100),
                  DelayedDisplay(
                    delay: Duration(milliseconds: delayAnimationDuration),
                    child: Center(
                      child: ColorSonar(
                        waveMotionEffect: Curves.easeInOut,
                        innerWaveColor: kPrimaryColor,
                        middleWaveColor: kPrimaryColor.withOpacity(0.5),
                        outerWaveColor: kPrimaryColor.withOpacity(0.2),
                        contentAreaColor: kPrimaryColor,
                        contentAreaRadius: 55.h,
                        child: AnimatedSwitcherTranslation.bottom(
                          duration: const Duration(milliseconds: 1500),
                          child: afterDiscountValue == null
                              // Design without discount
                              ? const Text(
                                  "RM 161.00",
                                  style: TextStyle(
                                    color: kTextWarning,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              // Design with discount
                              : Column(
                                  children: [
                                    Text(
                                      afterDiscountValue!,
                                      style: const TextStyle(
                                        color: kTextWarning,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "RM 161.00",
                                      style: TextStyle(
                                        color: kTextGray,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                  Space(100),
                  DelayedDisplay(
                    delay: Duration(milliseconds: delayAnimationDuration),
                    child: const Text(
                      "To activate your account, please pay the registration fee using Online Banking.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Space(30),
                  DelayedDisplay(
                    delay: Duration(milliseconds: delayAnimationDuration),
                    child: TextFieldBlocBuilder(
                      textFieldBloc: formBloc.discountCode,
                      asyncValidatingIcon: ThemeSpinner.spinnerInput(),
                      suffixButton: SuffixButton.asyncValidating,
                      cursorColor: kPrimaryColor,
                      decoration: textFieldInputDecoration(
                        "Discount Code",
                        hintText: "ex: DIS-00100",
                        prefixIcon: const Icon(
                          Iconsax.discount_circle,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
