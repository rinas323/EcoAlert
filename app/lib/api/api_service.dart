import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../models/report.dart';
import 'api_config.dart';

class ApiService {
  /// Uploads a report with media to backend as multipart/form-data
  /// Returns the parsed response body (if JSON) or raw string.
  static Future<dynamic> uploadReport(Report report) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.createReportPath}');

    final request = http.MultipartRequest('POST', uri);

    // Optional API key header
    if (ApiConfig.apiKeyHeader != null && ApiConfig.apiKey != null) {
      request.headers[ApiConfig.apiKeyHeader!] = ApiConfig.apiKey!;
    }

    // Add form fields (convert all to strings)
    request.fields.addAll({
      'id': report.id,
      'title': report.title ?? '',
      'description': report.description ?? '',
      'latitude': report.latitude.toString(),
      'longitude': report.longitude.toString(),
      'created_at': report.createdAt.toIso8601String(),
      'waste_type': report.wasteType.name, // e.g., 'other'
      'municipality': report.municipality ?? '',
      'name': report.name ?? '',
      'contact': report.contact ?? '',
      'is_anonymous': report.isAnonymous.toString(),
      'is_video': report.isVideo.toString(),
    });

    // Attach media file
    final file = report.mediaFile;
    final mimeType = lookupMimeType(file.path) ?? (report.isVideo ? 'video/mp4' : 'image/jpeg');
    final typeParts = mimeType.split('/');

    final media = await http.MultipartFile.fromPath(
      'media',
      file.path,
      contentType: MediaType(typeParts.first, typeParts.length > 1 ? typeParts[1] : 'octet-stream'),
    );

    request.files.add(media);

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Try parse JSON, else return raw
      try {
        return json.decode(response.body);
      } catch (_) {
        return response.body;
      }
    } else {
      throw HttpException('HTTP ${response.statusCode}: ${response.body}');
    }
  }
}
