import 'package:flutter/material.dart';
import 'package:lms_app/_widgets/indicator.dart';
import 'package:lms_app/_widgets/network_image.dart';
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
  final scrollController = ScrollController();
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    final lessonVM = context.read<LessonViewModel>();
    lessonVM.getListLesson();

    lessonVM.addListener(() {
      if (lessonVM.currentLessonIndex != -1) {
        pageController.jumpToPage(lessonVM.currentLessonIndex);
        updateIndex(lessonVM.currentLessonIndex, lessonVM.lessons.length);
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext pContext) {
    return Consumer(builder: ((context, LessonViewModel vm, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 350,
            child: PageView.builder(
              controller: pageController,
              itemCount: vm.lessons.length,
              onPageChanged: (pageIndex) {
                updateIndex(pageIndex, vm.lessons.length);
              },
              itemBuilder: (context, index) {
                final item = vm.lessons[index];
                double margin = index == currentPageIndex ? 2 : 25;
                return InkWell(
                  onTap: () => onClickItem(context, item),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    margin: EdgeInsets.all(margin),
                    curve: Curves.easeInOutCubic,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(32)),
                      color: Colors.blue.shade400,
                    ),
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 3,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(32)),
                            child: NetWorkImage(
                              url: getLessonCover(item.lessonId!),
                              boxFit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          item.title?.en ?? "Unknow",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          item.dateStart != null
                              ? formatLessonDate(item.dateStart!)
                              : "",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 10,
            width: 80,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                controller: scrollController,
                itemBuilder: (context, index) {
                  return Indicator(isActive: index == currentPageIndex);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 4,
                  );
                },
                itemCount: vm.lessons.length),
          )
        ],
      );
    }));
  }

  void updateIndex(index, lessonLength) {
    setState(() {
      currentPageIndex = index;
    });

    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      if (index > 3) {
        if (index > lessonLength - 4) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        } else {
          scrollController.jumpTo(index.toDouble() * 7.5);
        }
      } else {
        scrollController.jumpTo(0);
      }
    });
  }

  onClickItem(BuildContext context, Lesson item) {
    Navigator.of(context)
        .pushNamed(LessonDetailPage.route, arguments: {"lessonId": item.id});
  }
}
