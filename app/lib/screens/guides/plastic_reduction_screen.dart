import 'package:flutter/material.dart';

class PlasticReductionScreen extends StatelessWidget {
  const PlasticReductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Reduce Plastic Use')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Everyday Swaps', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _bullet('Carry a steel bottle and lunchbox; avoid PET single-use.'),
          _bullet('Use cloth bags and mesh produce bags.'),
          _bullet('Switch to bar soap/shampoo bars to reduce packaging.'),
          const SizedBox(height: 16),
          Text('Shopping Strategies', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _bullet('Prefer bulk/refill stores and buy loose produce.'),
          _bullet('Choose glass/metal over plastic where feasible.'),
          _bullet('Deposit-Return: return PET bottles where supported.'),
          const SizedBox(height: 16),
          Text('Disposal & Recycling', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _bullet('Rinse and segregate plastics by type if possible.'),
          _bullet('Avoid burning plastics—releases toxic fumes.'),
          _bullet('Participate in community collection drives.'),
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
          const Icon(Icons.check, size: 18, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
