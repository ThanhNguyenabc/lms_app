import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS || Platform.isMacOS) {
      return const CupertinoActivityIndicator(
        color: Colors.purple,
        radius: 16,
      );
    }
    return const CircularProgressIndicator(
      color: Colors.purple,
    );
  }
}
