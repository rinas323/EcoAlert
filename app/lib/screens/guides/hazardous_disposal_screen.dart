import 'package:flutter/material.dart';

class HazardousDisposalScreen extends StatelessWidget {
  const HazardousDisposalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Hazardous & Biomedical Waste')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Examples', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _bullet('E-waste, batteries, CFLs/LEDs'),
          _bullet('Paints, solvents, pesticides'),
          _bullet('Biomedical: syringes, dressings, expired medicines'),
          const SizedBox(height: 16),
          Text('Do’s', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _bullet('Keep separate from regular trash at all times.'),
          _bullet('Store sharps in puncture-resistant containers.'),
          _bullet('Use authorized collection centers/hospitals for disposal.'),
          const SizedBox(height: 16),
          Text('Don’ts', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _bullet('Do not flush medicines or pour chemicals into drains.'),
          _bullet('Do not burn—creates highly toxic emissions.'),
          _bullet('Do not mix with recyclables or organics.'),
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
          const Icon(Icons.warning_amber_rounded, size: 18, color: Colors.red),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
