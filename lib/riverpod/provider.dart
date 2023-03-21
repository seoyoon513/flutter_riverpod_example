import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_example/model/shopping_item_model.dart';
import 'package:flutter_riverpod_example/riverpod/state_notifier_provider.dart';

// Proivder 안에 있는 state가 그대로 전달
// final filteredShoppingListProvider = Provider(
//   (ref) => ref.watch(shoppingListProvider),
// );

/// Provider 내부의 Provider
// ref.watch(shoppingListProvider)는 결국 shoppingListProvider의 state를 반환하고
// (ref) => 애로우 함수에 의해 반환되는 값(state)이 Provider에 반환됨

final filteredShoppingListProvider = Provider<List<ShoppingItemModel>>(
  (ref) {
    // 1. 일반 함수로 만들기

    // 3. 값들이 변경될 때마다 Provider 함수가 다시 실행 됨
    final filterState = ref.watch(filterProvider);
    final shoppingListState = ref.watch(shoppingListProvider);

    // 2. Provider 반환값 주기
    // 4. 다시 실행되면서 새로운 값을 만들어 반환
    if (filterState == FilterState.all) {
      return shoppingListState;
    }
    return shoppingListState
        .where((element) => filterState == FilterState.spicy
            ? element.isSpicy
            : !element.isSpicy)
        .toList();
  },
);

enum FilterState {
  // 안매움
  notSpicy,
  // 매움
  spicy,
  // 전부
  all,
}

final filterProvider = StateProvider<FilterState>((ref) => FilterState.all);
