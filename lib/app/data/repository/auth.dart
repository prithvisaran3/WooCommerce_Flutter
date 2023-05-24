import 'dart:convert';
import '../../config/config.dart';
import '../../services.dart';
import '../../services/http.dart';
import '../model/customer.dart';

class AuthRepository {
  final HttpHelper helper = HttpHelper();

  Future<CustomerRes> register({required body}) async {
    var response = await helper.post(
        url: "${AppConfig.baseUrl}${ApiService.customers}",
        body: body,
        auth: true,
        contentHeader: false);
    var res = CustomerRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> login({required body}) async {
    var response = await helper.post(
        url: AppConfig.tokenUrl, body: body, contentHeader: true);
    var res = jsonDecode(response);
    return res;
  }
}
