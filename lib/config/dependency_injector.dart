
import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';
import '../repositories/post_repository.dart';
import '../repositories/post_repository_impl.dart';

class DependencyInjector {
  late final ApiService apiService;
  late final UserRepository userRepository;
  late final PostRepository postRepository;

  DependencyInjector() {
    apiService = ApiService();

    userRepository = UserRepositoryImpl(
      apiService: apiService,
    );

    postRepository = PostRepositoryImpl(
      apiService: apiService,
    );
  }
}

class DependencyInjectorScope extends InheritedWidget {
  final DependencyInjector dependencies;

  const DependencyInjectorScope({
    super.key,
    required this.dependencies,
    required super.child,
  });

  static DependencyInjector of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<
        DependencyInjectorScope>();

    assert(
      scope != null,
      'DependencyInjectorScope tidak ditemukan.',
    );

    return scope!.dependencies;
  }

  @override
  bool updateShouldNotify(
    DependencyInjectorScope oldWidget,
  ) {
    return dependencies != oldWidget.dependencies;
  }
}
