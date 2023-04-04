import 'package:auf/models/product/product_response_model.dart';
import 'package:auf/resource/product_resource.dart';
import 'package:auf/services/web_services.dart';

class ProductBloc {
  Future<ProductResponseModel> getProductList() async {
    return await Webservice.get(ProductResource.getProductList());
  }
}
