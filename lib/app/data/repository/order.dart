import 'dart:convert';
import '../../config/config.dart';
import '../../services/api_service.dart';
import '../../services/http.dart';

class OrderRepository {
  final HttpHelper helper = HttpHelper();

  Future<dynamic> getOrders({required params}) async {
    var response =
        await helper.get(url: "${ApiService.getOrders}${AppConfig.paramKey2}$params");
    var res = jsonDecode(response);
    return res;
  }

  Future<dynamic> createOrder({required body}) async {
    var response = await helper.post(
        url: "${ApiService.createOrders}${AppConfig.paramKey2}",
        body: body,
        tempContentHeader: true);
    var res = jsonDecode(response);
    return res;
  }

  Future<dynamic> deleteOrder({required body, required id}) async {
    var response = await helper.delete(
        url: "${ApiService.deleteOrder}$id?force=true&${AppConfig.paramKey2}",
        body: body);
    var res = jsonDecode(response);
    return res;
  }
}
