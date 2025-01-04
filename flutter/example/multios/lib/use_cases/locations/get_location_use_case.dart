import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/locations/location_repository_provider.dart';

part 'get_location_use_case.g.dart';

@riverpod
Future<Location> getLocationUseCase(GetLocationUseCaseRef ref) async {
  return await ref.read(locationRepositoryProvider).get();
}
