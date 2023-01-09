import 'package:flutter/material.dart';
import 'package:lms_app/_widgets/network_image.dart';
import 'package:lms_app/_widgets/sliding_card.dart';
import 'package:lms_app/features/lesson_detail/lesson_detail_page.dart';
import 'package:lms_app/models/lesson.dart';
import 'package:lms_app/utils/date_util.dart';
import 'package:provider/provider.dart';

import '../../utils/string_util.dart';
import 'viewmodel/lesson_viewmodel.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({super.key});
  static const route = "/lesson";
  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  final pageController = PageController(viewportFraction: 0.8);

  @override
  void initState() {
    super.initState();
    Provider.of<LessonViewModel>(context, listen: false).getPastLesson();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext pContext) {
    final imageSize = MediaQuery.of(pContext).size.height * 0.3;
    return Center(
      child: Consumer(builder: ((context, LessonViewModel vm, child) {
        return SizedBox(
          height: 350,
          child: PageView.builder(
            controller: pageController,
            itemCount: vm.pastLessons.length,
            itemBuilder: (context, index) {
              final item = vm.pastLessons[index];
              return InkWell(
                onTap: () => onClickItem(context, item),
                child: SlidingCard(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(32)),
                        child: NetWorkImage(
                          url: getLessonCover(item.lessonId!),
                          height: imageSize,
                          boxFit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                          child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(32),
                              bottomRight: Radius.circular(32)),
                          color: Colors.blue.shade400,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              item.title?.en ?? "Unknow",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              item.dateStart != null
                                  ? formatLessonDate(item.dateStart!)
                                  : "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white),
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              );
            },
          ),
        );
      })),
    );
  }

  onClickItem(BuildContext context, Lesson item) {
    Navigator.of(context)
        .pushNamed(LessonDetailPage.route, arguments: {"lessonId": item.id});
  }
}
