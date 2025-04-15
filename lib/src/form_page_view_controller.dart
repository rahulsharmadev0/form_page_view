part of 'form_page_view.dart';

typedef PageCall =
    Future<void> Function({required Curve curve, required Duration duration});

typedef SpecificPageCall =
    Future<void> Function(int page, {required Curve curve, required Duration duration});

class FormPageViewController {
  final PageController _pageController;
  final ValueNotifier<int> currentPageIndex;
  final int totalPage;

  FormPageViewController._internal({required int initialPage, required this.totalPage})
    : _pageController = PageController(initialPage: initialPage),
      currentPageIndex = ValueNotifier(initialPage) {
    _pageController.addListener(_pageNotifyListeners);
  }

  void _pageNotifyListeners() {
    currentPageIndex.value = _pageController.page?.round() ?? 0;
  }

  bool get isFirstPage => currentPageIndex.value <= 0;
  bool get isLastPage => currentPageIndex.value >= totalPage - 1;

  PageCall get nextPage => _pageController.nextPage;

  PageCall get previousPage => _pageController.previousPage;

  SpecificPageCall get animateToPage => _pageController.animateToPage;

  void Function(int page) get jumpToPage => _pageController.jumpToPage;

  @mustCallSuper
  void dispose() {
    _pageController.dispose();
    currentPageIndex.dispose();
    _pageController.removeListener(_pageNotifyListeners);
  }
}
