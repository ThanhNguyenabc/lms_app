import 'package:flutter/material.dart';
import 'package:lms_app/base/view/base_view.dart';
import 'package:lms_app/features/lesson_detail/lesson_detail_viewmodel.dart';
import 'package:lms_app/service_locator.dart';
import 'package:provider/provider.dart';

import 'assessment_card.dart';

class LessonDetailPage extends StatefulWidget {
  const LessonDetailPage({super.key, required this.lessonId});
  static const route = "/lesson_detail";
  final String lessonId;
  @override
  State<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Lesson detail")),
        body: BaseView(
            vmBuilder: ((p0) => getIt.get<LessonDetailViewModel>()),
            builder: ((pContext) {
              pContext
                  .read<LessonDetailViewModel>()
                  .getLessonDetail(widget.lessonId);
              return Consumer(
                  builder: ((context, LessonDetailViewModel vm, child) {
                final coreSkill = vm.lessonDetail?.assessment?.coreSkill;
                final lessonAimItems = <Rating>[];
                vm.lessonDetail?.assessment?.outcomes?.forEach((key, value) {
                  if (key.isNotEmpty) {
                    lessonAimItems
                        .add(Rating(rate: int.parse(value ?? "0"), text: key));
                  }
                });

                return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemBuilder: ((context, index) {
                      switch (index) {
                        case 0:
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Teacher feedback",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(color: Colors.blue.shade800),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...vm.lessonDetail?.assessment
                                            ?.teacherfeedback
                                            ?.map((comment) => Text(
                                                  comment,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(fontSize: 16),
                                                ))
                                            .toList() ??
                                        []
                                  ],
                                ),
                              ),
                            ],
                          );
                        case 1:
                          return AssessmentCard(
                              items: lessonAimItems,
                              title: "Lesson aims",
                              imagePath: "asset/images/outcome.jpeg");
                        case 2:
                          return AssessmentCard(
                              items: [
                                Rating(
                                    rate: int.parse(coreSkill?.speaking ?? "0"),
                                    text: "Speaking"),
                                Rating(
                                    rate:
                                        int.parse(coreSkill?.listening ?? "0"),
                                    text: "Listening"),
                                Rating(
                                    rate: int.parse(coreSkill?.writing ?? "0"),
                                    text: "Writing"),
                                Rating(
                                    rate: int.parse(coreSkill?.reading ?? "0"),
                                    text: "Reading")
                              ],
                              title: "Core skills",
                              imagePath: "asset/images/core_skill.jpeg");
                      }
                      return const SizedBox();
                    }),
                    separatorBuilder: ((context, index) => const SizedBox(
                          height: 20,
                        )),
                    itemCount: 3);
              }));
            })));
  }
}