import 'package:auf/models/sales/list_sales_response_model.dart';
import 'package:auf/models/sales/sales_filter_model.dart';
import 'package:auf/models/sales/sales_resource.dart';
import 'package:auf/services/web_services.dart';

class SalesBloc {
  Future<ListSalesResponseModel> getSales(
      SalesFilterModel salesFilterModel) async {
    return await Webservice.get(SalesResource.getSales(salesFilterModel));
  }
}
