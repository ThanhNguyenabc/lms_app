import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    viewModel
        .getOverallProgress(context.read<AuthViewModel>().currentUser!.id!);
  }

  @override
  Widget build(BuildContext context) {
    print("buildddddd");
    return BaseView(
        vmBuilder: (_) => viewModel,
        builder: ((pContext) {
          return Column(
            children: [
              Text(
                "Overall Progress",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 32,
              ),
              Expanded(
                child: DefaultTabController(
                    length: 4,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.blue,
                          child: const TabBar(
                              indicatorColor: Colors.white,
                              labelColor: Colors.white,
                              tabs: [
                                Tab(
                                  text: "Reading",
                                ),
                                Tab(
                                  text: "Speaking",
                                ),
                                Tab(
                                  text: "Listening",
                                ),
                                Tab(
                                  text: "Writing",
                                )
                              ]),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Expanded(
                            child: TabBarView(children: [
                          buildChart(pContext
                              .watch<OverallProgressViewModel>()
                              .reading),
                          buildChart(pContext
                              .watch<OverallProgressViewModel>()
                              .speaking),
                          buildChart(pContext
                              .watch<OverallProgressViewModel>()
                              .listening),
                          buildChart(pContext
                              .watch<OverallProgressViewModel>()
                              .writing),
                        ]))
                      ],
                    )),
              )
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
