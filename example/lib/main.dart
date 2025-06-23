import 'package:flutter/material.dart';
import 'package:form_page_view/form_page_view.dart';
import 'form_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Page View Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DemoSelectionPage(),
    );
  }
}

class DemoSelectionPage extends StatelessWidget {
  const DemoSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FormPageView Demos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Choose a demo to explore:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
           const SizedBox(height: 16),
            Card(
              child: InkWell(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FormDemoPage()),
                    ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.rocket_launch, color: Colors.blue),
                          SizedBox(width: 8),
                          Text(
                            'Advanced Multi-Step Form',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'A comprehensive 6-step form showcasing personal info, address, payment, terms, feedback, and summary pages with advanced validation.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Card(
              color: Colors.blue,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(Icons.info, color: Colors.white, size: 32),
                    SizedBox(height: 8),
                    Text(
                      'FormPageView Features',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Smart navigation with validation\n'
                      '• Multiple progress indicator styles\n'
                      '• Required and optional pages\n'
                      '• Customizable layouts\n'
                      '• Smooth animations',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormDemoPage extends StatefulWidget {
  const FormDemoPage({super.key});

  @override
  State<FormDemoPage> createState() => _FormDemoPageState();
}

class _FormDemoPageState extends State<FormDemoPage> {
  late final FormPageViewController _controller = FormPageViewController(
    initialPage: 0,
    formPages: <Widget>[
      FormPages.buildPersonalInfoPage(),
      FormPages.buildAddressPage(),
      FormPages.buildPaymentPage(),
      FormPages.buildTermsPage(),
      FormPages.buildFeedbackPage(),
      FormPages.buildSummaryPage(),
    ],
  );

  @override
  void dispose() {
   _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FormPageViewControllerProvider(
      controller: _controller,
      builder:(context) {
        return Scaffold(
        appBar: AppBar(
          title: const Text('Multi-Step Form Demo'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: FormPageView(
          spacing: 20,
          controller: _controller,
          topBuilder:
              (context) => [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      FormPageViewProgressIndicator.linear(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      const SizedBox(height: 16),
                      FormPageViewProgressIndicator.stepped(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        shape: StepShape.circle,
                        stepSize: 12,
                        spacing: 8,
                      ),
                    ],
                  ),
                ),
              ],
          bottomBuilder:
              (context) => [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Previous Button
                      FormPageView.of(context).isFirstPage
                          ? const SizedBox(width: 100)
                          : ElevatedButton.icon(
                            onPressed:
                                () => FormPageView.of(context).previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                ),
                            icon: const Icon(Icons.arrow_back),
                            label: const Text('Previous'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(100, 45),
                            ),
                          ),
      
                      // Page indicator
                      Text(
                        '${FormPageView.of(context).currentIndex + 1} of ${FormPageView.of(context).totalPage}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
      
                      // Next/Finish Button
                      _buildNextButton(context),
                    ],
                  ),
                ),
              ],
        ),
      );
      },
    );
  }

  Widget _buildNextButton(BuildContext context) {
    final controller = FormPageView.of(context);
    final isLastPage = controller.isLastPage;
    return ElevatedButton.icon(
      onPressed: () {
        if (!_showCompletionDialogIfLastPage(context) && controller.validate()) {
          controller.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      icon: Icon(isLastPage ? Icons.check : Icons.arrow_forward),
      label: Text(isLastPage ? 'Complete' : 'Next'),
      style: ElevatedButton.styleFrom(minimumSize: const Size(100, 45)),
    );
  }

  bool _showCompletionDialogIfLastPage(BuildContext context) {
    if (FormPageView.of(context).isLastPage) {
      showDialog(
        context: context,
        builder:
            (BuildContext context) => AlertDialog(
              title: const Text('Form Completed!'),
              content: const Text(
                'Thank you for completing the form. Your information has been submitted successfully.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Start Over'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Done'),
                ),
              ],
            ),
      );
      return true;
    }
    return false;
  }
}
