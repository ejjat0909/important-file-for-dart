import 'package:auf/constant.dart';
import 'package:auf/form_bloc/register_hero_form_bloc.dart';
import 'package:auf/helpers/general_method.dart';
import 'package:auf/public_components/input_decoration.dart';
import 'package:auf/public_components/space.dart';
import 'package:auf/public_components/theme_spinner.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:iconsax/iconsax.dart';

class AccountDetailsStep extends StatefulWidget {
  final RegisterHeroFormBloc formBloc;
  AccountDetailsStep({super.key, required this.formBloc});

  @override
  State<AccountDetailsStep> createState() => _AccountDetailsStepState();
}

class _AccountDetailsStepState extends State<AccountDetailsStep> {
  int delayAnimationDuration = 200;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DelayedDisplay(
              delay: Duration(milliseconds: delayAnimationDuration),
              child: TextFieldBlocBuilder(
                textFieldBloc: widget.formBloc.referralCode,
                cursorColor: kPrimaryColor,
                asyncValidatingIcon: ThemeSpinner.spinnerInput(),
                suffixButton: SuffixButton.asyncValidating,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                decoration: textFieldInputDecoration(
                  "Referral Code",
                  hintText: "ex: AM00001",
                  prefixIcon: Icon(
                    Iconsax.profile_circle,
                    color: kPrimaryColor,
                  ),
                ),
              )),
          Space(10),
          DelayedDisplay(
              delay: Duration(milliseconds: delayAnimationDuration),
              child: TextFieldBlocBuilder(
                textFieldBloc: widget.formBloc.icNo,
                keyboardType: TextInputType.number,
                asyncValidatingIcon: ThemeSpinner.spinnerInput(),
                suffixButton: SuffixButton.asyncValidating,
                cursorColor: kPrimaryColor,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: textFieldInputDecoration(
                  "IC No (Optional)",
                  hintText: "ex: 010702020067",
                  prefixIcon: Icon(
                    Iconsax.personalcard,
                    color: kPrimaryColor,
                  ),
                ),
              )),
          Space(10),
          DelayedDisplay(
              delay: Duration(milliseconds: delayAnimationDuration),
              child: TextFieldBlocBuilder(
                textFieldBloc: widget.formBloc.email,
                asyncValidatingIcon: ThemeSpinner.spinnerInput(),
                suffixButton: SuffixButton.asyncValidating,
                cursorColor: kPrimaryColor,
                textCapitalization: TextCapitalization.none,
                inputFormatters: [
                  LowerCaseTextFormatter(),
                ],
                decoration: textFieldInputDecoration(
                  "Email",
                  hintText: "ex: example@aufmbz.com",
                  prefixIcon: Icon(Iconsax.sms, color: kPrimaryColor),
                ),
              )),
          Space(10),
          DelayedDisplay(
              delay: Duration(milliseconds: delayAnimationDuration),
              child: TextFieldBlocBuilder(
                textFieldBloc: widget.formBloc.phoneNo,
                keyboardType: TextInputType.number,
                asyncValidatingIcon: ThemeSpinner.spinnerInput(),
                suffixButton: SuffixButton.asyncValidating,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                cursorColor: kPrimaryColor,
                decoration: textFieldInputDecoration(
                  "Phone No (Optional)",
                  hintText: "ex: 0122165733",
                  prefixIcon: Icon(
                    Iconsax.call,
                    color: kPrimaryColor,
                  ),
                ),
              )),
          Space(10),
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: TextFieldBlocBuilder(
              textFieldBloc: widget.formBloc.password,
              cursorColor: kPrimaryColor,
              suffixButton: SuffixButton.obscureText,
              obscureTextTrueIcon: Icon(Iconsax.eye_slash),
              obscureTextFalseIcon: Icon(Iconsax.eye),
              decoration: textFieldInputDecoration(
                "Password",
                hintText: "Enter your password",
                prefixIcon: Icon(
                  Iconsax.lock,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          Space(10),
          DelayedDisplay(
              delay: Duration(milliseconds: delayAnimationDuration),
              child: TextFieldBlocBuilder(
                textFieldBloc: widget.formBloc.confirmPassword,
                cursorColor: kPrimaryColor,
                suffixButton: SuffixButton.obscureText,
                obscureTextTrueIcon: Icon(Iconsax.eye_slash),
                obscureTextFalseIcon: Icon(Iconsax.eye),
                decoration: textFieldInputDecoration(
                  "Confirm Password",
                  hintText: "Re-enter your password",
                  prefixIcon: Icon(Iconsax.lock_1, color: kPrimaryColor),
                ),
              )),
        ],
      ),
    );
  }
}
