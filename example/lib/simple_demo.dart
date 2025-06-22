import 'package:flutter/material.dart';
import 'package:form_page_view/form_page_view.dart';

/// A simple demo showing basic usage of FormPageView
class SimpleDemoPage extends StatefulWidget {
  const SimpleDemoPage({super.key});

  @override
  State<SimpleDemoPage> createState() => _SimpleDemoPageState();
}

class _SimpleDemoPageState extends State<SimpleDemoPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  bool _isNameValid() => _nameController.text.trim().isNotEmpty;
  bool _isEmailValid() => _emailController.text.trim().contains('@');

  @override
  Widget build(BuildContext context) {
    final pages = <FormPage>[
      FormPage(
        title: 'What\'s your name?',
        subtitle: 'Let us know how to address you',
        isRequired: true,
        whenComplete: _isNameValid,
        builderItems: (context) => [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Your Name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
      FormPage(
        title: 'Your email address',
        subtitle: 'We\'ll use this to contact you',
        isRequired: true,
        whenComplete: _isEmailValid,
        builderItems: (context) => [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
      FormPage(
        title: 'Any message?',
        subtitle: 'Optional feedback',
        description: 'This step is optional',
        isRequired: false,
        builderItems: (context) => [
          TextFormField(
            controller: _messageController,
            decoration: const InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
            maxLines: 4,
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Form Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FormPageView(
        totalPage: pages.length,
        pageBuilder: (context) => pages,
        topBuilder: (context) => [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FormPageViewProgressIndicator.linear(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
        bottomBuilder: (context) => [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Previous Button
                if (!FormPageView.of(context).isFirstPage)
                  ElevatedButton(
                    onPressed: () => FormPageView.of(context).previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                    child: const Text('Previous'),
                  )
                else
                  const SizedBox.shrink(),

                // Next/Finish Button
                ElevatedButton(
                  onPressed: pages[FormPageView.of(context).currentIndex]
                          .isRequirementFulfilled
                      ? () {
                          if (FormPageView.of(context).isLastPage) {
                            _showSuccess(context);
                          } else {
                            FormPageView.of(context).nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        }
                      : null,
                  child: Text(
                    FormPageView.of(context).isLastPage ? 'Finish' : 'Next',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success!'),
        content: Text(
          'Form completed!\n\n'
          'Name: ${_nameController.text}\n'
          'Email: ${_emailController.text}\n'
          'Message: ${_messageController.text.isEmpty ? 'None' : _messageController.text}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
