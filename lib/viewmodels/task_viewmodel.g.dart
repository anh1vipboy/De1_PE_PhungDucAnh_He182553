// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TaskViewModel)
final taskViewModelProvider = TaskViewModelProvider._();

final class TaskViewModelProvider
    extends $AsyncNotifierProvider<TaskViewModel, List<Task>> {
  TaskViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskViewModelHash();

  @$internal
  @override
  TaskViewModel create() => TaskViewModel();
}

String _$taskViewModelHash() => r'f8c50af5c8fc421c0bbcbf75d8a0894799ca9434';

abstract class _$TaskViewModel extends $AsyncNotifier<List<Task>> {
  FutureOr<List<Task>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Task>>, List<Task>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Task>>, List<Task>>,
              AsyncValue<List<Task>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
