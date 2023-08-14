import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader(
      {Key? key, this.isCircle, this.BaseColor, this.HighlightColor})
      : super(key: key);
  final bool? isCircle;
  final Color? BaseColor;
  final Color? HighlightColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Container(
        color: Colors.white,
      ),
      baseColor: BaseColor ?? Colors.white!,
      highlightColor: HighlightColor ?? Colors.grey[50]!,
    );
  }
}
