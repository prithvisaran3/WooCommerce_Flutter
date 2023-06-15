// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steels/app/config/config.dart';
import '../controller/main.dart';

class HttpHelper {
  Future<dynamic> get(
      {required url,
      bool auth = false,
      bool contentHeader = false,
      bool isLoginToken = false,
      bool cors = false}) async {
    try {
      Map<String, String> hd = await headers(
          auth: auth,
          contentHeader: contentHeader,
          cors: cors,
          isLoginToken: isLoginToken);
      if (kDebugMode) {
        print("Passing Url: $url, Passing Headers $hd");
      }

      final response = await http
          .get(Uri.parse(url), headers: hd)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        return http.Response("Timeout", 408);
      });

      if (kDebugMode) {
        print("Status Code On Http Server: ${response.statusCode}");
      }
      if (kDebugMode) {
        print("Body On Http Server: ${response.body}");
      }
      var jsonResponse = returnResponse(response);
      return jsonResponse;
    } catch (e) {
      if (kDebugMode) {
        print("Error or get request failed on http helper $e");
      }
    }
  }

  Future<dynamic> post(
      {required url,
      required body,
      bool auth = false,
      bool contentHeader = false,
      bool isLoginToken = false,
      bool tempContentHeader = false,
      bool cors = false}) async {
    try {
      Map<String, String> hd = await headers(
          auth: auth,
          contentHeader: contentHeader,
          cors: cors,
          isLoginToken: isLoginToken,
          tempContentHeader: tempContentHeader);
      if (kDebugMode) {
        print("Passing Url: $url, Passing Headers $hd");
      }
      var response = await http
          .post(Uri.parse(url),
              body: body, headers: hd, encoding: Encoding.getByName("utf-8"))
          .timeout(const Duration(seconds: 10), onTimeout: () {
        return http.Response("Timeout", 408);
      });
      if (kDebugMode) {
        print("Status Code On Http Server: ${response.statusCode}");
      }
      if (kDebugMode) {
        print("Body On Http Server: ${response.body}");
      }
      var jsonResponse = returnResponse(response);
      return jsonResponse;
    } catch (e) {
      if (kDebugMode) {
        print("Error or post request failed on http helper $e");
      }
    }
  }

  Future<dynamic> multiPart(
      {required url,
      required body,
      String? image1,
      String? image2,
      String? image3,
      String? image4,
      String? image1Key,
      String? image2Key,
      String? image3Key,
      String? image4Key,
      bool auth = false,
      bool contentHeader = false,
      bool cors = false}) async {
    try {
      var hd = await headers(
          auth: auth,
          contentHeader: contentHeader,
          cors: cors,
          isMultipart: true);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      debugPrint("Passing Url: $url, Passing Headers $hd");
      request.headers.addAll(hd);

      if (image1 != null || image1 != "") {
        final file = await http.MultipartFile.fromPath('$image1Key', image1!);
        request.files.add(file);
      } else if (image2 != null || image2 != "") {
        final file = await http.MultipartFile.fromPath('$image2Key', image2!);
        request.files.add(file);
      } else if (image3 != null || image3 != "") {
        final file = await http.MultipartFile.fromPath('$image3Key', image3!);
        request.files.add(file);
      } else if (image4 != null || image4 != "") {
        final file = await http.MultipartFile.fromPath('$image4Key', image4!);
        request.files.add(file);
      }
      if (body != null) {
        request.fields[body['key']] = body['value'];
      }
      //send
      var response = await request.send();
      debugPrint("Status Code On Http Server: ${response.statusCode}");
      var res = await http.Response.fromStream(response);
      debugPrint("Body On Http Server: ${res.body}");
      var jsonResponse = returnResponse(res);
      return jsonResponse;
    } catch (e) {
      debugPrint("Error from server on $e");
    }
  }

  Future<dynamic> put(
      {required String url,
      required body,
      bool auth = false,
      bool contentHeader = false,
      bool tempContentHeader = false,
      bool cors = false}) async {
    dynamic responseJson;
    try {
      Map<String, String> hd = await headers(
          auth: auth,
          contentHeader: contentHeader,
          cors: cors,
          tempContentHeader: tempContentHeader);
      if (kDebugMode) {
        print("Passing Url: $url, Passing Headers $hd");
      }
      var response = await http
          .put(Uri.parse(url), body: body, headers: hd)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        return http.Response("Timeout", 408);
      });
      if (kDebugMode) {
        print("Status Code On Http Server: ${response.statusCode}");
      }
      if (kDebugMode) {
        print("Body On Http Server: ${response.body}");
      }
      var jsonResponse = returnResponse(response);
      return jsonResponse;
    } catch (e) {
      if (kDebugMode) {
        print("Error or put request failed on http helper $e");
      }
    }
  }

  Future<dynamic> delete(
      {required String url,
      required body,
      bool auth = false,
      bool contentHeader = false,
      bool cors = false}) async {
    dynamic responseJson;
    try {
      Map<String, String> hd =
          await headers(auth: auth, contentHeader: contentHeader, cors: cors);
      if (kDebugMode) {
        print("Passing Url: $url, Passing Headers $hd");
      }
      var response = await http
          .delete(Uri.parse(url), body: body, headers: hd)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        return http.Response("Timeout", 408);
      });
      if (kDebugMode) {
        print("Status Code On Http Server: ${response.statusCode}");
      }
      if (kDebugMode) {
        print("Body On Http Server: ${response.body}");
      }
      var jsonResponse = returnResponse(response);
      return jsonResponse;
    } catch (e) {
      if (kDebugMode) {
        print("Error or put request failed on http helper $e");
      }
    }
  }

  returnResponse(http.Response response) async {
    debugPrint("http status code: ${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        var body = response.body;
        int code = response.statusCode;
        statusCode = code;
        return body;
      case 201:
        var jsonData = response.body;
        statusCode = response.statusCode;
        return jsonData;
      case 400:
        var body = response.body;
        int code = response.statusCode;
        statusCode = code;
        return body;
      case 401:
        var body = response.body;
        int code = response.statusCode;
        statusCode = code;
        return body;
      case 403:
        var body = response.body;
        statusCode = response.statusCode;
        return body;
      case 404:
        var body = response.body;
        int code = response.statusCode;
        statusCode = code;
        return body;
      case 408:
        var body = response.body;
        int code = response.statusCode;
        statusCode = code;
        return body;
      case 500:
        int code = response.statusCode;
        var body = response.body;
        statusCode = code;
        return body;
    }
  }

  headers(
      {auth,
      contentHeader,
      cors,
      isMultipart,
      isLoginToken,
      tempContentHeader}) async {
    Map<String, String> headers;
    if (isMultipart == true) {
      headers = {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        HttpHeaders.cacheControlHeader: 'no-cache',
        HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
        'Access-Control-Allow-Headers': '*',
        'Access-Control-Allow-Origin': '*',
      };
    } else if (contentHeader == true) {
      headers = {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      };
    } else if (tempContentHeader == true) {
      headers = {HttpHeaders.contentTypeHeader: "application/json"};
    } else {
      headers = {HttpHeaders.acceptHeader: "application/json"};
    }

    var corsHeader = {HttpHeaders.accessControlAllowOriginHeader: "*"};
    var corsHeaderTwo = {
      HttpHeaders.accessControlAllowMethodsHeader:
          "GET,PUT,POST,DELETE,PATCH,OPTIONS"
    };
    var corsHeaderThree = {
      HttpHeaders.accessControlAllowCredentialsHeader: "true"
    };
    var corsHeaderFour = {
      HttpHeaders.accessControlAllowHeadersHeader:
          "Origin, Content-Type, Accept"
    };
    if (cors == true) {
      headers.addAll(corsHeader);
      headers.addAll(corsHeaderTwo);
      headers.addAll(corsHeaderThree);
      headers.addAll(corsHeaderFour);
    }

    if (auth == true) {
      var token =
          base64.encode(utf8.encode("${AppConfig.key}:${AppConfig.secret}"));
      headers.addAll({HttpHeaders.authorizationHeader: "Basic $token"});
    }
    if (isLoginToken == true) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString('token');
      headers.addAll({HttpHeaders.authorizationHeader: "Bearer $token"});
    }
    return headers;
  }
}
