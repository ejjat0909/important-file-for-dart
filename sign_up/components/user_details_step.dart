import 'package:auf/constant.dart';
import 'package:auf/form_bloc/register_hero_form_bloc.dart';
import 'package:auf/models/user/state_model.dart';
import 'package:auf/models/user/title_model.dart';
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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';

class UserDetailsStep extends StatefulWidget {
  final RegisterHeroFormBloc formBloc;
  UserDetailsStep({super.key, required this.formBloc});

  @override
  State<UserDetailsStep> createState() => _UserDetailsStepState();
}

class _UserDetailsStepState extends State<UserDetailsStep> {
  int delayAnimationDuration = 200;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: DropdownFieldBlocBuilder<TitleModel>(
              showEmptyItem: false,
              selectFieldBloc: widget.formBloc.title,
              itemBuilder: (context, itemData) => FieldItem(
                child: DropdownMenuItem(
                  value: itemData.id,
                  child: Text(itemData.title!),
                ),
              ),
              decoration: textFieldInputDecoration(
                "Title",
                prefixIcon: Icon(
                  Iconsax.user,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          Space(10),
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: TextFieldBlocBuilder(
              textFieldBloc: widget.formBloc.name,
              keyboardType: TextInputType.name,
              cursorColor: kPrimaryColor,
              decoration: textFieldInputDecoration(
                "Name",
                hintText: "ex: Rolex Dilly",
                prefixIcon: Icon(
                  Iconsax.profile_circle,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          Space(10),
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: TextFieldBlocBuilder(
              textFieldBloc: widget.formBloc.address,
              cursorColor: kPrimaryColor,
              minLines: 1,
              maxLines: 5,
              decoration: textFieldInputDecoration(
                "Address",
                hintText: "ex: Lot 15, Kampung AUF, 16400",
                prefixIcon: Icon(
                  Iconsax.location,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          Space(10),
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: DropdownFieldBlocBuilder<DivisionModel>(
              showEmptyItem: false,
              selectFieldBloc: widget.formBloc.division,
              itemBuilder: (context, itemData) => FieldItem(
                child: DropdownMenuItem(
                  value: itemData.id,
                  child: Text(itemData.name!),
                ),
              ),
              decoration: textFieldInputDecoration(
                "State",
                prefixIcon: Icon(
                  FontAwesomeIcons.mapPin,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          Space(10),
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: TextFieldBlocBuilder(
              textFieldBloc: widget.formBloc.group,
              cursorColor: kPrimaryColor,
              decoration: textFieldInputDecoration(
                "Group",
                hintText: "ex: Group1 (Optional)",
                prefixIcon: Icon(
                  Iconsax.profile_circle,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
