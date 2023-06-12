import 'package:intl/intl.dart';

calculateDiscount({regularPrice, salePrice}) {
  if (regularPrice != null && salePrice != null) {
    var regular = regularPrice;
    var sale = salePrice != "" ? salePrice : regularPrice;
    var discount = regular - sale;
    var disPercent = (discount / regular) * 100;
    return disPercent.round();
  }
}


String getIsoToLocalTime({required String date}) {
  var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date, true);
  // var localTime = dateTime.toLocal();
  var outputFormat = DateFormat('hh:mm a');
  var outputDate = outputFormat.format(dateTime);
  return outputDate;
}

String getIsoToLocalDate({required String date}) {
  var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date, true);
  // var localTime = dateTime.toLocal();
  var outputFormat = DateFormat('dd-MM-yy');
  var outputDate = outputFormat.format(dateTime);
  return outputDate;
}
