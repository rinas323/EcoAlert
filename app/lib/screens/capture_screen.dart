import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isWorking = false;
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedMedia;
  bool _isVideo = false;

  Future<void> _ensurePermissions() async {
    try {
      final locEnabled = await Geolocator.isLocationServiceEnabled();
      if (!locEnabled) {
        throw Exception('Location services are disabled. Please enable them in settings.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permission permanently denied. Please enable in app settings.');
      }

      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied. Please enable location access.');
      }
    } catch (e) {
      print('Permission error: $e');
      rethrow;
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

  Future<void> _captureMedia({required bool isVideo}) async {
    try {
      final XFile? picked = isVideo
          ? await _picker.pickVideo(source: ImageSource.camera)
          : await _picker.pickImage(source: ImageSource.camera, imageQuality: 85);

      if (picked != null && mounted) {
        setState(() {
          _selectedMedia = picked;
          _isVideo = isVideo;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Camera error: $e')),
        );
      }
    }
  }

  Future<void> _submitReport() async {
    if (_isWorking) return;
    if (_selectedMedia == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please capture a photo or video first')),
      );
      return;
    }

    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() => _isWorking = true);

      try {
        await _ensurePermissions();
        final position = await _getPosition();
        final saved = await _persistMedia(_selectedMedia!);
        final formData = _formKey.currentState!.value;

        final report = Report(
          id: const Uuid().v4(),
          latitude: position.latitude,
          longitude: position.longitude,
          createdAt: DateTime.now(),
          wasteType: WasteType.other,
          mediaPath: saved.path,
          isVideo: _isVideo,
          municipality: formData['municipality'],
          name: formData['name'],
          contact: formData['contact'],
          isAnonymous: formData['isAnonymous'] ?? false,
        );

        if (!mounted) return;
        context.read<ReportStore>().addReport(report);

        // Reset form and media
        setState(() {
          _selectedMedia = null;
          _isVideo = false;
        });
        _formKey.currentState?.reset();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Report submitted successfully!')),
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed: $e')),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isWorking = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade50, Colors.blue.shade50],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(Icons.report_problem, size: 48, color: Colors.green.shade600),
                  const SizedBox(height: 12),
                  Text(
                    'Report Waste Issue',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Help keep Kerala clean by reporting waste issues',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.green.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Sender Information
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.blue.shade600),
                        const SizedBox(width: 8),
                        Text("Sender's Information", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    FormBuilderTextField(
                      name: 'name',
                      decoration: const InputDecoration(
                        labelText: 'Name (Optional)',
                        hintText: 'Enter your name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'contact',
                      decoration: const InputDecoration(
                        labelText: 'Contact (Optional)',
                        hintText: 'Phone or email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.contact_phone),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FormBuilderCheckbox(
                      name: 'isAnonymous',
                      initialValue: false,
                      title: const Text('Stay Anonymous'),
                      decoration: const InputDecoration(border: InputBorder.none),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Location Information
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.orange.shade600),
                        const SizedBox(width: 8),
                        Text('Location Information', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    FormBuilderDropdown<String>(
                      name: 'municipality',
                      decoration: const InputDecoration(
                        labelText: 'Municipality *',
                        hintText: 'Select your municipality',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.apartment),
                      ),
                      items: const [
                        "Thiruvananthapuram Corporation",
                        "Kochi Municipal Corporation", 
                        "Kozhikode Corporation",
                        "Alappuzha Municipality",
                        "Kollam Corporation",
                        "Thrissur Corporation",
                        "Palakkad Municipality",
                        "Malappuram Municipality",
                      ].map((municipality) => DropdownMenuItem(
                        value: municipality,
                        child: Text(municipality),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Media Capture
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.camera_alt, color: Colors.purple.shade600),
                        const SizedBox(width: 8),
                        Text('Evidence', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // Media Preview
                    if (_selectedMedia != null) ...[
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: _isVideo
                              ? const Center(child: Icon(Icons.play_circle_filled, size: 64, color: Colors.red))
                              : Image.file(File(_selectedMedia!.path), fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(_isVideo ? Icons.videocam : Icons.photo, color: Colors.green),
                          const SizedBox(width: 8),
                          Expanded(child: Text(_selectedMedia!.name)),
                          IconButton(
                            onPressed: () => setState(() => _selectedMedia = null),
                            icon: const Icon(Icons.close, color: Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                    
                    // Capture Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _captureMedia(isVideo: false),
                            icon: const Icon(Icons.photo_camera),
                            label: const Text('Photo'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: Colors.blue.shade600,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _captureMedia(isVideo: true),
                            icon: const Icon(Icons.videocam),
                            label: const Text('Video'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: Colors.red.shade600,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _isWorking ? null : _submitReport,
                icon: _isWorking 
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.send),
                label: Text(_isWorking ? 'Submitting...' : 'Submit Report'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Info Card
            Card(
              color: Colors.blue.shade50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Your report will be sent to the selected municipality for action.',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}