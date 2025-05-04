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
      valueListenable: ctr.pageState,
      builder: (context, value, child) {
        // Handle the case when there's only one page
        var progress = ctr.totalPage <= 1 ? 1.0 : value.current / (ctr.totalPage - 1);
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

  /// Creates a custom stepped progress indicator for FormPageView
  factory FormPageViewProgressIndicator.stepped({
    required Duration duration,
    required Curve curve,
    int? steps,
    Color? activeColor,
    Color? inactiveColor,
    double stepSize = 10.0,
    double spacing = 4.0,
    StepShape shape = StepShape.circle,
    bool debugMode = false,
  }) {
    return FormPageViewProgressIndicator(
      duration: duration,
      curve: curve,

      builder: (context, value, _) {
        final theme = Theme.of(context);
        final activeStepColor = activeColor ?? theme.primaryColor;
        final inactiveStepColor = inactiveColor ?? theme.disabledColor;
        int _steps = steps ?? FormPageView.of(context).totalPage;
        _steps -= 1;
        final activeSteps = (value * _steps).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_steps, (index) {
            final isActive = index < activeSteps;

            Widget step;
            switch (shape) {
              case StepShape.circle:
                step = Container(
                  width: stepSize,
                  height: stepSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive ? activeStepColor : inactiveStepColor,
                  ),
                );
                break;

              case StepShape.square:
                step = Container(
                  width: stepSize,
                  height: stepSize,
                  decoration: BoxDecoration(
                    color: isActive ? activeStepColor : inactiveStepColor,
                  ),
                );
                break;

              case StepShape.rectangle:
                step = Container(
                  width: stepSize * 2,
                  height: stepSize,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: isActive ? activeStepColor : inactiveStepColor,
                  ),
                );
                break;
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: spacing / 2),
              child: step,
            );
          }),
        );
      },
    );
  }
}

/// Shape options for stepped progress indicator
enum StepShape { circle, square, rectangle }
