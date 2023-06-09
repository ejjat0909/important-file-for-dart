import 'dart:convert';

import 'package:auf/models/default_response_model.dart';
import 'package:auf/models/forgot_password/forgot_password_request_model.dart';
import 'package:auf/services/resource.dart';

class ForgotPasswordResource {
  static Resource sendOTP(String email) {
    return Resource(
        url: 'forgot-password',
        data: {'email': email},
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }

  static Resource verifyOTP(String email, String otp) {
    return Resource(
        url: 'forgot-password/verify',
        data: {'email': email, 'otp': otp},
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }

  static Resource updatePassword(ForgotPasswordRequestModel requestModel) {
    return Resource(
        url: 'forgot-password/update',
        data: requestModel.toJson(),
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }
}
