import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  /**
   * Logger가 포함이 된 ProviderScope 를 옵저빙
   * 즉, ProvideScope 내부의 모든 Provider를 옵저빙할 수 있다
   */

  @override
  // 프로바이더가 업데이트되면 불리는 함수
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    print(
        '[Provider Updated] provider: $provider / pv: $previousValue / nv: $newValue');
  }

  @override
  // 프로바이더 추가되면 불리는 함수
  void didAddProvider(ProviderBase<Object?> provider, Object? value,
      ProviderContainer container) {
    print('[Provider Added] provider: $provider / value: $value');
  }

  @override
  // 프로바이더가 삭제 됐을 때 불리는 함수
  void didDisposeProvider(
      ProviderBase<Object?> provider, ProviderContainer container) {
    print('[Provider Disposed] provider: $provider');
  }
}
