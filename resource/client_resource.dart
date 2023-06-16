import 'dart:convert';

import 'package:auf/models/client/list_client_response_model.dart';
import 'package:auf/services/resource.dart';

class ClientResource {
  static Resource getClient(String? query) {
    return Resource(
        url: 'clients',
        params: {
          // Calculate number page based on offset and take
         
          if (query != null) 'search': query,
        },
        parse: (response) {
          return ListClientResponseModel(json.decode(response.body));
        });
  }
}
