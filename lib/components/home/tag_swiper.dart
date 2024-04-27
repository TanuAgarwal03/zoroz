import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class TagSwiper extends StatelessWidget {
  const TagSwiper({ super.key });

  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Theme.of(context).cardColor,
      height: 40,
      child: Marquee(
        text: 'Deal of the day      🔥Hot Deals      Best Sellers      New Arrivals',
        style: Theme.of(context).textTheme.titleSmall,
        scrollAxis: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        blankSpace: 15.0,
        velocity: 100.0,
        pauseAfterRound: const Duration(seconds: 1),
        startPadding: 15.0,
        accelerationDuration: const Duration(seconds: 5),
        accelerationCurve: Curves.linear,
        decelerationDuration: const Duration(milliseconds: 1000),
        decelerationCurve: Curves.easeOut,
      ),
    );
  }
}