import 'dart:convert';

import 'package:auf/models/contest_list/contest_list_response_model.dart';
import 'package:auf/services/resource.dart';

class ContestListResource {
  static Resource getContestList() {
    return Resource(
        url: 'dashboard/list-contest',
        parse: (response) {
          try {
            return ContestListResponseModel(json.decode(response.body));
          } catch (error) {
            return error;
          }
        });
  }

  static Resource getAllContestList() {
    return Resource(
        url: 'contest',
        parse: (response) {
          try {
            return ContestListResponseModel(json.decode(response.body));
          } catch (error) {
            return error;
          }
        });
  }
}
