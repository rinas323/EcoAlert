import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../store/report_store.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<ReportStore>();
    final reports = store.reports;

    if (reports.isEmpty) {
      return const Center(child: Text('No reports yet'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: reports.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final r = reports[index];
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              child: Icon(r.isVideo ? Icons.videocam : Icons.photo, color: Colors.black54),
            ),
            title: Text(r.title ?? r.shortTypeLabel),
            subtitle: Text(
              '${r.latitude.toStringAsFixed(5)}, ${r.longitude.toStringAsFixed(5)} • ${r.createdAt.toLocal()}'.replaceFirst('T', ' '),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        );
      },
    );
  }
}
