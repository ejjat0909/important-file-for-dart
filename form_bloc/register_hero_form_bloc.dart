import 'package:auf/bloc/user_bloc.dart';
import 'package:auf/helpers/validators.dart';
import 'package:auf/models/default_response_model.dart';
import 'package:auf/models/registration/register_hero_request_model.dart';
import 'package:auf/models/user/bank_model.dart';
import 'package:auf/models/user/state_model.dart';
import 'package:auf/models/user/title_model.dart';
import 'package:auf/models/user/user_model.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class RegisterHeroFormBloc extends FormBloc<String, String> {
  // Initialize Bloc
  final UserBloc userBloc = UserBloc();

  // Name
  final name = TextFieldBloc(
    validators: [
      InputValidator.required,
      InputValidator.nameChar,
    ],
  );

  // Name
  final referralCode = TextFieldBloc(
    validators: [
      InputValidator.required,
    ],
  );

  // Phone Number
  final phoneNo = TextFieldBloc(
    validators: [
      // InputValidator.required,
      // InputValidator.phoneNo,
    ],
  );

  // Title

  final title = SelectFieldBloc<TitleModel, dynamic>();

  // State
  final division = SelectFieldBloc<DivisionModel, dynamic>();

  // Bank
  final bank = SelectFieldBloc<BankModel, dynamic>();

  // Email
  final email = TextFieldBloc(
    validators: [
      InputValidator.required,
      InputValidator.emailChar,
    ],
  );

  final icNo = TextFieldBloc(
   
  );

  // Group
  final group = TextFieldBloc();

  // Address
  final address = TextFieldBloc(
    validators: [
      InputValidator.required,
    ],
  );

  // Bank account
  final accountNo = TextFieldBloc(
    validators: [
      InputValidator.required,
    ],
  );

  // Password
  final password = TextFieldBloc(
    validators: [
      InputValidator.required,
      InputValidator.passwordChar,
    ],
  );

  // Confirm Password
  final confirmPassword = TextFieldBloc(
    validators: [InputValidator.required],
  );

  // Check Email
  Future<String?> _checkEmail(String email) async {
    bool isExist = await userBloc.checkEmail(email);
    if (isExist) {
      return "This email is already registered";
    }
    return null;
  }

  // Check Email
  Future<String?> _checkIcNumber(String icNo) async {
    bool isExist = await userBloc.checkIcNumber(icNo);
    if (isExist) {
      return "This IC number is already registered";
    }
    return null;
  }

  // Check Email
  Future<String?> _checkPhoneNo(String phoneNo) async {
    bool isExist = await userBloc.checkPhoneNumber(phoneNo);
    if (isExist) {
      return "This phone number is already registered";
    }
    return null;
  }

  // Check Email
  Future<String?> _checkHeroCode(String heroCode) async {
    bool isExist = await userBloc.checkHeroCode(heroCode);
    if (isExist) {
      return null;
    }
    return "Invalid referral code";
  }

  Validator<String> _confirmPassword(
    TextFieldBloc passwordTextFieldBloc,
  ) {
    return (String confirmPassword) {
      if (confirmPassword == passwordTextFieldBloc.value) {
        return null;
      }
      return "Your password does not match";
    };
  }

  RegisterHeroFormBloc() {
    addFieldBlocs(fieldBlocs: [
      title,
      icNo,
      phoneNo,
      group,
      address,
      division,
      accountNo,
      bank,
      name,
      referralCode,
      email,
      password,
      confirmPassword,
    ]);

    // Upadate Title Items
    TitleModel initTitleModel = TitleModel(id: 0, title: "Tan Sri");
    title.updateItems([
      initTitleModel,
      TitleModel(id: 1, title: "Puan Sri"),
      TitleModel(id: 2, title: "Dato Sri"),
      TitleModel(id: 3, title: "Dato Seri"),
      TitleModel(id: 4, title: "Datuk"),
      TitleModel(id: 5, title: "Datin"),
      TitleModel(id: 6, title: "Haji"),
      TitleModel(id: 7, title: "Hajah"),
      TitleModel(id: 8, title: "Tuan"),
      TitleModel(id: 9, title: "Puan"),
      TitleModel(id: 10, title: "Encik"),
      TitleModel(id: 11, title: "Cik"),
      TitleModel(id: 12, title: "Dr"),
    ]);

    title.updateInitialValue(initTitleModel);

    // Upadate Bank Items
    BankModel initBankModel = BankModel(id: 1, name: "Maybank2U");
    bank.updateItems([
      initBankModel,
      BankModel(id: 2, name: "CIMB Bank"),
      BankModel(id: 3, name: "Bank Islam"),
      BankModel(id: 4, name: "Public Bank"),
      BankModel(id: 5, name: "Hong Leong Bank"),
      BankModel(id: 6, name: "RHB Bank"),
      BankModel(id: 7, name: "Ambank"),
      BankModel(id: 8, name: "Bank Rakyat"),
      BankModel(id: 9, name: "Alliance Bank"),
      BankModel(id: 10, name: "Affin Bank"),
      BankModel(id: 11, name: "Bank Muamalat"),
      BankModel(id: 12, name: "Bank Simpanan Nasional"),
      BankModel(id: 13, name: "Standard Chartered"),
      BankModel(id: 14, name: "OCBC Bank"),
      BankModel(id: 15, name: "Agro Bank"),
      BankModel(id: 16, name: "UOB Bank"),
      BankModel(id: 17, name: "HSBC"),
      BankModel(id: 18, name: "Kuwait Finance House"),
      BankModel(id: 19, name: "CIMB Islamic Bank"),
      BankModel(id: 20, name: "Maybank2E"),
      BankModel(id: 21, name: "Al Rajhi Bank"),
      BankModel(id: 22, name: "Citibank Berhad"),
      BankModel(id: 23, name: "Maybank"),
      BankModel(id: 24, name: "MBSB Bank"),
    ]);

    bank.updateInitialValue(initBankModel);

    // Upadate Division Items
    DivisionModel initDivisionModel = DivisionModel(id: 10, name: "Johor");
    division.updateItems([
      initDivisionModel,
      DivisionModel(id: 11, name: "Kedah"),
      DivisionModel(id: 12, name: "Kelantan"),
      DivisionModel(id: 13, name: "Kuala Lumpur"),
      DivisionModel(id: 14, name: "Labuan"),
      DivisionModel(id: 15, name: "Melaka"),
      DivisionModel(id: 16, name: "Negeri Sembilan"),
      DivisionModel(id: 17, name: "Pahang"),
      DivisionModel(id: 18, name: "Perak"),
      DivisionModel(id: 19, name: "Perlis"),
      DivisionModel(id: 20, name: "Penang"),
      DivisionModel(id: 21, name: "Sabah"),
      DivisionModel(id: 22, name: "Sarawak"),
      DivisionModel(id: 23, name: "Selangor"),
      DivisionModel(id: 24, name: "Terengganu"),
    ]);

    division.updateInitialValue(initDivisionModel);

    confirmPassword
      ..addValidators([_confirmPassword(password)])
      ..subscribeToFieldBlocs([password]);

    email.addAsyncValidators(
      [_checkEmail],
    );

    referralCode.addAsyncValidators(
      [_checkHeroCode],
    );

    phoneNo.addAsyncValidators(
      [_checkPhoneNo],
    );

    icNo.addAsyncValidators(
      [_checkIcNumber],
    );
  }

  @override
  void onSubmitting() async {
    try {
      RegisterHeroRequestModel requestModel =
          RegisterHeroRequestModel(userModel: UserModel());
      // Account details
      requestModel.referralCode = referralCode.value.trim().toUpperCase();
      requestModel.userModel!.icNo = icNo.value.trim();
      requestModel.userModel!.email = email.value.trim();
      requestModel.userModel!.phoneNo = phoneNo.value.trim();
      requestModel.userModel!.password = password.value.trim();

      // User details
      requestModel.userModel!.titleId = title.value!.id;
      requestModel.userModel!.name = name.value.trim();
      requestModel.userModel!.address = address.value;
      requestModel.userModel!.worldDivisionId = division.value!.id;
      requestModel.groupName = group.value;

      // Bank details
      requestModel.bankId = bank.value!.id;
      requestModel.accountNumber = accountNo.value;

      // Call API
      DefaultResponseModel responseModel =
          await userBloc.register(requestModel);

      // Handle response
      if (responseModel.isSuccess) {
        emitSuccess(successResponse: email.value.trim());
      } else {
        emitFailure(failureResponse: responseModel.message);
      }
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
  }
}
