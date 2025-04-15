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
    var list = [
      HomePage(title: 'HomePage 1'), //
      HomePage(title: 'HomePage 2'), //
      HomePage(title: 'HomePage 3'), //
      HomePage(title: 'HomePage 4'), //
      HomePage(title: 'HomePage 5'), //
      HomePage(title: 'HomePage 6'), //
    ];
    return FormPageView(
      totalPage: list.length,
      spacing: 16,
      topBuilder: (context) {
        return [
          FormPageViewProgressIndicator.linear(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            trackGap: 8,
            borderRadius: BorderRadius.circular(8),
          ),
        ];
      },
      pagebuilder: (context) => list,
      bottomBuilder: (context) {
        return [
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
        ];
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              FormPageView.of(context).jumpToPage(0);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[const Text('You have pushed the button this many times:')],
        ),
      ),
    );
  }
}
