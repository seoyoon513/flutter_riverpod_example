import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_example/layout/default_layout.dart';
import 'package:flutter_riverpod_example/model/shopping_item_model.dart';
import 'package:flutter_riverpod_example/riverpod/state_notifier_provider.dart';

class StateNotifierProviderScreen extends ConsumerWidget {
  const StateNotifierProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // shoppingListProvider를 가져올 경우 state를 반환
    final List<ShoppingItemModel> state = ref.watch(shoppingListProvider);

    return DefaultLayout(
        title: 'StateNotifierProviderScreen',
        body: ListView(
          children: state
              .map(
                (e) => CheckboxListTile(
                  title: Text(e.name),
                  value: e.hasBought,
                  onChanged: (value) {
                    // .notifier를 붙일 경우 클래스가 그대로 온다 -> 클래스의 메서드를 실행할 수 있음
                    ref
                        .read(shoppingListProvider.notifier)
                        .toggleHasBought(name: e.name); // 체크박스 누를 때마다 실행
                  },
                ),
              )
              .toList(),
        ));
  }
}
