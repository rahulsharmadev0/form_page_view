import 'dart:async';
import 'package:flutter/material.dart';
import 'package:form_page_view/form_page_view.dart';
part 'form_page_view_controller.dart';

class FormPageViewControllerProvider extends InheritedWidget {
  final FormPageViewController controller;

  FormPageViewControllerProvider({super.key, 
    required Widget Function(BuildContext) builder,
    required this.controller,
  }) : super(child: Builder(builder: builder));

  static FormPageViewController of(BuildContext context) {
    final controller =
        context
            .dependOnInheritedWidgetOfExactType<FormPageViewControllerProvider>()
            ?.controller ??
        context.findAncestorWidgetOfExactType<FormPageView>()?.controller;
    if (controller == null) {
      throw FlutterError('FormPageViewController not found in context');
    }
    return controller;
  }

  @override
  bool updateShouldNotify(FormPageViewControllerProvider oldWidget) {
    return controller != oldWidget.controller;
  }
}

class FormPageView extends StatefulWidget {
  final FormPageViewController controller;
  final EdgeInsetsGeometry? contentPadding;
  final Function(int)? onPageChanged;
  final List<Widget> Function(BuildContext context)? topBuilder;
  final List<Widget> Function(BuildContext context)? bottomBuilder;
  final ScrollPhysics? physics;
  final double spacing;
  final Map<String, dynamic> initialValue;

  const FormPageView({
    super.key,
    required this.controller,
    this.spacing = 16,
    this.contentPadding,
    this.topBuilder,
    this.bottomBuilder,
    this.physics,
    this.onPageChanged,
    this.initialValue = const <String, dynamic>{},
  });

  static FormPageViewController of(BuildContext context) =>
      FormPageViewControllerProvider.of(context);

  @override
  State<FormPageView> createState() => _FormPageViewState();
}

class _FormPageViewState extends State<FormPageView> {
  List get list => widget.controller._formPages;

  @override
  Widget build(BuildContext context) {
    Widget child = PageView.builder(
      controller: widget.controller._pageController,
      itemCount: widget.controller.totalPage,
      physics: widget.physics ?? const NeverScrollableScrollPhysics(),
      onPageChanged: widget.onPageChanged,
      itemBuilder: (context, i) => list[i],
    );

    child = FormBuilder(
      key: widget.controller.formKey,
      initialValue: widget.initialValue,
      child: child,
    );

    return widget.topBuilder == null && widget.bottomBuilder == null
        ? child
        : Column(
          spacing: widget.spacing,
          children: [
            if (widget.topBuilder != null) ...widget.topBuilder!(context),
            Expanded(child: child),
            if (widget.bottomBuilder != null) ...widget.bottomBuilder!(context),
          ],
        );
  }
}
