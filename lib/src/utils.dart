// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:form_page_view/form_page_view.dart';

// // typedef PageBuilderItem = ({Widget page, bool isRequired, bool Function() whenComplete});

// typedef PageBuilder = List<FormPageWidget> Function(BuildContext context);

import 'package:form_page_view/form_page_view.dart';

extension PageBuilderItemExtension on FormPage {
  /// Indicates whether the page has been processed.
  ///
  /// Returns `true` if the page is not required, or if it is required and the
  /// `whenComplete()` condition is satisfied (i.e., the page has been completed).
  ///
  /// This is useful for determining if a required page has met all completion
  /// criteria, or if it can be considered processed because it is optional.
  bool get isRequirementFulfilled => !isRequired || (whenComplete?.call() ?? false);
}
