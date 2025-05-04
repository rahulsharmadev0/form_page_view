import 'package:flutter/material.dart';

/// Common UI component for form pages
class FormPage extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? description;
  final double spacing;
  final EdgeInsetsGeometry padding;
  final List<Widget> Function(BuildContext context) builder;

  const FormPage({
    super.key,
    required this.title,
    required this.builder,
    this.subtitle,
    this.description,
    this.spacing = 16,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    Widget textWidget = Text(title, style: Theme.of(context).textTheme.titleLarge);

    return SingleChildScrollView(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spacing,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              textWidget,
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(subtitle!, style: Theme.of(context).textTheme.labelMedium),
              ],
            ],
          ),
          ...builder(context),
          if (description != null) ...[
            SizedBox(height: spacing),
            Align(
              alignment: Alignment.center,
              child: Text(
                description!,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
