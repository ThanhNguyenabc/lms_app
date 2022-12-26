import 'package:flutter/material.dart';
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
    return Center(
      child: Consumer(builder: ((context, LessonViewModel vm, child) {
        return SizedBox(
          height: 450,
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
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            height: MediaQuery.of(context).size.height * 0.3,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        item.title?.en ?? "No name",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 16, right: 16),
                      child: Text(
                        item.dateStart ?? "No name",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    )
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
