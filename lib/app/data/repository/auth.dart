import 'dart:convert';
import '../../services/api_service.dart';
import '../../services/http.dart';
import '../model/customer.dart';

class AuthRepository {
  final HttpHelper helper = HttpHelper();

  Future<CustomerRes> register({required body}) async {
    var response =
        await helper.post(url: ApiService.register, body: body, auth: true);
    var res = CustomerRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> login({required body}) async {
    var response = await helper.post(
        url: ApiService.login, body: body, contentHeader: true);
    var res = jsonDecode(response);
    return res;
  }
}
