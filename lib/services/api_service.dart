import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';

import '../model/defaultModel.dart';
import '../utils/app_util.dart';
import 'api_respondCodes.dart';
import 'api_status.dart';

String accessToken = "";

enum HttpMethods { post, put, patch, get, delete }

class ApiService {
  static Dio dio = Dio();

  static void initiateDio(bool requireAccess, String baseUrl) {
    dio.options
      ..baseUrl = baseUrl
      ..validateStatus = (int? status) {
        return status != null && status > 0;
      }
      ..headers = header(requireAccess);
    dio.interceptors.add(
      DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ),
    );
  }

  static Map<String, String> header(bool requireAccess) {
    return requireAccess
        ? {
      HttpHeaders.userAgentHeader: 'dio',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken'
    }
        : {
      HttpHeaders.userAgentHeader: 'dio',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  static Future<Object> makeApiCall(request,
      url,
      {bool requireAccess = true, HttpMethods requestType = HttpMethods.post,
        required String baseUrl}) async {
    initiateDio(requireAccess, baseUrl);
    try {
      var body = request != null ? json.encode(request.toJson()) : null;
      Response<String>? response;
      switch (requestType) {
        case HttpMethods.get:
          AppUtils.debug("trying a get request");
          if (request == null) {
            response = await dio.get(url);
          } else {
            print("req to send ${request.toJson}");
            response = await dio.get(url, queryParameters: request.toJson());
          }
          AppUtils.debug("method: get");
          break;
        case HttpMethods.post:
          response = await dio.post(url, data: body);
          AppUtils.debug("this is a POST request");
          break;
        case HttpMethods.put:
          response = await dio.put(url, data: body);
          AppUtils.debug("this is a PUT request");
        case HttpMethods.patch:
          response = await dio.patch(url, data: body);
          AppUtils.debug("this is a PATCH request");
        case HttpMethods.delete:
          response = await dio.delete(url, data: body);
          AppUtils.debug("this is a DELETE request");
      }
      if (response.statusCode != null) {
        AppUtils.debug("api Url: $url");
        AppUtils.debug("status code: ${response.statusCode}");
        AppUtils.debug("response body: $body");
        if (response.statusCode == ApiResponseCodes.success||
            response.statusCode==ApiResponseCodes.create_success) {
          return Success(response.statusCode!, response.data as String);
        }
        if (399 <= (response.statusCode ?? 400) &&
            (response.statusCode ?? 400) <= 500) {
          if (response.data is String) {
            try {
              var apiRes = defaultApiResponseFromJson(response.data as String);
              return Failure(response.statusCode ?? 400, (apiRes));
            } catch (e) {
              print("error: $e");
            }
          } else {
            return ForbiddenAccess();
          }
        }
        if (ApiResponseCodes.authorizationError == response.statusCode) {
          return ForbiddenAccess();
        } else {
          return Failure(response.statusCode!, "Error Occurred");
        }
      } else {
        return UnExpectedError();
      }
    } on DioError catch (e, trace) {
      AppUtils.debug(e.message);
      AppUtils.debug(trace);
      return NetWorkFailure();
    }
  }
}