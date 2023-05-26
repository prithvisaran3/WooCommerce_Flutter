import '../config/config.dart';

class ApiService {
  //auth
  static const register = "${AppConfig.baseUrl}customers";
  static const login = AppConfig.tokenUrl;

  //categories
  static const getCategories =
      "${AppConfig.baseUrl}products/categories${AppConfig.paramKey}";

  //products
  static const getProducts =
      "${AppConfig.baseUrl}products${AppConfig.paramKey}";

  //cart
  static const addCart = "${AppConfig.baseUrl}addtocart";
  static const getCart = "${AppConfig.baseUrl}cart";
}