import 'package:flutter/material.dart';
import 'package:lms_app/_widgets/loading.dart';
import 'package:lms_app/base/viewmodel/base_viewmodel.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final T Function(BuildContext) vmBuilder;
  final Widget Function(
    BuildContext,
  ) builder;

  const BaseView({super.key, required this.vmBuilder, required this.builder});

  @override
  State<BaseView> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (BuildContext c) => widget.vmBuilder(c),
      builder: (BuildContext pContext, child) {
        return widget.builder(pContext);
      },
      child: const Loading(),
    );
  }
}
