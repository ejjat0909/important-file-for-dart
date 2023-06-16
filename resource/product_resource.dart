import 'dart:convert';
import 'package:auf/models/product/product_model.dart';
import 'package:auf/models/product/product_response_model.dart';
import 'package:auf/services/resource.dart';
import 'package:get_it/get_it.dart';

class ProductResource {
  static Resource getProductList() {
    return Resource(
        url: 'products',
        parse: (response) {
          try {
            return ProductResponseModel(json.decode(response.body));
          } catch (error) {
            return error;
          }
        });
  }

  // Save user model to GetIt to retrieve the model faster and easier when needed
  static setGetIt(List<ProductModel> listProductModel) {
    if (!GetIt.instance.isRegistered<List<ProductModel>>()) {
      GetIt.instance.registerSingleton<List<ProductModel>>(listProductModel);
    } else {
      GetIt.instance.unregister<List<ProductModel>>();
      GetIt.instance.registerSingleton<List<ProductModel>>(listProductModel);
    }
  }
}
