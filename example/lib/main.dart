import 'package:flutter/material.dart';
import 'package:form_page_view/form_page_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final list = <PageBuilderItem>[
      (page: HomePage(title: 'HomePage 1'), isRequired: true, whenComplete: () => true),
      (page: HomePage(title: 'HomePage 2'), isRequired: true, whenComplete: () => true),
      (page: HomePage(title: 'HomePage 3'), isRequired: true, whenComplete: () => false),
      (page: HomePage(title: 'HomePage 4'), isRequired: true, whenComplete: () => true),
      (page: HomePage(title: 'HomePage 5'), isRequired: false, whenComplete: () => false),
      (page: HomePage(title: 'HomePage 6'), isRequired: true, whenComplete: () => true),
    ];
    return Scaffold(
      body: FormPageView(
        totalPage: list.length,
        spacing: 16,
        topBuilder: (context) {
          return [
            FormPageViewProgressIndicator.linear(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
            FormPageViewProgressIndicator.stepped(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,

              shape: StepShape.circle,
            ),
          ];
        },
        pageBuilder: (context) => list,
        bottomBuilder: (context) {
          return [
            TextButton(
              onPressed:
                  list[FormPageView.of(context).currentIndex].isRequirementFulfilled
                      ? () => FormPageView.of(context).previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      )
                      : null,
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
          ];
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return FormPage(
      title: title,
      subtitle: 'Subtitle content',
      description: 'Description content',
      builder:
          (context) => [
            Center(child: Text(title)),
            Center(child: Text(title)),
            Center(child: Text(title)),
          ],
    );
  }
}
