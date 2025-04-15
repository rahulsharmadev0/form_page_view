import 'package:flutter/material.dart';
import 'form_page_view.dart';

class FormPageViewProgressIndicator extends StatelessWidget {
  final Duration duration;
  final Curve curve;
  final Widget? child;
  final Widget Function(BuildContext context, double value, Widget? child) builder;

  const FormPageViewProgressIndicator({
    super.key,
    required this.duration,
    required this.curve,
    required this.builder,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final ctr = FormPageView.of(context);
    return ValueListenableBuilder(
      valueListenable: ctr.currentPageIndex,
      builder: (context, value, child) {
        // Handle the case when there's only one page
        var progress = ctr.totalPage <= 1 ? 1.0 : value / (ctr.totalPage - 1);
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: progress),
          duration: duration,
          curve: curve,
          builder: builder,
          child: child,
        );
      },
    );
  }

  static get circularKey => const Key('circular-progress-indicator');
  static get linearKey => const Key('linear-progress-indicator');

  bool get isCircular => key == circularKey;
  bool get isLinear => key == linearKey;

  /// Creates a circular progress indicator for the FormPageView.
  factory FormPageViewProgressIndicator.circular({
    required Duration duration,
    required Curve curve,
    Widget? child,
    double strokeWidth = 4,
    Color? color,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    double? strokeAlign,
    StrokeCap? strokeCap,
    BoxConstraints? constraints,
    double? trackGap,
    String? semanticsLabel,
    String? semanticsValue,
    Color? valueColor,
  }) {
    return FormPageViewProgressIndicator(
      key: circularKey,
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return CircularProgressIndicator(
          value: value,
          strokeWidth: strokeWidth,
          constraints: constraints,
          strokeAlign: strokeAlign,
          strokeCap: strokeCap,
          trackGap: trackGap,
          padding: padding,
          color: color,
          backgroundColor: backgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(
            valueColor ?? Theme.of(context).primaryColor,
          ),
          semanticsLabel: semanticsLabel ?? 'Form Page View Circular progress indicator',
          semanticsValue:
              semanticsValue ?? 'Progress: ${(value * 100).toStringAsFixed(0)}%',
        );
      },
      child: child,
    );
  }

  /// Creates a linear progress indicator for the FormPageView.
  factory FormPageViewProgressIndicator.linear({
    required Duration duration,
    required Curve curve,
    Widget? child,
    double minHeight = 4,
    Color? color,
    Color? backgroundColor,
    Color? stopIndicatorColor,
    double? stopIndicatorRadius = 2, // Fixed type from Color to double
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    double? trackGap,
    String? semanticsLabel,
    String? semanticsValue,
    Color? valueColor,
  }) => FormPageViewProgressIndicator(
    key: linearKey,
    duration: duration,
    curve: curve,
    builder: (context, value, _) {
      return LinearProgressIndicator(
        value: value,
        minHeight: minHeight,
        color: color,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        stopIndicatorColor: stopIndicatorColor,
        stopIndicatorRadius: stopIndicatorRadius,
        trackGap: trackGap,
        valueColor: AlwaysStoppedAnimation<Color>(
          valueColor ?? Theme.of(context).primaryColor,
        ),
        semanticsLabel: semanticsLabel ?? 'Form Page View Linear progress indicator',
        semanticsValue:
            semanticsValue ?? 'Progress: ${(value * 100).toStringAsFixed(0)}%',
      );
    },
    child: child,
  );
}
