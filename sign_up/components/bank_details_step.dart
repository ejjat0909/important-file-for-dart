import 'package:auf/constant.dart';
import 'package:auf/form_bloc/register_hero_form_bloc.dart';
import 'package:auf/models/user/bank_model.dart';
import 'package:auf/public_components/input_decoration.dart';
import 'package:auf/public_components/space.dart';
import 'package:auf/public_components/theme_spinner.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:iconsax/iconsax.dart';

class BankDetailsStep extends StatefulWidget {
  final RegisterHeroFormBloc formBloc;
  BankDetailsStep({super.key, required this.formBloc});

  @override
  State<BankDetailsStep> createState() => _BankDetailsStepState();
}

class _BankDetailsStepState extends State<BankDetailsStep> {
  int delayAnimationDuration = 200;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: DropdownFieldBlocBuilder<BankModel>(
              showEmptyItem: false,
              selectFieldBloc: widget.formBloc.bank,
              itemBuilder: (context, itemData) => FieldItem(
                child: DropdownMenuItem(
                  value: itemData.id,
                  child: Text(itemData.name!),
                ),
              ),
              decoration: textFieldInputDecoration(
                "Bank",
                prefixIcon: Icon(
                  Iconsax.bank,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          Space(10),
          DelayedDisplay(
              delay: Duration(milliseconds: delayAnimationDuration),
              child: TextFieldBlocBuilder(
                textFieldBloc: widget.formBloc.accountNo,
                keyboardType: TextInputType.number,
                cursorColor: kPrimaryColor,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: textFieldInputDecoration(
                  "Account No",
                  hintText: "ex: 0102273830938",
                  prefixIcon: Icon(
                    Iconsax.card,
                    color: kPrimaryColor,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
