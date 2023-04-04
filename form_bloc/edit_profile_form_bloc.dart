import 'dart:async';

import 'package:auf/bloc/user_bloc.dart';
import 'package:auf/constant.dart';
import 'package:auf/helpers/validators.dart';
import 'package:auf/models/default_response_model.dart';
import 'package:auf/models/user/bank_model.dart';
import 'package:auf/models/user/edit_profile_request_model.dart';
import 'package:auf/models/user/state_model.dart';
import 'package:auf/models/user/title_model.dart';
import 'package:auf/models/user/update_user_request_model.dart';
import 'package:auf/models/user/user_model.dart';
import 'package:auf/models/user/user_response_model.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:image_pickers/image_pickers.dart';

class EditProfileFormBloc extends FormBloc<UserModel, UserResponseModel> {
  UserBloc userBloc = new UserBloc();
  Media? newPhoto;

  final newAccountNumber = TextFieldBloc(
    validators: [
      InputValidator.required,
    ],
  );

  // Bank
  final bank = SelectFieldBloc<BankModel, dynamic>();

  final newName = TextFieldBloc(
    validators: [
      InputValidator.required,
      InputValidator.nameChar,
    ],
  );

  final title = SelectFieldBloc<TitleModel, dynamic>();

  final newAddress = TextFieldBloc(
    validators: [
      InputValidator.required,
    ],
  );

  // State
  final division = SelectFieldBloc<DivisionModel, dynamic>();

  // Phone Number
  final phoneNo = TextFieldBloc(
    validators: [
      InputValidator.required,
      InputValidator.phoneNo,
    ],
  );

  EditProfileFormBloc(UserModel userModel) {
    newAccountNumber.updateInitialValue(userModel.accountNumber!);
    bank.updateInitialValue(userModel.bankModel);
    newName.updateInitialValue(userModel.name!);

    newAddress.updateInitialValue(userModel.address!);

    phoneNo.updateInitialValue(userModel.phoneNo!);
    addFieldBlocs(fieldBlocs: [
      newAccountNumber,
      bank,
      newName,
      title,
      newAddress,
      division,
      phoneNo,
    ]);

    title.updateItems(listTitleModel);
    // Update the selected value
    for (TitleModel titleModel in listTitleModel) {
      if (titleModel.id == userModel.titleId) {
        title.updateInitialValue(titleModel);
      }
    }

    // Update Division Items
    division.updateItems(listDivisionModel);
    // Update the selected value
    for (DivisionModel divisionModel in listDivisionModel) {
      if (divisionModel.id == userModel.worldDivisionId) {
        division.updateInitialValue(divisionModel);
      }
    }

    // Update Bank Items
    bank.updateItems(listBankModel);
    // Update the selected value
    for (BankModel bankModel in listBankModel) {
      if (bankModel.id == userModel.bankModel!.id) {
        bank.updateInitialValue(bankModel);
      }
    }
  }

  @override
  Future<void> onSubmitting() async {
    try {
      EditProfileRequestModel requestModel = new EditProfileRequestModel();

      requestModel.accountNumber = newAccountNumber.value;
      requestModel.bankId = bank.value!.id.toString();
      requestModel.name = newName.value;
      requestModel.title = title.value!.id.toString();
      requestModel.address = newAddress.value;
      requestModel.worldDivisionId = division.value!.id.toString();
      requestModel.phoneNo = phoneNo.value;
      requestModel.photoPath = newPhoto;

      UserResponseModel responseModel =
          await userBloc.editProfile(requestModel);

      if (responseModel.isSuccess) {
        emitSuccess(successResponse: responseModel.data!);
      } else {
        emitFailure(failureResponse: responseModel.errors);
      }
    } catch (e) {
      emitFailure(failureResponse: null);
    }
  }
}
