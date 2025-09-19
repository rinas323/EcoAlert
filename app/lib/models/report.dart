import 'dart:io';

enum WasteType {
  plastic,
  organic,
  hazardous,
  other,
}

class Report {
  final String id;
  final String? title;
  final String? description;
  final double latitude;
  final double longitude;
  final DateTime createdAt;
  final WasteType wasteType;
  final String mediaPath; // local file path
  final bool isVideo;

  const Report({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.wasteType,
    required this.mediaPath,
    this.isVideo = false,
    this.title,
    this.description,
  });

  String get shortTypeLabel => wasteType.name;

  File get mediaFile => File(mediaPath);
}
