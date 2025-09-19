import 'package:flutter/material.dart';

class FloodResilienceScreen extends StatelessWidget {
  const FloodResilienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Flood-Resilient Waste Handling')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Before Floods', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _bullet('Elevate waste storage; seal bins against water ingress.'),
          _bullet('Avoid stockpiling hazardous items in flood zones.'),
          const SizedBox(height: 16),
          Text('During Floods', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _bullet('Do not dump into waterways; secure bags.'),
          _bullet('Coordinate with local authorities for emergency collection.'),
          const SizedBox(height: 16),
          Text('After Floods', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _bullet('Segregate promptly to speed up community clean-ups.'),
          _bullet('Disinfect containers and surfaces in contact with floodwater.'),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, size: 18, color: Colors.orange),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
