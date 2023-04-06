import 'dart:io';

import 'package:auf/app.dart';
import 'package:auf/bloc/product_bloc.dart';
import 'package:auf/helpers/secure_storage_api.dart';
import 'package:auf/models/product/product_model.dart';
import 'package:auf/models/product/product_response_model.dart';
import 'package:auf/models/report/summary_graph_model.dart';
import 'package:auf/models/report/report_header_model.dart';
import 'package:auf/models/user/user_model.dart';
import 'package:auf/models/winner_list/winner_list_model.dart';
import 'package:auf/providers/user_data_notifier.dart';
import 'package:auf/resource/product_resource.dart';
import 'package:auf/resource/user_resource.dart';
import 'package:auf/resource/winner_list_resource.dart';
import 'package:auf/screens/navigation_bar/navigation.dart';
import 'package:auf/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize model to use for the whole app to avoid null
  GetIt.instance.registerSingleton<UserModel>(UserModel());
  GetIt.instance.registerSingleton<ReportHeaderModel>(ReportHeaderModel());
  GetIt.instance.registerSingleton<List<ProductModel>>([]);
  // GetIt.instance
  //     .registerSingleton<CommissionGraphModel>(CommissionGraphModel());

  // await GetIt.instance.reset();
  // await SecureStorageApi.delete(key: "access_token");
  //get data from secure storage
  UserModel user = UserModel();

  Map<String, dynamic>? userJson = await SecureStorageApi.readObject("user");

  if (userJson != null) {
    user = UserModel.fromJson(userJson);
  }

  List<dynamic>? productJson =
      await SecureStorageApi.readObject("list_product");

  if (productJson != null) {
    List<ProductModel>? data = [];
    productJson.forEach((v) {
      data.add(ProductModel.fromJson(v));
    });
    ProductResource.setGetIt(data);
  } else {
    //Call API
    ProductBloc productBloc = ProductBloc();
    final ProductResponseModel response = await productBloc.getProductList();
    if (response.isSuccess) {
      SecureStorageApi.saveObject('list_product', response.data);
      ProductResource.setGetIt(response.data!);
    }
  }

  //save in GetIt
  UserResource.setGetIt(user);

  bool isAuthenticated = false;
  String token = await SecureStorageApi.read(key: "access_token");
  // If access token != ""
  if (token != "") {
    // Already login
    isAuthenticated = true;
  }

  Future<Widget> checkAuth() async {
    // Initial route
    Widget routeName = SignInScreen();
    if (!isAuthenticated) {
      // Not login yet
      routeName = SignInScreen();
    } else {
      // Already login
      routeName = Navigation();
    }
    return routeName;
  }

  Widget initialRoute = await checkAuth();

  runApp(MyApp(
    initialRoute: initialRoute,
  ));
}
