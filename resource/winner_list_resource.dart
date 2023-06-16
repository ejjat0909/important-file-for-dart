import 'dart:convert';

import 'package:auf/models/contest_list/contest_list_filter_model.dart';
import 'package:auf/models/contest_list/contest_list_model.dart';
import 'package:auf/models/contest_list/contest_list_response_model.dart';
import 'package:auf/models/winner_list/winner_list_filter_model.dart';
import 'package:auf/models/winner_list/winner_list_model.dart';
import 'package:auf/models/winner_list/winner_list_response_model.dart';
import 'package:auf/services/resource.dart';
import 'package:get_it/get_it.dart';

class WinnerListResource {
  static Resource getWinnerList(ContestListFilterModel contestListFilterModel) {
    return Resource(
        url: 'dashboard/list-winner/' + contestListFilterModel.id.toString(),
        params: {
          'page':
              ((contestListFilterModel.page! / contestListFilterModel.take!) +
                      1)
                  .toInt()
                  .toString(),
          'take': contestListFilterModel.take.toString(),
        },
        parse: (response) {
          try {
            return WinnerListResponseModel(json.decode(response.body));
          } catch (error) {
            return error;
          }
        });
  }
}
