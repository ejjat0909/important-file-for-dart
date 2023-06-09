import 'dart:convert';

import 'package:auf/models/default_response_model.dart';
import 'package:auf/models/user/change_password_model.dart';
import 'package:auf/services/resource.dart';

class ChangePasswordResource {

  static Resource verifyPassword(String password) {
    return Resource(
        url: 'change-password/verify',
        data: {'email': password},
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }

  static Resource updatePassword(ChangePasswordRequestModel requestModel) {
    return Resource(
        url: 'change-password/update',
        data: requestModel.toJson(),
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }
}
