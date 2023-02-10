import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProgressLineChartItem extends StatelessWidget {
  ProgressLineChartItem({super.key, required this.spotData});
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  final List<FlSpot> spotData;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: LineChart(
          LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                horizontalInterval: 1,
                verticalInterval: 1,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.grey.shade400,
                    strokeWidth: 1,
                  );
                },
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: Colors.grey.shade400,
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      int newValue = value.toInt();
                      String text = "";
                      if (newValue % 2 == 0) {
                        switch (newValue) {
                          case 2:
                            text = "Poor";
                            break;
                          case 4:
                            text = "Mediocre";
                            break;
                          case 6:
                            text = "Average";
                            break;
                          case 8:
                            text = "Good";
                            break;
                          case 10:
                            text = "Great";
                            break;
                          default:
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Text(text,
                            style: Theme.of(context).textTheme.titleMedium),
                      );
                    },
                    reservedSize: 80,
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: Colors.grey.shade400.withOpacity(0.65),
                ),
              ),
              minX: 0,
              maxX: 11,
              minY: 0,
              maxY: 11.7,
              lineBarsData: [
                LineChartBarData(
                  gradient: LinearGradient(
                    colors: gradientColors,
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: gradientColors
                          .map((color) => color.withOpacity(0.35))
                          .toList(),
                    ),
                  ),
                  isCurved: true,
                  preventCurveOverShooting: true,
                  color: Colors.indigoAccent.shade700,
                  barWidth: 6,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  spots: spotData,
                )
              ]),
        ),
      ),
    );
  }
}
