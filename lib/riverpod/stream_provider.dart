import 'package:flutter_riverpod/flutter_riverpod.dart';

final multipleStreamProvider = StreamProvider<List<int>>((ref) async*{
  // 0~9까지의 정수를 반환하는 비동기 스트림
  for (int i = 0; i < 10; i++) {
    await Future.delayed(Duration(seconds: 1));

    // 현재 실행 상태를 중단하고 값을 스트림에 반환
    // return은 함수를 종료하고 반환하지만 yield는 스트림에 값을 반환하고 함수 실행 지속
    yield List.generate(3, (index) => index * i); // 리스트 생성
  }
});