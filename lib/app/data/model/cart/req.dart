
class CartRequestModel {
  dynamic userId;
  List<Product>? products;

  CartRequestModel({
    this.userId,
    this.products,
  });

  factory CartRequestModel.fromJson(Map<String, dynamic> json) =>
      CartRequestModel(
        userId: json["user_id"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  dynamic productId;
  dynamic quantity;

  Product({
    this.productId,
    this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
      };
}
