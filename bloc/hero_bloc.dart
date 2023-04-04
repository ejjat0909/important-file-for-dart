import 'package:auf/constant.dart';
import 'package:auf/models/default_response_model.dart';
import 'package:auf/models/downline/downline_filter_model.dart';
import 'package:auf/models/downline/list_downline_response_model.dart';
import 'package:auf/models/forgot_password/forgot_password_request_model.dart';
import 'package:auf/models/sales/hero_model.dart';
import 'package:auf/resource/forgot_password_resource.dart';
import 'package:auf/resource/hero_resource.dart';
import 'package:auf/services/web_services.dart';

class HeroBloc {
  Future<ListDownlineResponseModel> getCurrentDownlines(
      {DownlineFilterModel? downlineFilterModel}) async {
    return await Webservice.get(HeroResource.getCurrentDownlines(
        downlineFilterModel ?? DownlineFilterModel()));
  }

  Future<ListDownlineResponseModel> getUnderDownlines(int id) async {
    return await Webservice.get(HeroResource.getUnderDownlines(id));
  }
}
