import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/models/lesson_content.dart';
import 'package:lms_app/utils/constants.dart';
import '../../utils/string_util.dart';

class LessonContentItem extends StatelessWidget {
  const LessonContentItem(
      {super.key, required this.data, required this.itemName});

  final String itemName;
  final ContentItem? data;
  final chartRadius = 20.0;

  double getPercentage(value) {
    double total = getTotalValue();
    if (total <= 0) return 0;
    return (value / total) * 100;
  }

  double getTotalValue() {
    return data?.chartdata
            ?.reduce((value, element) => value + element)
            .toDouble() ??
        0;
  }

  @override
  Widget build(BuildContext context) {
    final chartData = data?.chartdata;
    return SizedBox(
      height: skillsHeight,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemName.capitalize(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  data?.charttext ?? "",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          AspectRatio(
              aspectRatio: 1,
              child: RotatedBox(
                  quarterTurns: 3,
                  child: Stack(
                    children: [
                      if (chartData != null && chartData.isNotEmpty == true)
                        PieChart(
                          PieChartData(sections: [
                            createPieChartItem(context, Colors.green,
                                getPercentage(chartData[0])),
                            createPieChartItem(context, Colors.amber,
                                getPercentage(chartData[1])),
                            createPieChartItem(context, Colors.red,
                                getPercentage(chartData[2])),
                          ]),
                        )
                      else
                        PieChart(
                          PieChartData(sections: [
                            createPieChartItem(
                                context, Colors.grey.shade400, 1),
                          ]),
                          swapAnimationCurve: Curves.bounceIn,
                        ),
                      Center(
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: SizedBox(
                            width: 80,
                            child: Text(
                              data?.chartsubtext ?? "",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                      )
                    ],
                  )))
        ],
      ),
    );
  }

  PieChartSectionData createPieChartItem(
      BuildContext context, Color color, double? value) {
    return PieChartSectionData(
        radius: chartRadius, value: value, color: color, title: "");
  }
}
