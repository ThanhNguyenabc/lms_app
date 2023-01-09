import 'package:flutter/material.dart';
import 'package:lms_app/_widgets/loading.dart';
import 'package:lms_app/_widgets/network_image.dart';
import 'package:lms_app/_widgets/no_data_found.dart';
import 'package:lms_app/base/view/base_view.dart';
import 'package:lms_app/features/next_lesson/next_lesson_viewmodel.dart';
import 'package:lms_app/service_locator.dart';
import 'package:lms_app/utils/string_util.dart';
import 'package:provider/provider.dart';

import '../auth/viewmodel/auth_viewmodel.dart';

class NextLessonPage extends StatefulWidget {
  const NextLessonPage({super.key});

  @override
  State<NextLessonPage> createState() => _NextLessonPageState();
}

class _NextLessonPageState extends State<NextLessonPage> {
  final NextLessonViewModel viewModel = getIt.get<NextLessonViewModel>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.getNextLesson(context.read<AuthViewModel>().currentUser!.id!);
    return BaseView(
        vmBuilder: (_) => viewModel,
        builder: ((pContext) {
          return Consumer(
              builder: ((context, NextLessonViewModel value, child) {
            if (viewModel.data != null) {
              if (viewModel.data?.isHasData() == false) {
                return const NoDataFound();
              }
              return ListView(
                children: [
                  Text(
                    "Your next lesson",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Stack(
                    children: [
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.1), BlendMode.srcOver),
                        child: NetWorkImage(
                          url: getLessonCover(viewModel.data?.lessonId ?? ""),
                          height: 250,
                          boxFit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        left: 16,
                        bottom: 24,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              viewModel.data?.subtitle ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(fontSize: 34, color: Colors.white),
                            ),
                            Text(
                              viewModel.data?.dateIn ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(fontSize: 16, color: Colors.white),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: backgroundColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Introduction",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 16, bottom: 8),
                          child: Text("In this lesson you will learn to:"),
                        ),
                        ...?viewModel.data?.aims?.map((e) => Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(e),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: backgroundColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Time",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(viewModel.data?.date ?? ''),
                        ),
                        Text("with: ${viewModel.data?.teacher ?? ''}")
                      ],
                    ),
                  )
                ],
              );
            }
            return const Center(child: Loading());
          }));
        }));
  }
}
