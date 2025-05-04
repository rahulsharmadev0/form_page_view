part of 'form_page_view.dart';

/// Callback type for page navigation
typedef PageCall =
    Future<void> Function({required Curve curve, required Duration duration});

/// Callback type for navigating to a specific page
typedef SpecificPageCall =
    Future<void> Function(int page, {required Curve curve, required Duration duration});

class FormPageViewController {
  final PageController _pageController;
  final int totalPage;
  final ValueNotifier<({int? previous, int current})> pageState;

  int get currentIndex => pageState.value.current;
  int get previousIndex => pageState.value.previous ?? -1;

  FormPageViewController._internal({required int initialPage, required this.totalPage})
    : _pageController = PageController(initialPage: initialPage),
      pageState = ValueNotifier((previous: null, current: initialPage)) {
    _pageController.addListener(_pageNotifyListeners);
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
