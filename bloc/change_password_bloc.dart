import 'package:auf/models/default_response_model.dart';
import 'package:auf/models/user/change_password_model.dart';
import 'package:auf/models/forgot_password/forgot_password_request_model.dart';
import 'package:auf/resource/change_password_resource.dart';
import 'package:auf/resource/forgot_password_resource.dart';
import 'package:auf/services/web_services.dart';

class ChangePasswordBloc {
  Future<DefaultResponseModel> verifyPassword(String password) async {
    return await Webservice.post(
        ChangePasswordResource.verifyPassword(password));
  }

  Future<DefaultResponseModel> updatePassword(
      ChangePasswordRequestModel requestModel) async {
    return await Webservice.post(
        ChangePasswordResource.updatePassword(requestModel));
  }
}
