class ShoppingItemModel {
  // 이름
  final String name;

  // 개수
  final int quantity;

  // 구매했는지
  final bool hasBought;

  // 매운지
  final bool isSpicy;

  ShoppingItemModel({
    required this.name,
    required this.quantity,
    required this.hasBought,
    required this.isSpicy,
  });

  ShoppingItemModel copyWith({
    // optional로 값을 받고
    String? name,
    int? quantity,
    bool? hasBought,
    bool? isSpicy,
  }) {
    // 입력된 값이 있으면 입력된 값, 없으면(null이면) 기존 값 대입
    return ShoppingItemModel(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      hasBought: hasBought ?? this.hasBought,
      isSpicy: isSpicy ?? this.isSpicy,
    );
  }
}
