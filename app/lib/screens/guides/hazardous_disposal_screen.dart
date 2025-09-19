import 'package:flutter/material.dart';
import 'guide_widgets.dart';

class HazardousDisposalScreen extends StatelessWidget {
  const HazardousDisposalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hazardous & Biomedical Waste')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          GuideHeader(
            icon: Icons.warning_amber_rounded,
            title: 'Handle dangerous waste safely',
            subtitle: 'Protect people and environment by following approved disposal practices.',
            accent: Colors.red,
          ),
          SizedBox(height: 12),
          GuideSection(
            title: 'Examples',
            children: [
              Bullet('E-waste, batteries, CFLs/LEDs'),
              Bullet('Paints, solvents, pesticides'),
              Bullet('Biomedical: syringes, dressings, expired medicines'),
            ],
          ),
          SizedBox(height: 12),
          GuideSection(
            title: 'Do’s',
            children: [
              Bullet('Keep separate from regular trash at all times.', color: Colors.green),
              Bullet('Store sharps in puncture-resistant containers.', color: Colors.green),
              Bullet('Use authorized collection centers/hospitals for disposal.', color: Colors.green),
            ],
          ),
          SizedBox(height: 12),
          GuideSection(
            title: 'Don’ts',
            children: [
              Bullet('Do not flush medicines or pour chemicals into drains.', color: Colors.red, icon: Icons.block),
              Bullet('Do not burn—creates highly toxic emissions.', color: Colors.red, icon: Icons.block),
              Bullet('Do not mix with recyclables or organics.', color: Colors.red, icon: Icons.block),
            ],
          ),
        ],
      ),
    );
  }
}
