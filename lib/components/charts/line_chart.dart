import 'package:clickcart/utils/constants/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartView extends StatelessWidget {
  LineChartView({
    super.key,
    Color? mainLineColor,
    Color? belowLineColor,
    Color? aboveLineColor,
  })  : mainLineColor =
            mainLineColor ?? IKColors.primary.withOpacity(1),
        belowLineColor =
            belowLineColor ?? IKColors.primary.withOpacity(.2),
        aboveLineColor =
            aboveLineColor ?? IKColors.primary.withOpacity(0.7);

  final Color mainLineColor;
  final Color belowLineColor;
  final Color aboveLineColor;

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      case 7:
        text = 'Aug';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 2,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: IKColors.text,
        ),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: IKColors.text,
      fontSize: 12,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text('\$${value + 0.5}', style: style)
    );
  }

  @override
  Widget build(BuildContext context) {
    // const cutOffYValue = 0;

    return AspectRatio(
      aspectRatio: 2,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
        ),
        child: LineChart(
          LineChartData(
            lineTouchData: const LineTouchData(enabled: true),
            lineBarsData: [
              LineChartBarData(
                spots: const [
                  FlSpot(0, 4),
                  FlSpot(1, 3.5),
                  FlSpot(2, 4.5),
                  FlSpot(3, 1),
                  FlSpot(4, 4),
                  FlSpot(5, 6),
                  FlSpot(6, 4),
                  FlSpot(7, 6),
                ],
                isCurved: true,
                barWidth: 3,
                color: mainLineColor,
                belowBarData: BarAreaData(
                  show: true,
                  color: belowLineColor,
                  cutOffY: 0,
                  applyCutOffY: true,
                ),
                dotData: const FlDotData(
                  show: false,
                ),
              ),
            ],
            minY: 0,
            titlesData: FlTitlesData(
              show: true,
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 18,
                  interval: 1,
                  getTitlesWidget: bottomTitleWidgets,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  reservedSize: 40,
                  getTitlesWidget: leftTitleWidgets,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 0
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              horizontalInterval: 1,
              verticalInterval: 1,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Theme.of(context).dividerColor,
                  strokeWidth: 1,
                  dashArray:defaultGridLine(0).dashArray,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Theme.of(context).dividerColor,
                  strokeWidth: 1,
                  dashArray:defaultGridLine(0).dashArray,
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}