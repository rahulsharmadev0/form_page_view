# FormPageView 📝

A delightful Flutter package that makes multi-step forms and wizards a breeze! Whether you're building a user onboarding flow, a multi-step checkout process, or a complex data entry form, FormPageView has got you covered.

## ✨ Features

- 🔄 **Smooth Page Transitions** - Navigate between form pages with beautiful animations
- 📊 **Built-in Progress Indicators** - Multiple styles to show users their progress
- 📱 **Flexible Layout Options** - Customize top and bottom areas with your own widgets
- 🧠 **Smart Navigation** - Jump to any page or navigate to next/previous with simple calls
- ✅ **Required & Completion States** - Track which pages are mandatory and completed

## 📦 Installation

```yaml
dependencies:
  form_page_view: ^0.0.1
```

Run `flutter pub get` to install the package.

## 🚀 Quick Start

Here's a simple example to get you started:

```dart
import 'package:flutter/material.dart';
import 'package:form_page_view/form_page_view.dart';

class MyForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formPages = <PageBuilderItem>[
      (page: NamePage(), isRequired: true, isComplete: false),
      (page: AddressPage(), isRequired: true, isComplete: false),
      (page: PaymentPage(), isRequired: true, isComplete: false),
      (page: SummaryPage(), isRequired: true, isComplete: false),
    ];

    return Scaffold(
      body: FormPageView(
        totalPage: formPages.length,
        spacing: 16,
        pageBuilder: (context) => formPages,
        topBuilder: (context) => [
          FormPageViewProgressIndicator.linear(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
        ],
        bottomBuilder: (context) => [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  FormPageView.of(context).previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text('Previous'),
              ),
              TextButton(
                onPressed: () {
                  FormPageView.of(context).nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

## 🧩 Components

### FormPageView

The main widget that orchestrates your multi-page form experience.

```dart
FormPageView(
  totalPage: pages.length,
  spacing: 16,  // Spacing between top/content/bottom sections
  pageBuilder: (context) => pages,
  topBuilder: (context) => [/* your top widgets */],
  bottomBuilder: (context) => [/* your bottom widgets */],
  physics: NeverScrollableScrollPhysics(),  // Optional: control scroll behavior
  onPageChanged: (index) {/* your page change handler */},  // Optional
)
```

### FormPage

A convenient widget for creating consistent form pages.

```dart
FormPage(
  title: 'Personal Details',
  builder: (context) => [
    TextFormField(decoration: InputDecoration(labelText: 'First Name')),
    TextFormField(decoration: InputDecoration(labelText: 'Last Name')),
    // More form fields...
  ],
)
```

### Progress Indicators

#### Linear Progress Indicator

```dart
FormPageViewProgressIndicator.linear(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  minHeight: 6,  // Optional
  color: Colors.blue,  // Optional
  backgroundColor: Colors.grey.shade200,  // Optional
)
```

#### Stepped Progress Indicator

```dart
FormPageViewProgressIndicator.stepped(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  shape: StepShape.circle,  // Options: circle, square
  stepSize: 12.0,  // Optional
  spacing: 4.0,  // Optional
)
```

#### Circular Progress Indicator

```dart
FormPageViewProgressIndicator.circular(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  strokeWidth: 4,  // Optional
  color: Colors.blue,  // Optional
)
```

## 🧭 Navigation

FormPageView provides easy access to navigation methods:

```dart
// Get the controller from context
final controller = FormPageView.of(context);

// Navigate to next page
controller.nextPage(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
);

// Navigate to previous page
controller.previousPage(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
);

// Jump to a specific page
controller.jumpToPage(2);

// Animate to a specific page
controller.animateToPage(
  2,
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
);

// Check current position
if (controller.isFirstPage) {
  // Hide back button or show different UI
}

if (controller.isLastPage) {
  // Show submit button instead of next
}
```

## 📋 State Management

The package uses a simple state model for pages:

```dart
// Define your pages with state
const pages = <PageBuilderItem>[
  (page: PersonalInfoPage(), isRequired: true, isComplete: false),
  (page: AddressPage(), isRequired: true, isComplete: false),
  (page: PreferencesPage(), isRequired: false, isComplete: false),  // Optional page
];
```

## 💡 Tips & Tricks

1. **Smart Initial Page** - The widget automatically starts at the first required incomplete page
2. **Custom Page Navigation** - Use the controller to implement conditional navigation logic
3. **Mixed Indicators** - You can combine multiple progress indicators in the topBuilder
4. **Form Validation** - Use Flutter's Form widget within your pages for validation

## 📄 License

This package is available under the [LICENSE](LICENSE) license.

## 👨‍💻 Contributing

Contributions are welcome! Feel free to submit a pull request.
