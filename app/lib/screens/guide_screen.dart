import 'package:flutter/material.dart';

import 'guides/composting_guide_screen.dart';
import 'guides/plastic_reduction_screen.dart';
import 'guides/hazardous_disposal_screen.dart';
import 'guides/flood_resilience_screen.dart';
import 'web/document_webview_screen.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Waste Management Guide', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        Text('Kerala-friendly tips for reducing waste and handling it responsibly.'),
        const SizedBox(height: 16),
        _GuideCard(
          title: 'Home Composting',
          color: Colors.green.shade100,
          bullets: const [
            'Use a bio-bin or clay pot for kitchen scraps.',
            'Layer browns (dry leaves) with greens (food peels).',
            'Keep moist, turn weekly; compost in 6–8 weeks.',
          ],
          cta: 'Learn compost basics',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const CompostingGuideScreen()),
          ),
          secondaryCtaLabel: 'Kerala composting PDF',
          onSecondaryCta: () => _openInApp(context, 'Kerala composting PDF', 'https://www.suchitwamission.org/wp-content/uploads/2020/06/Composting-Guide.pdf'),
        ),
        const SizedBox(height: 12),
        _GuideCard(
          title: 'Plastic Reduction',
          color: Colors.blue.shade100,
          bullets: const [
            'Carry reusable bottles and cloth bags.',
            'Opt for bulk/refill stores where possible.',
            'Use deposit-return points for PET bottles.',
          ],
          cta: 'Practical swaps',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const PlasticReductionScreen()),
          ),
          secondaryCtaLabel: 'Kerala plastic ban FAQ',
          onSecondaryCta: () => _openInApp(context, 'Kerala plastic ban FAQ', 'https://www.suchitwamission.org/plastic-ban-faq/'),
        ),
        const SizedBox(height: 12),
        _GuideCard(
          title: 'Hazardous/Biomedical',
          color: Colors.red.shade100,
          bullets: const [
            'Never mix with regular trash.',
            'Seal sharps in puncture-proof containers.',
            'Use authorized collection centers only.',
          ],
          cta: 'Disposal rules',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const HazardousDisposalScreen()),
          ),
          secondaryCtaLabel: 'Kerala biomedical rules',
          onSecondaryCta: () => _openInApp(context, 'Kerala biomedical rules', 'https://www.kspcb.kerala.gov.in/biomedical-waste/'),
        ),
        const SizedBox(height: 12),
        _GuideCard(
          title: 'Flood-Resilient Handling',
          color: Colors.orange.shade100,
          bullets: const [
            'Store waste in sealed, elevated containers.',
            'Avoid burning—creates toxic smoke.',
            'Segregate early to speed up clean-up.',
          ],
          cta: 'Flood resilience tips',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const FloodResilienceScreen()),
          ),
          secondaryCtaLabel: 'Disaster mgmt guidelines',
          onSecondaryCta: () => _openInApp(context, 'Disaster mgmt guidelines', 'https://sdma.kerala.gov.in/'),
        ),
      ],
    );
  }

  void _openInApp(BuildContext context, String title, String url) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DocumentWebViewScreen(title: title, url: url),
      ),
    );
  }
}

class _GuideCard extends StatelessWidget {
  final String title;
  final List<String> bullets;
  final String cta;
  final Color color;
  final VoidCallback onTap;
  final String? secondaryCtaLabel;
  final VoidCallback? onSecondaryCta;

  const _GuideCard({
    required this.title,
    required this.bullets,
    required this.cta,
    required this.color,
    required this.onTap,
    this.secondaryCtaLabel,
    this.onSecondaryCta,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            ...bullets.map((b) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle, color: Colors.black54, size: 18),
                      const SizedBox(width: 8),
                      Expanded(child: Text(b)),
                    ],
                  ),
                )),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                TextButton.icon(onPressed: onTap, icon: const Icon(Icons.arrow_forward), label: Text(cta)),
                if (secondaryCtaLabel != null && onSecondaryCta != null)
                  OutlinedButton.icon(onPressed: onSecondaryCta, icon: const Icon(Icons.chrome_reader_mode), label: Text(secondaryCtaLabel!)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
