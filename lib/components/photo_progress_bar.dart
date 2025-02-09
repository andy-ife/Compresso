import 'package:flutter/material.dart';

class PhotoProgressBar extends StatelessWidget {
  const PhotoProgressBar(this.title, this.size, this.progress, {super.key});

  final String title;
  final String size;
  final double progress;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.displaySmall,
              ),
              Text(size, style: theme.textTheme.displaySmall)
            ],
          ),
        ),
        const SizedBox(height: 2.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: LinearProgressIndicator(
            backgroundColor: theme.colorScheme.surfaceContainer,
            color: theme.colorScheme.primaryContainer,
            value: progress,
            borderRadius: BorderRadius.circular(8.0),
            minHeight: 14.0,
          ),
        )
      ],
    );
  }
}
