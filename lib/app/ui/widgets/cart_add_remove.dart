import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/font_size.dart';
import 'common/text.dart';

class CartAddRemove extends StatefulWidget {
  CartAddRemove(
      {Key? key,
      required this.lowerLimit,
      required this.upperLimit,
      required this.stepValue,
      this.value,
      required this.iconSize,
      required this.onChanged})
      : super(key: key);
  final int lowerLimit;
  final int upperLimit;
  final int stepValue;
  dynamic value;
  final double iconSize;
  final ValueChanged<dynamic> onChanged;

  @override
  State<CartAddRemove> createState() => _CartAddRemoveState();
}

class _CartAddRemoveState extends State<CartAddRemove> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: AppColors.black,
        // boxShadow: [
        //   BoxShadow(
        //       color: AppColors.grey.withOpacity(.3),
        //       blurRadius: 1,
        //       spreadRadius: 1)
        // ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                widget.value = widget.value == widget.lowerLimit
                    ? widget.lowerLimit
                    : widget.value -= widget.stepValue;
                widget.onChanged(widget.value);
              });
            },
            child: const Icon(
              Icons.remove,
              size: 15,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: widget.iconSize,
            child: CommonText(
              text: "${widget.value}",
              textAlign: TextAlign.center,
              style: boldText(fontSize: 16, color: Colors.white),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                widget.value = widget.value == widget.upperLimit
                    ? widget.upperLimit
                    : widget.value += widget.stepValue;
                widget.onChanged(widget.value);
              });
            },
            child: const Icon(
              Icons.add,
              size: 15,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
