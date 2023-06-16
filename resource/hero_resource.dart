import 'dart:convert';

import 'package:auf/models/default_response_model.dart';
import 'package:auf/models/downline/downline_filter_model.dart';
import 'package:auf/models/downline/list_downline_response_model.dart';
import 'package:auf/models/forgot_password/forgot_password_request_model.dart';
import 'package:auf/models/sales/hero_model.dart';
import 'package:auf/services/resource.dart';

class HeroResource {
  static Resource getCurrentDownlines(DownlineFilterModel filterModel) {
    return Resource(
        url: 'heroes/downlines',
        params: {
          // Calculate number page based on offset and take
          'page':
              ((filterModel.page! / filterModel.take!) + 1).toInt().toString(),
          'take': filterModel.take.toString(),
          if (filterModel.query != null) 'search': filterModel.query,
        },
        parse: (response) {
          return ListDownlineResponseModel(json.decode(response.body));
        });
  }

  static Resource getUnderDownlines(int id) {
    return Resource(
        url: 'heroes/' + id.toString() + '/downlines',
        parse: (response) {
          return ListDownlineResponseModel(json.decode(response.body));
        });
  }
}
