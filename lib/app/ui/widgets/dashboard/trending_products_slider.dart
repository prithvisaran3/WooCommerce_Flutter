import 'package:flutter/material.dart';

import 'dart:math' as math;

class UpperContainer extends StatelessWidget {
  List<String> myImages = [
    "assets/images/upper_two.png",
    "assets/images/upper_one.png",
    "assets/images/upper_three.png"
  ];
  int giveIndex;
  UpperContainer({Key? key, required this.giveIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),

      // height: 250,
      // width: 380,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white70, width: 3),
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(31, 30, 30, 1),
            Color.fromRGBO(219, 57, 12, 1),
            // Color.fromRGBO(154, 137, 114, 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.8, 0.3],
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(25, 8, 0, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New Realease",
                  style: TextStyle(),
                ),
                Text(
                  "Nike Air\nMax 90",
                  style: TextStyle()
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Shop Now $giveIndex",
                    style: TextStyle(
                    )
                  ),
                ),
              ],
            ),
          ),
          Image.network("https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/350da6ea-c22d-420b-8f0f-6f13bced759a/pegasus-39-road-running-shoes-kmZSD6.png"),
        ],
      ),
    );
  }
}
