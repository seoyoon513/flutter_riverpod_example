import 'package:flutter_riverpod/flutter_riverpod.dart';

final multipleFutureProvider = FutureProvider<List<int>>((ref) async {
  await Future.delayed(
    Duration(
      seconds: 2, // 2초 딜레이
    ),
  );

  // 에러 발생시키기
  throw Exception('에러입니다');

  return [1, 2, 3, 4, 5];
});
