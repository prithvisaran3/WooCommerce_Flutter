calculateDiscount({regularPrice, salePrice}) {
  if (regularPrice != null && salePrice != null) {
    var regular = regularPrice;
    var sale = salePrice != "" ? salePrice : regularPrice;
    var discount = regular - sale;
    var disPercent = (discount / regular) * 100;
    return disPercent.round();
  }
}
