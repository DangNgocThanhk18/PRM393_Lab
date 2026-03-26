import 'package:flutter/material.dart';

class RetryButton extends StatelessWidget {
  final VoidCallback onRetry;

  const RetryButton({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: onRetry,
        icon: const Icon(Icons.refresh),
        label: const Text('Retry'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }
}