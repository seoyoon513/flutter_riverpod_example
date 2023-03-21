import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_example/layout/default_layout.dart';
import 'package:flutter_riverpod_example/riverpod/select_provider.dart';

class SelectProviderScreen extends ConsumerWidget {
  const SelectProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build'); // 빌드 시점 확인
    // .select : value로 받는 것은 상태인데, 특정 상태만 watch할 대상으로 지정할 수 있음
    final state = ref.watch(selectProvider.select((value) => value.isSpicy));

    // listen에도 select 지정 가능
    ref.listen(selectProvider.select((value) => value.hasBought),
        (previous, next) {
      print('next : $next');
    });

    return DefaultLayout(
      title: 'SelectProviderScreen',
      body: SizedBox(
        width: double.infinity, // 가운데 정렬
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
          children: [
            Text(state.toString()),

            /**
             * .select 의 value로 isSpicy를 선택했기 때문에 state 타입은 boolean이다
             * 따라서 아래 state는 모두 주석 처리
             */
            // Text(
            //   state.name,
            // ),
            // Text(
            //   state.isSpicy.toString(),
            // ),
            // Text(
            //   state.hasBought.toString(),
            // ),
            ElevatedButton(
                onPressed: () {
                  ref.read(selectProvider.notifier).toggleIsSpicy();
                },
                child: Text('Spicy Toggle')),
            ElevatedButton(
                onPressed: () {
                  ref.read(selectProvider.notifier).toggleHasBought();
                },
                child: Text('hasBought Toggle'))
          ],
        ),
      ),
    );
  }
}
