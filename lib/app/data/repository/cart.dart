import 'dart:convert';
import '../../config/config.dart';
import '../../services/api_service.dart';
import '../../services/http.dart';

class CartRepository {
  final HttpHelper helper = HttpHelper();

  Future<dynamic> addCart({required body}) async {
    var response = await helper.post(url: ApiService.addCart, body: body);
    var res = jsonDecode(response);
    return res;
  }

  Future<dynamic> getCart({required userId}) async {
    var response = await helper.get(
        url: "${ApiService.getCart}");
    var res = jsonDecode(response);
    return res;
  }
}
