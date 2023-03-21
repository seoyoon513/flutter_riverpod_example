import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_example/layout/default_layout.dart';
import 'package:flutter_riverpod_example/riverpod/future_provider.dart';

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. FutureProvider의 상태는 AsyncValue 타입으로 들어오게 됨
    final AsyncValue state = ref.watch(multipleFutureProvider);

    return DefaultLayout(
      title: 'FutureProviderScreen',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          state.when( // 2. when으로 각 상태 분기
            data: (data) {
              return Text(
                data.toString(),
                textAlign: TextAlign.center,
              );
            }, // loading이 끝나고 데이터가 있을 때
            error: (err, stack) => Text(
              err.toString()
            ),
            loading: () => Center(child: CircularProgressIndicator()),
          )
        ],
      ),
    );
  }
}
