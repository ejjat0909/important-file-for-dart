import 'package:auf/models/contest_list/contest_list_filter_model.dart';
import 'package:auf/models/contest_list/contest_list_model.dart';
import 'package:auf/models/contest_list/contest_list_response_model.dart';
import 'package:auf/models/winner_list/winner_list_filter_model.dart';
import 'package:auf/models/winner_list/winner_list_model.dart';
import 'package:auf/models/winner_list/winner_list_response_model.dart';
import 'package:auf/resource/contest_list_resource.dart';
import 'package:auf/resource/winner_list_resource.dart';
import 'package:auf/services/web_services.dart';

class WinnerListBloc {
  Future<WinnerListResponseModel> getWinnerList(
      ContestListFilterModel contestListFilterModel) async {
    return await Webservice.get(
        WinnerListResource.getWinnerList(contestListFilterModel));
  }
}
