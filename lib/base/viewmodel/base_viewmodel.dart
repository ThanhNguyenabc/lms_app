import 'dart:async';

import 'package:flutter/material.dart';

abstract class BaseViewModel extends ChangeNotifier {
  bool isLoading = false;
  bool isDisposed = false;
  bool isInitializeDone = false;

  FutureOr<void> _initState;

  BaseViewModel() {
    _init();
  }

  Future<void> init() async => {};

  void _init() async {
    isLoading = true;
    _initState = init();
    await _initState;
    isInitializeDone = true;
    isLoading = false;
  }

  changeStatus() => isLoading = !isLoading;

  reloadState() => {if (!isLoading) notifyListeners()};

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  setLoading(bool val) {
    isLoading = val;
    scheduleMicrotask(() {
      if (!isDisposed) notifyListeners();
    });
  }
}
