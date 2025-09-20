import 'package:flutter/material.dart';

class HelpAndFeedbackScreen extends StatelessWidget {
  const HelpAndFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Feedback')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Help', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            const Text('For any help or support, please contact us at:'),
            const SizedBox(height: 8),
            const Text('Email: rinazmuhammed242@email.com'),
            const SizedBox(height: 16),
            Text('Feedback', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            const Text(
              'We would love to hear your feedback. Please send your suggestions to the same email address.',
            ),
          ],
        ),
      ),
    );
  }
}
