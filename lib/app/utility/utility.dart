import 'package:intl/intl.dart';
import 'package:steels/app/controller/coupon.dart';
import 'package:url_launcher/url_launcher.dart';

calculateDiscount({regularPrice, salePrice}) {
  if (regularPrice != null && salePrice != null) {
    var regular = regularPrice;
    var sale = salePrice != "" ? salePrice : regularPrice;
    if (regular == 0 && sale == 0) {
      return 0;
    } else {
      var discount = regular - sale;
      var disPercent = (discount / regular) * 100;
      return disPercent.round();
    }
  }
}

calculateCouponPrice({price, couponDiscount}) {
  var coupon = double.parse(couponDiscount);
  var couponAmount = price * coupon / 100;
  var afterCouponPrice = price - couponAmount;
  CouponController.to.afterCouponPrice = afterCouponPrice.toString();
  CouponController.to.couponPercentage =
      couponDiscount.toString().replaceAll('.00', '');
  return couponAmount.toString();
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

openBrowser({required url}) async {
  if (!await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}
