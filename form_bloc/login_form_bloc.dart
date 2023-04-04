import 'package:auf/bloc/product_bloc.dart';
import 'package:auf/bloc/user_bloc.dart';
import 'package:auf/helpers/secure_storage_api.dart';

import 'package:auf/models/login/login_request_model.dart';
import 'package:auf/models/product/product_model.dart';
import 'package:auf/models/product/product_response_model.dart';
import 'package:auf/models/user/user_model.dart';
import 'package:auf/models/user/user_response_model.dart';
import 'package:auf/resource/product_resource.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class LoginFormBloc extends FormBloc<UserModel, UserResponseModel> {
  // Initialize Bloc
  final UserBloc userBloc = UserBloc();

  // For email field
  final email = TextFieldBloc(
   // initialValue: "mahathirbz@gmail.com",
    validators: [
      FieldBlocValidators.required,
    ],
  );

  // For password field
  final password = TextFieldBloc(
 // initialValue: "password",
    validators: [
      FieldBlocValidators.required,
    ],
  );

  // Constructor, to add the field variable to the form
  LoginFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        email,
        password,
      ],
    );
  }

  // Handle what happen on submit
  @override
  void onSubmitting() async {
    try {
      // Call API to Login
      UserResponseModel userResponseModel = await userBloc.login(
          LoginRequestModel(email: email.value, password: password.value));

      // Handle API response
      if (userResponseModel.isSuccess &&
          userResponseModel.data!.accessToken != null) {
        // Hnadle list of product data
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
          final ProductResponseModel response =
              await productBloc.getProductList();
          if (response.isSuccess) {
            SecureStorageApi.saveObject('list_product', response.data);
            ProductResource.setGetIt(response.data!);
          }
        }

        emitSuccess(successResponse: userResponseModel.data!);
      } else {
        // Trigger fail event
        emitFailure(failureResponse: userResponseModel);
      }
    } catch (e) {
      // Trigger fail event
      emitFailure();
    }
  }
}
