import 'package:auf/bloc/user_bloc.dart';
import 'package:auf/models/default_response_model.dart';

import 'package:auf/models/login/login_request_model.dart';
import 'package:auf/models/registration/register_payment_request_model.dart';
import 'package:auf/models/user/user_model.dart';
import 'package:auf/models/user/user_response_model.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class RegistrationFeeFormBloc extends FormBloc<String, String> {
  // Initialize Bloc
  final UserBloc userBloc = UserBloc();

  final String email;
  final ValueSetter<String?> onChangeDiscount;

  // For email field
  final discountCode = TextFieldBloc();

  // Constructor, to add the field variable to the form
  RegistrationFeeFormBloc(this.email, this.onChangeDiscount) {
    addFieldBlocs(
      fieldBlocs: [
        discountCode,
      ],
    );

    discountCode.addAsyncValidators(
      [_checkDiscountCode],
    );
  }

  // Check Email
  Future<String?> _checkDiscountCode(String discountCode) async {
    if (discountCode != "") {
      DefaultResponseModel responseModel =
          await userBloc.checkDiscountCode(discountCode);
      if (responseModel.isSuccess) {
        // Call back the update discount function
        onChangeDiscount(responseModel.data);
        // Return null to validations. Means no error
        return null;
      }
      // Call back the update discount function
      onChangeDiscount(null);
      return "Invalid Discount Code";
    }
    // Call back the update discount function
    onChangeDiscount(null);
    return null;
  }

  // Handle what happen on submit
  @override
  void onSubmitting() async {
    try {
      // Call API to Login
      DefaultResponseModel responseModel = await userBloc.payRegistrationFee(
          RegisterPaymentRequestModel(
              discountCode: discountCode.value, email: email));

      // Handle API response
      // If success and data not null, means bill id successfully generated
      if (responseModel.isSuccess && responseModel.data != null) {
        emitSuccess(successResponse: responseModel.data);
      } else {
        // Trigger fail event
        emitFailure(failureResponse: "Failed to generate Bill Id");
      }
    } catch (e) {
      // Trigger fail event
      emitFailure(failureResponse: e.toString());
    }
  }
}
