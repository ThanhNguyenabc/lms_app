import 'package:flutter/material.dart';
import 'package:lms_app/_widgets/network_image.dart';
import 'package:lms_app/_widgets/video.dart';
import 'package:lms_app/base/view/base_view.dart';
import 'package:lms_app/features/home_work/lesson_content_item.dart';
import 'package:lms_app/features/lesson_detail/lesson_detail_card.dart';
import 'package:lms_app/features/lesson_detail/lesson_detail_viewmodel.dart';
import 'package:lms_app/service_locator.dart';
import 'package:lms_app/utils/constants.dart';
import 'package:provider/provider.dart';

import 'rating_item.dart';

class LessonDetailPage extends StatefulWidget {
  const LessonDetailPage({super.key, required this.params});
  static const route = "/lesson_detail";
  final Map<String, String?> params;
  @override
  State<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  @override
  Widget build(BuildContext context) {
    final title = widget.params["title"] ?? "";
    final lessonId = widget.params["lessonId"] ?? "";

    return Scaffold(
        appBar: AppBar(
            title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white),
        )),
        body: BaseView(
            vmBuilder: ((p0) => getIt.get<LessonDetailViewModel>()),
            builder: ((pContext) {
              pContext.read<LessonDetailViewModel>().getLessonDetail(lessonId);
              return Consumer(
                  builder: ((context, LessonDetailViewModel vm, child) {
                final coreSkill = vm.lessonDetail?.assessment?.coreSkill;

                final lessonAimItems = <RatingItem>[];
                vm.lessonDetail?.assessment?.outcomes?.forEach((key, value) {
                  if (key.isNotEmpty) {
                    lessonAimItems.add(RatingItem(
                        item:
                            Rating(rate: int.parse(value ?? "0"), text: key)));
                  }
                });

                final List<Widget> homeworkItems = List<Widget>.from(
                    vm.lessonDetail?.content?.entries.map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: LessonContentItem(
                                data: item.value,
                                itemName: item.key,
                              ),
                            )) ??
                        {});
                final widgetItems = [
                  LessonDetailCard(
                      cardTitle: "Assessment",
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...lessonAimItems,
                          SizedBox(
                            height: skillsHeight,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RatingItem(
                                      item: Rating(
                                          rate: int.parse(
                                              coreSkill?.speaking ?? "0"),
                                          text: "Speaking")),
                                  RatingItem(
                                      item: Rating(
                                          rate: int.parse(
                                              coreSkill?.listening ?? "0"),
                                          text: "Listening")),
                                  RatingItem(
                                      item: Rating(
                                          rate: int.parse(
                                              coreSkill?.writing ?? "0"),
                                          text: "Writing")),
                                  RatingItem(
                                      item: Rating(
                                          rate: int.parse(
                                              coreSkill?.reading ?? "0"),
                                          text: "Reading")),
                                ]),
                          )
                        ],
                      )),
                  LessonDetailCard(
                      cardTitle: "Homework",
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [...homeworkItems],
                      )),
                  LessonDetailCard(
                      cardTitle: "Teacher says:",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...vm.lessonDetail?.assessment?.teacherfeedback
                                  ?.map((comment) => Text(comment,
                                      textAlign: TextAlign.justify,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium))
                                  .toList() ??
                              []
                        ],
                      ))
                ];
                return ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: ((context, index) {
                      return widgetItems[index];
                    }),
                    separatorBuilder: ((context, index) => const SizedBox(
                          height: 16,
                        )),
                    itemCount: widgetItems.length);
              }));
            })));
  }
}
