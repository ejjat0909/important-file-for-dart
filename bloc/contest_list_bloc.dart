import 'package:auf/models/contest_list/contest_list_response_model.dart';
import 'package:auf/resource/contest_list_resource.dart';
import 'package:auf/services/web_services.dart';

class ContestListBloc {
  Future<ContestListResponseModel> getContestList() async {
    return await Webservice.get(ContestListResource.getContestList());
  }

  Future<ContestListResponseModel> getAllContestList() async {
    return await Webservice.get(ContestListResource.getAllContestList());
  }
}
