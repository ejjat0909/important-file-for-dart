import 'package:auf/models/client/list_client_response_model.dart';
import 'package:auf/resource/client_resource.dart';
import 'package:auf/services/web_services.dart';

class ClientBloc {
  Future<ListClientResponseModel> getClient(String query) async {
    return await Webservice.get(ClientResource.getClient(query));
  }
}
