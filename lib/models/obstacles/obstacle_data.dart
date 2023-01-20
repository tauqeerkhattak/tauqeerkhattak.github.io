import '../../utils/assets.dart';

class ObstacleData {
  final double? yPosition;
  final Duration? speed;
  final String? image;

  ObstacleData({
    this.yPosition,
    this.speed,
    this.image,
  });

  factory ObstacleData.fromJson(Map<String, dynamic> data) {
    return ObstacleData(
      yPosition: data['yPosition'],
      speed: Duration(seconds: data['speed'] ?? 12),
      image: data['image'] ?? Assets.rock,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['yPosition'] = yPosition;
    data['speed'] = speed?.inSeconds;
    data['image'] = image;
    return data;
  }

  ObstacleData copyWith({double? yPosition, Duration? speed, String? image}) {
    return ObstacleData(
      yPosition: yPosition ?? this.yPosition,
      speed: speed ?? this.speed,
      image: image ?? this.image,
    );
  }
}
