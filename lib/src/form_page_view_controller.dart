part of 'form_page_view.dart';

/// Callback type for page navigation
typedef PageCall =
    Future<void> Function({required Curve curve, required Duration duration});

/// Callback type for navigating to a specific page
typedef SpecificPageCall =
    Future<void> Function(int page, {required Curve curve, required Duration duration});

class FormPageViewController {
  final PageController _pageController;
  final List<Widget> _formPages;
  final bool shouldSkipToFirstRequiredPage;
  final List<int> optionalPageIndices;
  int get totalPage => _formPages.length;
  final ValueNotifier<({int? previous, int current})> pageState;

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  Map<String, dynamic> get formData => formKey.currentState!.value;

  bool validate() => formKey.currentState!.saveAndValidate();

  int get currentIndex => pageState.value.current;
  int get previousIndex => pageState.value.previous ?? -1;

  FormPageViewController({
    required int initialPage,
    required List<Widget> formPages,
    this.shouldSkipToFirstRequiredPage = false,
    this.optionalPageIndices = const [],
  }) : _pageController = PageController(
         initialPage: _getInitialPage(
           initialPage,
           formPages,
           shouldSkipToFirstRequiredPage,
           optionalPageIndices,
         ),
       ),
       _formPages = formPages,
       pageState = ValueNotifier((
         previous: null,
         current: _getInitialPage(
           initialPage,
           formPages,
           shouldSkipToFirstRequiredPage,
           optionalPageIndices,
         ),
       )) {
    _pageController.addListener(_pageNotifyListeners);
  }

  static int _getInitialPage(
    int initialPage,
    List<Widget> formPages,
    bool shouldSkipToFirstRequiredPage,
    List<int> optionalPageIndices,
  ) {
    if (!shouldSkipToFirstRequiredPage) {
      return initialPage;
    }

    for (int i = 0; i < formPages.length; i++) {
      if (!optionalPageIndices.contains(i)) {
        return i;
      }
    }

    return initialPage;
  }

  void _pageNotifyListeners() {
    var current = _pageController.page?.round() ?? 0;
    if (current != pageState.value.current) {
      pageState.value = (previous: pageState.value.current, current: current);
    }
  }

  bool get isFirstPage => currentIndex <= 0;
  bool get isLastPage => currentIndex >= totalPage - 1;

  PageCall get nextPage => _pageController.nextPage;

  PageCall get previousPage => _pageController.previousPage;

  SpecificPageCall get animateToPage => _pageController.animateToPage;

  void Function(int page) get jumpToPage => _pageController.jumpToPage;

  @mustCallSuper
  void dispose() {
    _pageController.removeListener(_pageNotifyListeners);
    _pageController.dispose();
    pageState.dispose();
  }
}
