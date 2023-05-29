import 'dart:convert';
import '../../services/api_service.dart';
import '../../services/http.dart';

class WishListRepository {
  final HttpHelper helper = HttpHelper();

  Future<dynamic> getWishList() async {
    var response =
        await helper.get(url: ApiService.getWishList, isLoginToken: true);
    var res = jsonDecode(response);
    return res;
  }
}
