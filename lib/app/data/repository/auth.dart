import 'dart:convert';
import 'package:steels/app/config/config.dart';

import '../../services/api_service.dart';
import '../../services/http.dart';
import '../model/customer.dart';

class AuthRepository {
  final HttpHelper helper = HttpHelper();

  Future<dynamic> register({required body}) async {
    var response =
        await helper.post(url: ApiService.register, body: body, auth: true);
    var res = jsonDecode(response);
    return res;
  }

  Future<dynamic> login({required body}) async {
    var response = await helper.post(
        url: ApiService.login, body: body, contentHeader: true);
    var res = jsonDecode(response);
    return res;
  }

  Future<dynamic> forgotPassword({required body}) async {
    var response = await helper.post(url: ApiService.forgotPassword, body: body);
    var res = jsonDecode(response);
    return res;
  }
}
