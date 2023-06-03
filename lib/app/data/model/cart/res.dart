class CartResponseModel {
  dynamic status;
  List<Datum>? data;

  CartResponseModel({
    this.status,
    this.data,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) =>
      CartResponseModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  dynamic productId;
  dynamic productName;
  dynamic productRegularPrice;
  dynamic productSalePrice;
  dynamic thumbnail;
  dynamic qty;
  dynamic lineSubtotal;
  dynamic lineTotal;

  Datum({
    this.productId,
    this.productName,
    this.productRegularPrice,
    this.productSalePrice,
    this.thumbnail,
    this.qty,
    this.lineSubtotal,
    this.lineTotal,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        productId: json["product_id"],
        productName: json["product_name"],
        productRegularPrice: json["product_regular_price"],
        productSalePrice: json["product_sale_price"],
        thumbnail: json["thumbnail"],
        qty: json["qty"],
        lineSubtotal: json["line_subtotal"],
        lineTotal: json["line_total"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "product_regular_price": productRegularPrice,
        "product_sale_price": productSalePrice,
        "thumbnail": thumbnail,
        "qty": qty,
        "line_subtotal": lineSubtotal,
        "line_total": lineTotal,
      };
}
