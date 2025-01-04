import 'package:riverpod_annotation/riverpod_annotation.dart';

import './location_repository.dart';

export 'location.dart';

@riverpod
final locationRepositoryProvider =
    Provider<LocationRepository>((_) => throw UnimplementedError());
