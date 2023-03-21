import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_example/layout/default_layout.dart';
import 'package:flutter_riverpod_example/riverpod/state_provider_screen.dart';

// 1. StatelessWidget -> ConsumerWidget
class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({Key? key}) : super(key: key);

  @override
  // 2. build 함수 안에 WidgetRef 파라미터를 추가로 받는다
  Widget build(BuildContext context, WidgetRef ref) {
    // 3. ref.으로 state에 접근할 수 있다
    // ref.watch : 특정 provider를 바라보고 있다가 그 프로바이더가 변경되면 빌드 함수 재실행
    final provider = ref.watch(numberProvider);
    return DefaultLayout(
      title: 'StateProviderScreen',
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.toString(),
            ),
            ElevatedButton(
              onPressed: () {
                // ref.read : 버튼을 눌렀을 때 단발적으로 실행
                ref.read(numberProvider.notifier).update((state) => state + 1);
              },
              child: Text('up'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => _NextScreen(),
                ));
              },
              child: Text('Next Screen'),
            )
          ],
        ),
      ),
    );
  }
}

// 똑같은 Provider를 watch하고만 있으면 같은 provider를 불러옴으로써 데이터 공유 가능
class _NextScreen extends ConsumerWidget {
  const _NextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(numberProvider); // 동일한 numberProvider
    return DefaultLayout(
      title: 'StateProviderScreen',
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.toString(),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(numberProvider.notifier).update((state) => state + 1);
              },
              child: Text('up'),
            )
          ],
        ),
      ),
    );
  }
}
