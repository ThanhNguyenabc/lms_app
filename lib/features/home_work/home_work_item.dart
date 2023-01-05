import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../utils/string_util.dart';

class HomeworkItem extends StatelessWidget {
  HomeworkItem(
      {super.key,
      required this.title,
      required this.chartData,
      required this.imagePath}) {
    for (var num in chartData) {
      total += num;
    }
  }

  double total = 0;
  final String title;
  final String imagePath;
  final List<int> chartData;
  final double boxHeight = 200;

  double getPercentage(value) {
    if (total <= 0) return 0;
    return (value / total) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final double coverHeight = boxHeight - 40;
    print(chartData.length);
    return SizedBox(
      height: boxHeight,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Image.network(
                  "$baseURL/$imagePath",
                  height: coverHeight,
                  width: coverHeight,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: coverHeight,
                      width: coverHeight,
                      color: Colors.grey.shade300,
                      child: Center(
                        child: Text(
                          "no image",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                    );
                  },
                ),
                const Spacer(),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          Expanded(
              child: AspectRatio(
            aspectRatio: 1,
            child: chartData.isNotEmpty
                ? RotatedBox(
                    quarterTurns: 3,
                    child: PieChart(
                      PieChartData(sections: [
                        PieChartSectionData(
                            value: getPercentage(chartData[0]),
                            color: Colors.green,
                            title: ""),
                        PieChartSectionData(
                            value: getPercentage(chartData[1]),
                            color: Colors.amber,
                            title: ""),
                        PieChartSectionData(
                            value: getPercentage(chartData[2]),
                            color: Colors.red,
                            title: "")
                      ]),
                    ))
                : Stack(
                    children: [
                      PieChart(
                        PieChartData(sections: [
                          PieChartSectionData(color: Colors.grey.shade400),
                        ]),
                      ),
                      const Center(
                        child: Text(
                          "N/A \n no result",
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
          ))
        ],
      ),
    );
  }
}
