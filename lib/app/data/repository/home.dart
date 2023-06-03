import 'dart:convert';
import '../../services/api_service.dart';
import '../../services/http.dart';

class DashboardRepository {
  final HttpHelper helper = HttpHelper();

  Future<dynamic> getCategories() async {
    var response = await helper.get(url: ApiService.getCategories);
    var res = jsonDecode(response);
    return res;
  }

  Future<dynamic> getProducts({params}) async {
    var slug = "";
    if (params != null) {
      slug = params;
    }
    var response = await helper.get(url: "${ApiService.getProducts}$slug");
    var res = jsonDecode(response);
    return res;
  }

  Future<dynamic> getTodayOffersProducts({required tagId}) async {
    var response =
        await helper.get(url: "${ApiService.getProducts}&tag=$tagId");
    var res = jsonDecode(response);
    return res;
  }

  Future<dynamic> getTopSellingProducts({required tagId}) async {
    var response =
        await helper.get(url: "${ApiService.getProducts}&tag=$tagId");
    var res = jsonDecode(response);
    return res;
  }

  Future<dynamic> getDashboard() async {
    var response =
        await helper.get(url: ApiService.getDashboard, isLoginToken: true);
    var res = jsonDecode(response);
    return res;
  }
}
