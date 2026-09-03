import 'dart:convert';
import 'dart:ui';

import 'package:http/http.dart';
import 'package:logger/logger.dart';

part 'network_response.dart';

class NetworkCaller {
  final Logger _logger = Logger();

  final Map<String, String> Function() headers;
  final VoidCallback onUnauthorize;

  NetworkCaller({required this.headers, required this.onUnauthorize});

  Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);
      Response response = await get(uri, headers: headers());

      final decodedJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _logResponse(response);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedJson,
        );
      } else if (response.statusCode == 401) {
        onUnauthorize();
        _logResponse(response, isError: true);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Unauthorized'
        );
      } else {
        _logResponse(response, isError: true);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          body: decodedJson['msg'],
        );
      }
    } catch (e) {
      _logger.e('''URL => $url
      Message => e.toString()''');
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest(
    String url, {
    Map<String, dynamic>? body,
    bool fromLogin = false,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url, body: body);
      Response response = await post(
        uri,
        body: jsonEncode(body),
        headers: headers(),
      );

      final decodedJson = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _logResponse(response);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedJson,
        );
      } else if (response.statusCode == 401) {
        if (fromLogin == false) {
          onUnauthorize();
        }
        _logResponse(response, isError: true);
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: 'Unauthorized'
        );
      } else {
        _logResponse(response, isError: true);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedJson['msg'],
        );
      }
    } catch (e) {
      _logger.e('''URL => $url
      Message => e.toString()''');
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  // TODO: Add PATCH, PUT, DELETE Methods

  void _logRequest(String url, {Map<String, dynamic>? body}) {
    _logger.i('''Request URL: $url
    Headers: ${headers()}
    Body: $body
    ''');
  }

  void _logResponse(Response response, {bool isError = false}) {
    if (isError) {
      _logger.e('''URL => ${response.request!.url}
    Status Code => ${response.statusCode}
    Headers => ${response.headers}
    Body => ${response.body}''');
    } else {
      _logger.i('''URL => ${response.request!.url}
    Status Code => ${response.statusCode}
    Headers => ${response.headers}
    Body => ${response.body}''');
    }
  }
}
