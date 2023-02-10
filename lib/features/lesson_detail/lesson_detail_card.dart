import 'package:flutter/material.dart';
import 'package:lms_app/utils/constants.dart';

class LessonDetailCard extends StatelessWidget {
  const LessonDetailCard(
      {super.key, required this.cardTitle, required this.child});
  final String cardTitle;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: defaultCardHeight - 100,
        child: Column(
          children: [
            Container(
              color: Colors.cyan,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  cardTitle,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: child,
              ),
            )
          ],
        )

        // child: ListView(
        //   children: [
        //     Container(
        //       color: Colors.cyan,
        //       width: double.infinity,
        //       padding: const EdgeInsets.all(8),
        //       child: Center(
        //         child: Text(
        //           cardTitle,
        //           style: Theme.of(context)
        //               .textTheme
        //               .titleLarge
        //               ?.copyWith(color: Colors.white),
        //         ),
        //       ),
        //     ),
        //     const SizedBox(
        //       height: 8,
        //     ),
        //     child
        //   ],
        // ),
        // child: Column(
        //   mainAxisSize: MainAxisSize.min,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Container(
        //       color: Colors.cyan,
        //       width: double.infinity,
        //       padding: const EdgeInsets.all(8),
        //       child: Center(
        //         child: Text(
        //           cardTitle,
        //           style: Theme.of(context)
        //               .textTheme
        //               .titleLarge
        //               ?.copyWith(color: Colors.white),
        //         ),
        //       ),
        //     ),
        //     const SizedBox(
        //       height: 8,
        //     ),
        //     Expanded(child: child)
        //   ],
        // ),
        );
  }
}
