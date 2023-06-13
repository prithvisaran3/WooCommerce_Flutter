import 'dart:convert';

import 'package:template/app/config/config.dart';
import 'package:template/app/services/api_service.dart';
import 'package:template/app/services/http.dart';

class ReviewRepository {
  final HttpHelper helper = HttpHelper();

  Future<dynamic> getAllReviews() async {
    var response = await helper.get(url: "${ApiService.getAllReviews}${AppConfig.paramKey}");
    var res = jsonDecode(response);
    return res;
  }

  Future<dynamic> sendReview({required body})async{
    var response=await helper.post(url: "${ApiService.sendReview}${AppConfig.paramKey}", body: body);
    var res=jsonDecode(response);
    return res;
  }
}
