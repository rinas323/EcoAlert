import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../store/report_store.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reports = context.watch<ReportStore>().reports;
    final markers = reports
        .map(
          (r) => Marker(
            point: LatLng(r.latitude, r.longitude),
            width: 40,
            height: 40,
            child: const Icon(Icons.location_on, color: Colors.red, size: 32),
          ),
        )
        .toList();

    final center = reports.isNotEmpty
        ? LatLng(reports.last.latitude, reports.last.longitude)
        : const LatLng(10.1632, 76.6413); // Kerala approx

    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            initialCenter: center,
            initialZoom: 9,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
              userAgentPackageName: 'com.ecoalert.kerala',
            ),
            MarkerLayer(markers: markers),
          ],
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: 16,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.red),
                  const SizedBox(width: 8),
                  Expanded(child: Text('map_info_text'.tr())),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
