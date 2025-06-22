import 'package:flutter/material.dart';

/// Common UI component for form pages
class FormPage extends StatelessWidget {
  final Object title;
  final String? subtitle;
  final String? description;
  final double spacing;
  final EdgeInsetsGeometry padding;
  final bool isRequired;
  final List<Widget> Function(BuildContext context)? builderItems;
  final Widget Function(BuildContext context)? builder;

  const FormPage({
    super.key,
    required this.title,
    this.builderItems,
    this.builder,
    this.subtitle,
    this.description,
    this.spacing = 16,
    this.isRequired = false,
    this.padding = const EdgeInsets.all(16.0),
  }) : assert(
         (builderItems != null) ^ (builder != null),
         'Exactly one of builderItems or builder must be provided',
       ),
       assert(
         title is String || title is Widget,
         'title must be either a String or Widget',
       );

  @override
  Widget build(BuildContext context) {
    Widget textWidget;
    if (title is String) {
      textWidget = Text(title as String, style: Theme.of(context).textTheme.titleLarge);
    } else {
      textWidget = title as Widget;
    }

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
          ...(builderItems?.call(context) ?? [builder!(context)]),
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
