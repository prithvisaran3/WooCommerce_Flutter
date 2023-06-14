import 'dart:convert';
import 'package:template/app/config/config.dart';
import 'package:template/app/services/api_service.dart';

import '../../services/http.dart';
import '../model/profile.dart';

class ProfileRepository {
  final HttpHelper helper = HttpHelper();

  Future<ProfileRes> getProfile({required userId}) async {
    var response = await helper.get(
        url: "${ApiService.getProfile}$userId${AppConfig.paramKey}");
    var res = ProfileRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<ProfileRes> updateProfile({required userId, required body}) async {
    var response = await helper.put(
        url: "${ApiService.getProfile}$userId${AppConfig.paramKey}",
        body: body,
        tempContentHeader: true);
    var res = ProfileRes.fromMap(jsonDecode(response));
    return res;
  }
}
