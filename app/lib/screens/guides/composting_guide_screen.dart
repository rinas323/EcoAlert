import 'package:flutter/material.dart';

class CompostingGuideScreen extends StatelessWidget {
  const CompostingGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Home Composting')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Why Compost?', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const Text('Composting diverts organics from landfills, cuts methane, and yields soil-enriching compost for urban/rural gardens.'),
          const SizedBox(height: 16),
          Text('What You Need', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _bullet('A ventilated bio-bin, terracotta/clay pot, or DIY bucket composter'),
          _bullet('Browns: dry leaves, shredded paper, sawdust'),
          _bullet('Greens: fruit/vegetable peels, coffee grounds; avoid meat/dairy'),
          const SizedBox(height: 16),
          Text('Step-by-Step', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _step(1, 'Add a base layer of browns (3–5 cm).'),
          _step(2, 'Add a thin layer of greens, then cover with browns.'),
          _step(3, 'Maintain moisture like a wrung-out sponge; sprinkle water if dry.'),
          _step(4, 'Turn/aerate weekly to speed up decomposition.'),
          _step(5, 'In 6–8 weeks, dark crumbly compost is ready. Sieve and cure 1–2 weeks.'),
          const SizedBox(height: 16),
          Text('Troubleshooting', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _bullet('Bad smell: add more browns and aerate.'),
          _bullet('Too wet: add dry leaves/newspaper and turn.'),
          _bullet('Ants/flies: cover food scraps fully with browns; keep bin closed.'),
          const SizedBox(height: 16),
          Text('Safety & Tips', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _bullet('Keep bin shaded; avoid direct heavy rain.'),
          _bullet('Use finished compost for pots/landscaping; avoid on raw edible leaves immediately.'),
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
          const Icon(Icons.check, size: 18, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _step(int n, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 12, backgroundColor: Colors.green, child: Text('$n', style: const TextStyle(color: Colors.white)) ),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
