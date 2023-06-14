import 'dart:convert';
import '../../config/config.dart';
import '../../services/api_service.dart';
import '../../services/http.dart';

class PaymentGatewayRepository {
  final HttpHelper helper = HttpHelper();

  Future<dynamic> getPaymentGateways() async {
    var response = await helper.get(
        url: "${ApiService.getAllPaymentGateway}${AppConfig.paramKey}");
    var res = jsonDecode(response);
    return res;
  }
}
