import 'package:flutter/material.dart';
import 'guide_widgets.dart';

class PlasticReductionScreen extends StatelessWidget {
  const PlasticReductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reduce Plastic Use')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          GuideHeader(
            icon: Icons.local_mall,
            title: 'Practical swaps for low-plastic living',
            subtitle: 'Cut single-use plastics with daily habits and smarter shopping.',
            accent: Colors.blue,
          ),
          SizedBox(height: 12),
          GuideSection(
            title: 'Everyday Swaps',
            children: [
              Bullet('Carry steel bottle and lunchbox; avoid PET singles.'),
              Bullet('Use cloth/mesh produce bags.'),
              Bullet('Switch to bar soap and shampoo bars.'),
            ],
          ),
          SizedBox(height: 12),
          GuideSection(
            title: 'Shopping Strategies',
            children: [
              Bullet('Prefer bulk/refill stores; buy loose produce.'),
              Bullet('Choose glass/metal over plastic where feasible.'),
              Bullet('Use deposit-return points for PET bottles.'),
            ],
          ),
          SizedBox(height: 12),
          GuideSection(
            title: 'Disposal & Recycling',
            children: [
              Bullet('Rinse and segregate plastics by type if possible.'),
              Bullet('Never burn plastics—releases toxic fumes.'),
              Bullet('Join community collection drives.'),
            ],
          ),
        ],
      ),
    );
  }
}
