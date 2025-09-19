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

  final String? municipality;
  final String? name;
  final String? contact;
  final bool isAnonymous;

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
    this.municipality,
    this.name,
    this.contact,
    this.isAnonymous = false,
  });

  String get shortTypeLabel => wasteType.name;

  File get mediaFile => File(mediaPath);
}
