import 'dart:async';

import 'package:flutter/services.dart';

import './location_repository.dart';

/// GPSを使った位置情報を取得するための仕組み。
class GpsLocationRepository extends LocationRepository {
  static const platform = MethodChannel('com.example.multios/location');

  // 2) ここに後ほどEventChannelの処置を追加

  /// 1) MethodChannelを使って位置情報を取得します。
  @override
  Future<Location> get() async {
    final String result = await platform.invokeMethod('getLocation');
    final splitted = result.split(',');
    return Location(double.parse(splitted[0]), double.parse(splitted[1]));
  }

  /// 2) EventChannelを使って位置情報を監視します。(後ほど追加)
}
