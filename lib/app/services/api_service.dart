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

  // static const addCart = "https://chandransteelsonline.com/wp-json/wc/store/cart/add-item";
  // static const getCart = "https://chandransteelsonline.com/wp-json/wc/store/cart";

  //dashboard
  static const getDashboard = "${AppConfig.storeUrl}woocommerce/get-dashboard";

  //wishList
  static const getWishList = "${AppConfig.storeUrl}wishlist/get-wishlist";

  //profile
  static const getProfile = "${AppConfig.baseUrl}customers/";

  //orders
static const getOrders = "${AppConfig.baseUrl}orders?";
}
