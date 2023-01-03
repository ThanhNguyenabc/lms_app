import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lms_app/_widgets/sliding_card.dart';
import 'package:lms_app/api/app_dio.dart';
import 'package:lms_app/base/view/base_view.dart';
import 'package:lms_app/service_locator.dart';
import 'package:provider/provider.dart';

import 'viewmodel/lesson_viewmodel.dart';

class LessonA extends StatelessWidget {
  const LessonA({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      vmBuilder: (_) => getIt<LessonViewModel>(),
      builder: ((p0) {
        return const LessonPage();
      }),
    );
  }
}

class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

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
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.height * 0.3;
    return Center(
      child: Consumer(builder: ((context, LessonViewModel vm, child) {
        return SizedBox(
          height: 350,
          child: PageView.builder(
            controller: pageController,
            itemCount: vm.pastLessons.length,
            itemBuilder: (context, index) {
              final item = vm.pastLessons[index];
              return SlidingCard(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(32)),
                      child: Image.network(
                        "$baseURL/content/lessons/${item.lessonId}/cover.png",
                        height: imageSize,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            height: imageSize,
                          );
                        },
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
                                ? DateFormat("E, MMM dd, HH:mm")
                                    .format(item.dateStart!)
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
              );
            },
          ),
        );
      })),
    );
  }
}
