import 'package:auf/helpers/base_api_response.dart';
import 'package:auf/models/contest_list/contest_list_model.dart';
import 'package:auf/models/paginator_model.dart';
import 'package:auf/models/report/report_header_model.dart';
import 'package:auf/models/user/user_model.dart';
import 'package:auf/models/winner_list/winner_list_model.dart';

class WinnerListResponseModel
    extends BaseAPIResponse<List<WinnerListModel>, Null> {
  WinnerListResponseModel(fullJson) : super(fullJson);

  @override
  dataToJson(List<WinnerListModel>? data) {
    if (this.data != null) {
      return this.data?.map((v) => v.toJson()).toList();
    }
    return null;
  }

  @override
  errorsToJson(Null errors) {
    return null;
  }

  @override
  List<WinnerListModel>? jsonToData(Map<String, dynamic>? json) {
    if (json != null) {
      data = [];

      json["data"].forEach((v) {
        data!.add(WinnerListModel.fromJson(v));
      });

      return data!;
    }

    return null;
  }

  @override
  Null jsonToError(Map<String, dynamic> json) {
    return null;
  }

  @override
  PaginatorModel? jsonToPaginator(Map<String, dynamic> json) {
    // Convert json["paginator"] data to PaginatorModel
    if (json["paginator"] != null) {
      return PaginatorModel.fromJson(json["paginator"]);
    }
    return null;
  }

  @override
  PaginatorModel? paginatorToJson(PaginatorModel? paginatorModel) {
    return null;
  }
}
