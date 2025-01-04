import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/locations/location.dart';
import '../../domain/locations/location_repository_provider.dart';
import '../../use_cases/locations/get_location_use_case.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("真逆地図アプリ"),
      ),
      // 1) 位置情報を一度だけ取得します。
      body: const _Body1(),
      // 2) 位置情報を常に更新できるようにします。
      //body: const _Body2(),
    );
  }
}

class _Body1 extends ConsumerWidget {
  const _Body1({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 1) 位置情報を一度だけ取得します。
    final location = ref.watch(getLocationUseCaseProvider);
    return switch (location) {
      AsyncData(:final value) => _Main(
          location: value,
        ),
      AsyncError(:final error, :final stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("読み込みエラー： $error"),
              ElevatedButton(
                //ユーザーが位置情報を許容した後のリトライボタン
                onPressed: () {
                  ref.refresh(getLocationUseCaseProvider);
                },
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
      _ => const Center(
          child: CircularProgressIndicator(),
        ),
    };
  }
}

class _Main extends StatelessWidget {
  const _Main({
    required this.location,
    super.key,
  });

  final Location location;

  @override
  Widget build(BuildContext context) {
    // 緯度は-90度から+90度までの値を取ります。赤道が0度、北極が+90度、南極が-90度
    // 緯度は符号を反転させるのみで逆側になります。
    // double oppositeLatitude = -location.latitude;

    // 経度は-180度から+180度までの値を取ります。本初子午線 を0度として、東方向に180度、西方向に-180度
    // 経度を反転させる には、 180を加算します。ただし、その値が 180度 を超えた場合 360度を引きます。
    // double oppositeLongitude = location.longitude + 180;
    // if (oppositeLongitude > 180) {
    //   oppositeLongitude -= 360;
    // }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Text(
              "現在緯度: ${location.latitude.toStringAsFixed(2)}, 現在経度: ${location.longitude.toStringAsFixed(2)}"),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(16),
        //   child: Text("反転緯度: ${oppositeLatitude.toStringAsFixed(2)}, 反転経度: ${oppositeLongitude.toStringAsFixed(2)}"),
        // ),
        // Expanded(
        //   // MapViewに位置情報を渡して更新
        //   child: MapView(
        //     latitude: location.latitude,
        //     longitude: location.longitude,
        //     // latitude: oppositeLatitude,
        //     // longitude: oppositeLongitude,
        //   ),
        // ),
      ],
    );
  }
}
