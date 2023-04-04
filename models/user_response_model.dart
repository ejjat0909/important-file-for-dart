import 'package:auf/helpers/base_api_response.dart';
import 'package:auf/models/paginator_model.dart';
import 'package:auf/models/user/user_model.dart';

class UserResponseModel extends BaseAPIResponse<UserModel, Null> {
  UserResponseModel(fullJson) : super(fullJson);

  @override
  dataToJson(UserModel? data) {
    if (this.data != null) {
      return this.data!.toJson();
    }
    return null;
  }

  @override
  errorsToJson(Null errors) {
    return null;
  }

  @override
  UserModel? jsonToData(Map<String, dynamic>? json) {
    return json!["data"] != null ? UserModel.fromJson(json["data"]) : null;
  }

  @override
  Null jsonToError(Map<String, dynamic> json) {
    return null;
  }

  @override
  PaginatorModel? jsonToPaginator(Map<String, dynamic> json) {
    // TODO: implement jsonToPaginator
    throw UnimplementedError();
  }

  @override
  PaginatorModel? paginatorToJson(PaginatorModel? paginatorModel) {
    // TODO: implement paginatorToJson
    throw UnimplementedError();
  }
}
