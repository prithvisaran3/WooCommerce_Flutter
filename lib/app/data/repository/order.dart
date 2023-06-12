import 'dart:convert';
import '../../config/config.dart';
import '../../services/api_service.dart';
import '../../services/http.dart';

class OrderRepository {
  final HttpHelper helper = HttpHelper();

  Future<dynamic> getOrders({required params}) async {
    var response = await helper.get(
        url: "${ApiService.getOrders}${AppConfig.paramKey2}");
    var res = jsonDecode(response);
    return res;
  }
}
