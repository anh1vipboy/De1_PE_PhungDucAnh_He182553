// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ThemeViewModel)
final themeViewModelProvider = ThemeViewModelProvider._();

final class ThemeViewModelProvider
    extends $AsyncNotifierProvider<ThemeViewModel, Color> {
  ThemeViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeViewModelHash();

  @$internal
  @override
  ThemeViewModel create() => ThemeViewModel();
}

String _$themeViewModelHash() => r'5be71fb561b9e6f3745bf16f482f64d640605174';

abstract class _$ThemeViewModel extends $AsyncNotifier<Color> {
  FutureOr<Color> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Color>, Color>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Color>, Color>,
              AsyncValue<Color>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
