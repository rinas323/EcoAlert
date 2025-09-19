import 'package:flutter/material.dart';
import 'guide_widgets.dart';

class CompostingGuideScreen extends StatelessWidget {
  const CompostingGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Composting')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          GuideHeader(
            icon: Icons.eco,
            title: 'Turn kitchen scraps into soil gold',
            subtitle: 'Divert organics, cut methane, and nourish home gardens with simple composting.',
            accent: Colors.green,
          ),
          SizedBox(height: 12),
          GuideSection(
            title: 'What You Need',
            children: [
              Bullet('Bio-bin/terracotta pot or DIY bucket composter'),
              Bullet('Browns: dry leaves, shredded paper, sawdust'),
              Bullet('Greens: fruit/vegetable peels, coffee grounds (no meat/dairy)'),
            ],
          ),
          SizedBox(height: 12),
          GuideSection(
            title: 'Step-by-Step',
            children: [
              StepRow(1, 'Add a base layer of browns (3–5 cm).', color: Colors.green),
              StepRow(2, 'Add a thin layer of greens, then cover fully with browns.', color: Colors.green),
              StepRow(3, 'Keep moisture like a wrung-out sponge; sprinkle if dry.', color: Colors.green),
              StepRow(4, 'Turn/aerate weekly to speed up decomposition.', color: Colors.green),
              StepRow(5, 'Dark, earthy compost in ~6–8 weeks; cure for 1–2 weeks.', color: Colors.green),
            ],
          ),
          SizedBox(height: 12),
          GuideSection(
            title: 'Troubleshooting',
            children: [
              InfoCard(icon: Icons.warning_amber_rounded, title: 'Odor', text: 'Add more browns and aerate thoroughly.', color: Colors.orange),
              InfoCard(icon: Icons.bug_report, title: 'Ants/flies', text: 'Cover scraps completely; keep bin closed.', color: Colors.red),
              InfoCard(icon: Icons.water_drop, title: 'Too wet', text: 'Mix in dry leaves/newspaper and turn well.', color: Colors.blue),
            ],
          ),
          SizedBox(height: 12),
          GuideSection(
            title: 'Safety & Tips',
            children: [
              Bullet('Shade the bin; avoid direct heavy rain.'),
              Bullet('Use finished compost for pots/landscaping; avoid immediate contact on raw leaves.'),
            ],
          ),
        ],
      ),
    );
  }
}
