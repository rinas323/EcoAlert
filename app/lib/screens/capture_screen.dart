import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/report.dart';
import '../store/report_store.dart';

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({super.key});

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  bool _isWorking = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _ensurePermissions() async {
    final locEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locEnabled) {
      await Geolocator.openLocationSettings();
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission permanently denied');
    }
  }

  Future<Position> _getPosition() async {
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<File> _persistMedia(XFile xfile) async {
    final dir = await getApplicationDocumentsDirectory();
    final ext = xfile.name.split('.').last;
    final newPath = '${dir.path}/${const Uuid().v4()}.$ext';
    final file = File(newPath);
    await file.writeAsBytes(await xfile.readAsBytes());
    return file;
  }

  Future<void> _capture({required bool isVideo}) async {
    if (_isWorking) return;
    setState(() => _isWorking = true);
    try {
      await _ensurePermissions();
      final position = await _getPosition();

      final XFile? picked = isVideo
          ? await _picker.pickVideo(source: ImageSource.camera)
          : await _picker.pickImage(source: ImageSource.camera, imageQuality: 85);
      if (picked == null) return;

      final saved = await _persistMedia(picked);

      final report = Report(
        id: const Uuid().v4(),
        latitude: position.latitude,
        longitude: position.longitude,
        createdAt: DateTime.now(),
        wasteType: WasteType.other,
        mediaPath: saved.path,
        isVideo: isVideo,
      );

      if (!mounted) return;
      context.read<ReportStore>().addReport(report);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Report saved locally')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed: $e')),
      );
    } finally {
      if (mounted) setState(() => _isWorking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(backgroundColor: Colors.green.shade100, child: const Icon(Icons.camera_alt, color: Colors.green)),
                    const SizedBox(width: 12),
                    const Expanded(child: Text('Capture a photo or video of a waste issue near you.')), 
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: _isWorking ? null : () => _capture(isVideo: false),
                        icon: const Icon(Icons.photo_camera),
                        label: const Text('Capture Photo'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _isWorking ? null : () => _capture(isVideo: true),
                        icon: const Icon(Icons.videocam),
                        label: const Text('Capture Video'),
                      ),
                    ),
                  ],
                ),
                if (_isWorking) const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Tip: Ensure good lighting for better classification accuracy.'),
          ),
        ),
      ],
    );
  }
}
