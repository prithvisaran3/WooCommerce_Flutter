import 'dart:convert';

import 'package:steels/app/services/http.dart';

import '../../config/config.dart';
import '../../services/api_service.dart';

class CouponRepository {
  final HttpHelper helper = HttpHelper();

  Future<dynamic> getAllCoupons() async {
    var response = await helper.get(
        url: "${ApiService.getAllCoupons}${AppConfig.paramKey}");
    var res = jsonDecode(response);
    return res;
  }
  Future<dynamic> getCouponByID({required id}) async {
    var response = await helper.get(
        url: "${ApiService.getAllCoupons}/$id${AppConfig.paramKey}");
    var res = jsonDecode(response);
    return res;
  }
}
