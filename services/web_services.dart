import 'dart:convert';

import 'package:auf/constant.dart';
import 'package:auf/helpers/secure_storage_api.dart';

import 'package:auf/helpers/shared_preferences.dart';
import 'package:auf/models/user/edit_profile_request_model.dart';
import 'package:auf/services/resource.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Webservice {
  // API request using POST method
  static Future post(Resource resource) async {
    // To authenticate user
    String? token = await SecureStorageApi.read(key: "access_token");

    // Create Uri from the url define in resource file. Then add the query parameters
    Uri uri = Uri.parse(rootUrl + resource.url)
        .replace(queryParameters: resource.params);

    http.Response response = await http.post(
      uri,
      body: jsonEncode(resource.data),
      headers: {
        // To only accept json response from server
        'Accept': 'application/json',
        // User Authorization
        'Authorization': 'Bearer $token',
        // To help laravel api recognize the body type of the request
        "content-type": "application/json"
      },
    );

    return resource.parse(response);
  }

  // API request using POST method
  static Future postUpdateUser(
      Resource resource, EditProfileRequestModel requestModel) async {
    // To authenticate user
    String? token = await SecureStorageApi.read(key: "access_token");

    var headers = {
      //To only accept json response from server
      'Accept': 'application/json',
      // User Authorization
      'Authorization': 'Bearer $token',
    };

    var request =
        http.MultipartRequest('POST', Uri.parse(rootUrl + resource.url));

    request.fields.addAll(
      requestModel.toJson(),
    );

    if (requestModel.photoPath != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'photo', requestModel.photoPath!.path!));
    }

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());

    return resource.parse(response);
  }

  // API request using GET method
  static Future get(Resource resource) async {
    
    // To authenticate user
    String? token = await SecureStorageApi.read(key: "access_token");

    // Create Uri from the url define in resource file. Then add the query parameters
    Uri uri = Uri.parse(rootUrl + resource.url)
        .replace(queryParameters: resource.params);

    http.Response response = await http.get(
      uri,
      headers: {
        //To only accept json response from server
        'Accept': 'application/json',
        //User Authorization
        'Authorization': 'Bearer $token',
      },
    );
return resource.parse(response);
  }

// API request using PUT method
  static Future put(Resource resource) async {
    // To authenticate user
    String? token = await SecureStorageApi.read(key: "access_token");

    // Create Uri from the url define in resource file. Then add the query parameters
    Uri uri = Uri.parse(rootUrl + resource.url)
        .replace(queryParameters: resource.params);

    http.Response response = await http.put(
      uri,
      body: jsonEncode(resource.data),
      headers: {
        // To only accept json response from server
        'Accept': 'application/json',
        // User Authorization
        'Authorization': 'Bearer $token',
        // To help laravel api recognize the body type of the request
        "content-type": "application/json"
      },
    );

    return resource.parse(response);
  }

  // API request using DELETE method
  static Future delete(Resource resource) async {
    // To authenticate user
    String? token = await SecureStorageApi.read(key: "access_token");

    Uri uri = Uri.parse(rootUrl + resource.url)
        .replace(queryParameters: resource.params);

    http.Response response = await http.delete(
      uri,
      headers: {
        //To only accept json response from server
        'Accept': 'application/json',
        //User Authorization
        'Authorization': 'Bearer $token',
      },
    );

    return resource.parse(response);
  }
}
