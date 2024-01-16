
import 'package:project_setup/core/exception/failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T) data;
  
  const AsyncValueWidget({
    Key? key,
    required this.value,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data, 
      error: (error, stackTrace) {
        final failure = error as Failure;
        return Center(
          child: Text(failure.message),
        );
      }, 
      loading: () {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}