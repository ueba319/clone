import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MapView extends StatelessWidget {
  final double latitude;
  final double longitude;

  const MapView({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    // プラットフォームビューのタイプを指定
    const String viewType = 'map';
    // 位置情報を元に地図を更新

    if (Platform.isIOS) {
      return UiKitView(
        viewType: viewType,
        // 位置情報を渡すためのパラメータを追加
        creationParams: <String, dynamic>{
          'latitude': latitude,
          'longitude': longitude,
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (Platform.isAndroid) {
      return AndroidView(
        viewType: viewType,
        // 位置情報を渡すためのパラメータを追加
        creationParams: <String, dynamic>{
          'latitude': latitude,
          'longitude': longitude,
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else {
      throw Exception("対応していないOS");
    }
  }
}
