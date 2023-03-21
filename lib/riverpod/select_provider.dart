import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_example/model/shopping_item_model.dart';

// Provider 생성
final selectProvider = StateNotifierProvider<SelectNotifier, ShoppingItemModel>(
    (ref) => SelectNotifier(),
);

class SelectNotifier extends StateNotifier<ShoppingItemModel> {
  SelectNotifier()
      : super(ShoppingItemModel(
          name: '김치',
          quantity: 3,
          hasBought: false,
          isSpicy: true,
        ));

  toggleHasBought() {
    // state = ShoppingItemModel(
    //     name: state.name,
    //     quantity: state.quantity,
    //     hasBought: !state.hasBought,
    //     isSpicy: state.isSpicy
    // );

    state = state.copyWith(hasBought: !state.hasBought);
  }

  toggleIsSpicy() {
    // state = ShoppingItemModel(
    //     name: state.name,
    //     quantity: state.quantity,
    //     hasBought: state.hasBought,
    //     isSpicy: !state.isSpicy
    // );

    state = state.copyWith(isSpicy: !state.isSpicy);
  }
}
