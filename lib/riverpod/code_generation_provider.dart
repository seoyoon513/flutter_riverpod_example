import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_generation_provider.g.dart';

/**
 * riverpod_generator 쓰는 이유
 * 1) 어떤 Provider를 사용할지 고민할 필요가 없도록 해준다 (Provider, FutureProvider...)
 * 2) Parameter > Family 파라미터를 일반 함수처럼 사용할 수 있도록 해준다
 */

/// 1번 이유
@riverpod
Future<int> gStateFuture(GStateFutureRef ref) async {
  await Future.delayed(Duration(seconds: 3));
  return 10;
}

@Riverpod(
  // autoDispose 해제 설정 (기본값 false)
  keepAlive: true,
)
Future<int> gStateFuture2(GStateFuture2Ref ref) async {
  await Future.delayed(Duration(seconds: 3));
  return 10;
}

/// 2번 이유
// FutureProvider.family<List<int>, int>((ref, data) 에서는 data 외의 추가 파라미터를 받을 수 업음
// 하나의 파라미터에 여러 값을 명시적으로 전달하는 방법은 class를 만들어서 class 타입을 넣어줘야 함 -> 번거로움
// FutureProvider.family<List<int>, Parameter>((ref, data)

// 기존 String을 받는 Provider
final _testProvider = Provider<String>((ref) => 'Hello Code Generation');

// code generation을 생성하여 일반 함수처럼 작성할 수 있음 -> 직관적임
@riverpod
String gState(GStateRef ref) {
  // ref를 파라미터로 받기 위해 'G[함수 이름]Ref' 타입으로 선언
  return 'Hello Code Generation'; // 여기서 반환하는 값이 watch의 대상
}
// gState는 코드제너레이션을 하기 위한 함수를 정의한 것
// 실제 watch할 provider는 g.dart에 있는 gStateProvider


// family 예시
class Parameter {
  final int number1;
  final int number2;

  Parameter({
    required this.number1,
    required this.number2,
  });
}

final _testFamilyProvider = Provider.family<int, Parameter>(
        (ref, parameter) => parameter.number1 * parameter.number2);

@riverpod
int gStateMultiply(GStateMultiplyRef ref, {
  required int number1,
  required int number2
}) {
  return number1 * number2;
}


/// StateNotifier Provider 코드 제너레이션 명시적 구현
@riverpod
class GStateNotifier extends _$GStateNotifier {
  // 초기 상태값 지정
  @override
  int build() {
    return 0;
  }

  increment() {
    state ++;
  }

  decrement() {
    state --;
  }
}