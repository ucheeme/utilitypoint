import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
// import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';

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
      LogInterceptor(
        requestBody: true,
        responseBody: true
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
      'Accept-Language': 'en-US,en;q=0.5',
      'Accept': 'application/json',
      'Connection':"keep-alive"
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
          AppUtils.debug("this is a POST request: $response");
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
        if (response.statusCode == 409) {
          // Handle conflict
          print('Conflict error: ${response.data}');
          // Consider retrying or showing an error message to the user
        }
        if (399 <= (response.statusCode ?? 400) &&
            (response.statusCode ?? 400) <= 500) {
          if (response.data is String) {
            print("I am the issue: ${response.data}");
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
        }
        else {
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

  static Future<Object> uploadDoc(File file, String url, String docType) async {
    try {
      var headers =  header(true);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);
      request.fields['DocumentType'] = docType;
      request.files.add(
          http.MultipartFile(
              'Image',
              file.readAsBytes().asStream(),
              file.lengthSync(),
              filename: file.path.split("/").last
          )
      );
      AppUtils.debug("/****rest call request starts****/");
      AppUtils.debug("url: $url");
      AppUtils.debug("headers: $headers");
      var res = await request.send();
      final response = await res.stream.bytesToString();
      AppUtils.debug("/****rest call response starts****/");
      AppUtils.debug("status code: ${res.statusCode}");
      AppUtils.debug("rest response: "+response);
      if (ApiResponseCodes.success == res.statusCode){
        return  Success(res.statusCode,response);
      }
      if (ApiResponseCodes.error == res.statusCode || ApiResponseCodes.internalServerError == res.statusCode){
        return  Failure(res.statusCode,(defaultApiResponseFromJson(response)));
      }
      if (ApiResponseCodes.authorizationError == res.statusCode){
        return ForbiddenAccess();
      }
      else{
        return  Failure(res.statusCode,"Error Occurred");
      }
    }on HttpException{
      return  NetWorkFailure();

    }on FormatException{
      return  UnExpectedError();

    }catch (e){
      return NetWorkFailure();
    }
  }

  Future<String?> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }

}