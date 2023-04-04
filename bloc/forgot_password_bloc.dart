import 'package:auf/models/default_response_model.dart';
import 'package:auf/models/forgot_password/forgot_password_request_model.dart';
import 'package:auf/resource/forgot_password_resource.dart';
import 'package:auf/services/web_services.dart';

class ForgotPasswordBloc {
  Future<DefaultResponseModel> verifyEmail(String email) async {
    return await Webservice.post(ForgotPasswordResource.sendOTP(email));
  }

  Future<DefaultResponseModel> verifyOTP(String email, String otp) async {
    return await Webservice.post(ForgotPasswordResource.verifyOTP(email, otp));
  }

  Future<DefaultResponseModel> updatePassword(
      ForgotPasswordRequestModel requestModel) async {
    return await Webservice.post(
        ForgotPasswordResource.updatePassword(requestModel));
  }
}
