import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_example/layout/default_layout.dart';
import 'package:flutter_riverpod_example/riverpod/listen_provider.dart';

// 1. StatefulWidget -> ConsumerStatefulWidget
class ListenProviderScreen extends ConsumerStatefulWidget {
  const ListenProviderScreen({Key? key}) : super(key: key);

  @override
  // 2. State -> ConsumerState
  ConsumerState<ListenProviderScreen> createState() =>
      _ListenProviderScreenState();
}

// 2. State -> ConsumerState
class _ListenProviderScreenState extends ConsumerState<ListenProviderScreen>
    with TickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    // initState() 내부에서 watch를 실행하면 안됨 -> 단발적으로 실행되기 때문
    super.initState();

    controller = TabController(
      length: 10,
      vsync: this,
      initialIndex: ref.read(listenProvider), // 기존 state 값을 초기 index로 적용
    );
  }

  @override
  // ConsumerStatefulWidget은 ref 파라미터를 추가로 받지 않아도 글로벌로 제공됨
  Widget build(BuildContext context) {
    ref.listen<int>(listenProvider, (previous, next) {
      // previous : 기존 상태 / next : 다음 상태
      print(previous);
      print(next);
      if (previous != next) {
        controller.animateTo(next); // 2. controller와 연동 -> 원하는 tab의 index로 이동
      }
    });

    return DefaultLayout(
      title: 'ListenProviderScreen',
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: List.generate(
          10,
          (index) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(index.toString()),
              ElevatedButton(
                onPressed: () {
                  // 1. 버튼을 누를 때마다 state 값 update
                  ref
                      .read(listenProvider.notifier)
                      .update((state) => state == 10 ? 10 : state + 1);
                },
                child: Text('다음'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(listenProvider.notifier)
                      .update((state) => state == 0 ? 0 : state - 1);
                },
                child: Text('뒤로'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
