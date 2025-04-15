import 'package:flutter/material.dart';
part 'form_page_view_controller.dart';

class _FormViewControllerProvider extends InheritedWidget {
  final FormPageViewController controller;

  _FormViewControllerProvider({
    required Widget Function(BuildContext) builder,
    required this.controller,
  }) : super(child: Builder(builder: builder));

  static FormPageViewController of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<_FormViewControllerProvider>();
    if (provider == null) {
      throw FlutterError('FormViewControllerProvider not found in context');
    }
    return provider.controller;
  }

  @override
  bool updateShouldNotify(_FormViewControllerProvider oldWidget) {
    return controller != oldWidget.controller;
  }
}

class FormPageView extends StatefulWidget {
  final int initialPage;
  final int totalPage;
  final EdgeInsetsGeometry? contentPadding;
  final Function(int)? onPageChanged;
  final List<Widget> Function(BuildContext context) pagebuilder;
  final List<Widget> Function(BuildContext context)? topBuilder;
  final List<Widget> Function(BuildContext context)? bottomBuilder;
  final ScrollPhysics? physics;
  final double spacing;

  const FormPageView({
    super.key,
    required this.pagebuilder,
    this.initialPage = 0,
    this.spacing = 0,
    required this.totalPage,
    this.contentPadding,
    this.topBuilder,
    this.bottomBuilder,
    this.physics,
    this.onPageChanged,
  });

  static FormPageViewController of(BuildContext context) =>
      _FormViewControllerProvider.of(context);

  @override
  State<FormPageView> createState() => _FormPageViewState();
}

class _FormPageViewState extends State<FormPageView> {
  late final FormPageViewController controller;

  @override
  void initState() {
    super.initState();
    controller = FormPageViewController._internal(
      initialPage: widget.initialPage,
      totalPage: widget.totalPage,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _FormViewControllerProvider(
      controller: controller,
      builder: (context) {
        final pageView = PageView.builder(
          controller: controller._pageController,
          itemCount: controller.totalPage,
          physics: widget.physics ?? const NeverScrollableScrollPhysics(),
          onPageChanged: widget.onPageChanged,
          itemBuilder: (context, i) => widget.pagebuilder(context)[i],
        );
        return widget.topBuilder == null && widget.bottomBuilder == null
            ? pageView
            : Column(
              spacing: widget.spacing,
              children: [
                if (widget.topBuilder != null) ...widget.topBuilder!(context),
                Expanded(child: pageView),
                if (widget.bottomBuilder != null) ...widget.bottomBuilder!(context),
              ],
            );
      },
    );
  }
}
