import 'package:flutter/material.dart';
import 'model.dart';

Widget tweetCard(BuildContext context, Tweet tweet) {
  final theme = Theme.of(context);
  return Card(
    elevation: 2,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: theme.colorScheme.primaryContainer,
            child: Text(tweet.emoji, style: const TextStyle(fontSize: 28)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(tweet.userName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(width: 8),
                    Text(tweet.createdAt,
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(tweet.text, style: theme.textTheme.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
