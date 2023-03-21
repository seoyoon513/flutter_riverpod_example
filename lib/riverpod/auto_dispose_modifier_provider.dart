import 'package:flutter_riverpod/flutter_riverpod.dart';

// FutuerProvider는 값이 캐싱 되지만  .autoDispose는 자동으로 캐시 삭제 -> 값을 다시 생성
final autoDisposeModifierProvider = FutureProvider.autoDispose<List<int>>((
    ref) async {
  await Future.delayed(Duration(seconds: 2));

  return [1, 2, 3, 4, 5, 6, 7];
});