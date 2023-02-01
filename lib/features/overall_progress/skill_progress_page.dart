import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/_widgets/indicator.dart';
import 'package:lms_app/base/view/base_view.dart';
import 'package:lms_app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:lms_app/features/overall_progress/overall_progress_viewmodel.dart';
import 'package:lms_app/features/overall_progress/progress_line_chart_item.dart';
import 'package:lms_app/service_locator.dart';
import 'package:provider/provider.dart';

class SkillProgressPage extends StatefulWidget {
  const SkillProgressPage({super.key});

  @override
  State<SkillProgressPage> createState() => _SkillProgressPageState();
}

class _SkillProgressPageState extends State<SkillProgressPage> {
  final OverallProgressViewModel viewModel =
      getIt.get<OverallProgressViewModel>();

  final titles = ["Reading", "Speaking", "Listening", "Writing"];

  int _currentIndex = 0;
  final pageController = PageController();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    viewModel
        .getOverallProgress(context.read<AuthViewModel>().currentUser!.id!);
  }

  @override
  void dispose() {
    pageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        vmBuilder: (_) => viewModel,
        builder: ((pContext) {
          return Column(
            children: [
              Expanded(
                child: PageView(
                  onPageChanged: (pageIndex) {
                    if (pageIndex > 3) {
                      scrollController.jumpTo(pageIndex.toDouble() * 7.2);
                    } else {
                      scrollController.jumpTo(0);
                    }

                    setState(() {
                      _currentIndex = pageIndex;
                    });
                  },
                  children: [
                    buildChart(
                        pContext.watch<OverallProgressViewModel>().reading),
                    buildChart(
                        pContext.watch<OverallProgressViewModel>().speaking),
                    buildChart(
                        pContext.watch<OverallProgressViewModel>().listening),
                    buildChart(
                        pContext.watch<OverallProgressViewModel>().writing),
                  ],
                ),
              ),
              Text(
                titles[_currentIndex],
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 10,
                width: 45,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      return Indicator(isActive: index == _currentIndex);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 4,
                      );
                    },
                    itemCount: 4),
              ),
              const SizedBox(height: 16),
            ],
          );
        }));
  }

  Widget buildChart(List<FlSpot> data) {
    return Stack(
      children: [ProgressLineChartItem(spotData: data)],
    );
  }
}
