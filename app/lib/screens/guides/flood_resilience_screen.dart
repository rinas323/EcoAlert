import 'package:flutter/material.dart';
import 'guide_widgets.dart';

class FloodResilienceScreen extends StatelessWidget {
  const FloodResilienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flood-Resilient Waste Handling')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          GuideHeader(
            icon: Icons.flood,
            title: 'Manage waste through floods',
            subtitle: 'Reduce contamination and speed up recovery with resilient practices.',
            accent: Colors.orange,
          ),
          SizedBox(height: 12),
          GuideSection(
            title: 'Before Floods',
            children: [
              Bullet('Elevate waste storage; seal bins against water ingress.'),
              Bullet('Avoid stockpiling hazardous items in flood zones.'),
            ],
          ),
          SizedBox(height: 12),
          GuideSection(
            title: 'During Floods',
            children: [
              Bullet('Do not dump into waterways; secure bags.'),
              Bullet('Coordinate with local authorities for emergency collection.'),
            ],
          ),
          SizedBox(height: 12),
          GuideSection(
            title: 'After Floods',
            children: [
              Bullet('Segregate promptly to speed up community clean-ups.'),
              Bullet('Disinfect containers and surfaces in contact with floodwater.'),
            ],
          ),
        ],
      ),
    );
  }
}
