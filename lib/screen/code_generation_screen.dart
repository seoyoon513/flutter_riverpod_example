import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_example/layout/default_layout.dart';
import 'package:flutter_riverpod_example/riverpod/code_generation_provider.dart';

class CodeGenerationScreen extends ConsumerWidget {
  const CodeGenerationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build'); // 어떤 state가 변경이 돼도 전체 위젯의 build는 다시 호출됨
    final state1 = ref.watch(gStateProvider);
    final state2 = ref.watch(gStateFutureProvider);
    final state3 = ref.watch(gStateFuture2Provider);
    final state4 = ref.watch(gStateMultiplyProvider(
      number1: 10,
      number2: 20,
    ));

    return DefaultLayout(
      title: 'CodeGenerationScreen',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('State1 : $state1'),
          //Text('State2 : $state2'),
          state2.when(
            data: (data) {
              return Text(
                'State2 : $data',
                textAlign: TextAlign.center,
              );
            },
            error: (err, stack) => Text(
              err.toString(),
            ),
            loading: () => Center(
              child: CircularProgressIndicator(),
            ),
          ),
          state3.when(
            data: (data) {
              return Text(
                'State3 : $data',
                textAlign: TextAlign.center,
              );
            },
            error: (err, stack) => Text(
              err.toString(),
            ),
            loading: () => Center(
              child: CircularProgressIndicator(),
            ),
          ),
          Text('State4 : $state4'),
          //_StateFiveWidget(),
          Consumer( // riverpod 제공 함수 -> state가 변해면 Consumer의 builder가 호출됨
            builder: (context, ref, child) {
              print('builder build');
              final state5 = ref.watch(gStateNotifierProvider);
              return Row(
                children: [
                  Text('State5 : $state5'),
                  if (child != null) child, // 2. child로 받아서 쓸 수 있음
                ],
              );
            },
            child: Text('hello'), // 1. child에 넣어준 widget은
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    ref.read(gStateNotifierProvider.notifier).increment();
                  },
                  child: Text('Increment')),
              ElevatedButton(
                  onPressed: () {
                    ref.read(gStateNotifierProvider.notifier).decrement();
                  },
                  child: Text('Increment'))
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // initial한 상태로 돌아감 -> Dispose
              ref.invalidate(gStateNotifierProvider);
            },
            child: Text('Invalidate'),
          )
        ],
      ),
    );
  }
}

// 상위에서 state를 watch하지 않기 때문에 상위 build가 다시 호출되지 않음
// 그렇다면 매번 새로운 위젯을 만들어야 하는가 -> No, 리버팟에서 제공하는 Consumer() 사용
class _StateFiveWidget extends ConsumerWidget {
  const _StateFiveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state5 = ref.watch(gStateNotifierProvider);
    return Text('State5 : $state5');
  }
}
