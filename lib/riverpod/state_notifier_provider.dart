import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_example/model/shopping_item_model.dart';

// 6. 위젯에서 사용하기 위해 Provider로 만들기
// StateNotifierProvider : StateNotifier class를 상속 받는 클래스를 Provider로 만들어주는 class
// <StateNotifier 상속받은 클래스, 클래스가 관리하는 상태 타입>
final shoppingListProvider =
    StateNotifierProvider<ShoppingListNotifier, List<ShoppingItemModel>>(
  (ref) => ShoppingListNotifier(), // 인스턴스화
);

// 1. StateNotifier 클래스를 extends하고
// 2. 상태관리할 타입이 어떤 타입인지 지정 <List<ShoppingItemModel>>
class ShoppingListNotifier extends StateNotifier<List<ShoppingItemModel>> {
  // 3. 생성자를 만들 때 반드시 초기화 하는 값 지정 []
  ShoppingListNotifier()
      : super([
          ShoppingItemModel(
            name: '김치',
            quantity: 3,
            hasBought: false,
            isSpicy: true,
          ),
          ShoppingItemModel(
            name: '라면',
            quantity: 5,
            hasBought: false,
            isSpicy: true,
          ),
          ShoppingItemModel(
            name: '삼겹살',
            quantity: 10,
            hasBought: false,
            isSpicy: false,
          ),
          ShoppingItemModel(
            name: '수박',
            quantity: 2,
            hasBought: false,
            isSpicy: false,
          ),
          ShoppingItemModel(
            name: '카스테라',
            quantity: 5,
            hasBought: false,
            isSpicy: false,
          ),
        ]);

  // 4. 상태 변경하는 함수 작성
  void toggleHasBought({required String name}) {
    // 5. StateNotifier에서 제공하는 state의 값은 super에서 초기화한 값으로 들어간다
    state = state
        .map((e) => e.name == name
            ? ShoppingItemModel(
                name: e.name,
                quantity: e.quantity,
                hasBought: !e.hasBought,
                isSpicy: e.isSpicy,
              )
            : e)
        .toList();
  }
}
