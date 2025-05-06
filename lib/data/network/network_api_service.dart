import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_apps_bloc/data/network/base_api_service.dart';
import 'package:http/http.dart' as http;
import '../exception/app_exception.dart';

class NetworkApiService implements BaseApiService {
  @override
  Future getApi(String url) async {
    debugPrint('url: $url');
    dynamic jsonResponse;
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(Duration(seconds: 20));

      jsonResponse = returnResponse(response);
      debugPrint('jsonResponse: $jsonResponse');
      return jsonResponse;
    } on SocketException {
      throw NoInternetException();
    }
  }

  @override
  Future postApi(String url, data) async {
    dynamic jsonResponse;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(Duration(seconds: 20));
      jsonResponse = returnResponse(response);
      debugPrint('jsonResponse: $jsonResponse');
      return jsonResponse;
    } on SocketException {
      throw NoInternetException();
    }
  }
}

dynamic returnResponse(Response response) {
  debugPrint('StatusCode: ${response.statusCode}');
  switch (response.statusCode) {
    case 200:
      dynamic jsonResponse = jsonDecode(response.body.toString());
      return jsonResponse;
    case 400:
      throw BadRequestException();
    case 500:
      throw FetchDataException();
  }
}
