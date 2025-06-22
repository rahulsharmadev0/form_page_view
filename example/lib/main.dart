import 'package:flutter/material.dart';
import 'package:form_page_view/form_page_view.dart';
import 'simple_demo.dart';

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
            const SizedBox(height: 24),
            Card(
              child: InkWell(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SimpleDemoPage()),
                    ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange),
                          SizedBox(width: 8),
                          Text(
                            'Simple Form Demo',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'A basic 3-step form demonstrating core functionality with name, email, and optional message fields.',
                      ),
                    ],
                  ),
                ),
              ),
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
  // Form data controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  // Validation state
  bool _agreeToTerms = false;
  String _selectedCountry = '';
  String _selectedPaymentMethod = '';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  // Validation methods
  bool _isPersonalInfoComplete() {
    return _nameController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _phoneController.text.trim().isNotEmpty &&
        _emailController.text.contains('@');
  }

  bool _isAddressComplete() {
    return _addressController.text.trim().isNotEmpty &&
        _cityController.text.trim().isNotEmpty &&
        _zipController.text.trim().isNotEmpty &&
        _selectedCountry.isNotEmpty;
  }

  bool _isPaymentComplete() {
    return _selectedPaymentMethod.isNotEmpty &&
        (_selectedPaymentMethod != 'Credit Card' ||
            (_cardNumberController.text.trim().length >= 16 &&
                _expiryController.text.trim().isNotEmpty &&
                _cvvController.text.trim().length >= 3));
  }

  bool _isTermsAccepted() {
    return _agreeToTerms;
  }

  @override
  Widget build(BuildContext context) {
    final formPages = <FormPage>[
      _buildPersonalInfoPage(),
      _buildAddressPage(),
      _buildPaymentPage(),
      _buildTermsPage(),
      _buildFeedbackPage(),
      _buildSummaryPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-Step Form Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: FormPageView(
          totalPage: formPages.length,
          spacing: 20,
          pageBuilder: (context) => formPages,
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
                        '${FormPageView.of(context).currentIndex + 1} of ${formPages.length}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      // Next/Finish Button
                      _buildNextButton(context, formPages),
                    ],
                  ),
                ),
              ],
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context, List<FormPage> formPages) {
    final controller = FormPageView.of(context);
    final isLastPage = controller.isLastPage;
    return ElevatedButton.icon(
      onPressed:
          
              () {
                if (!_showCompletionDialogIfLastPage(context)) {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              }
              ,
      icon: Icon(isLastPage ? Icons.check : Icons.arrow_forward),
      label: Text(isLastPage ? 'Complete' : 'Next'),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 45),
      ),
    );
  }

  FormPage _buildPersonalInfoPage() {
    return FormPage(
      title: 'Personal Information',
      subtitle: 'Tell us about yourself',
      description: 'All fields marked with * are required',
      isRequired: true,
      builder:
          (context) => Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Full name is required';
                  }
                  if (value.trim().length < 2) {
                    return 'Name must be at least 2 characters';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email address is required';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Phone number is required';
                  }
                  if (value.trim().length < 10) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
            ],
          ),
    );
  }

  FormPage _buildAddressPage() {
    return FormPage(
      title: 'Address Information',
      subtitle: 'Where do you live?',
      description: 'We need this information for delivery',
      isRequired: true,
      
      builderItems:
          (context) => [
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Street Address *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.home),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      labelText: 'City *',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _zipController,
                    decoration: const InputDecoration(
                      labelText: 'ZIP Code *',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            DropdownButtonFormField<String>(
              value: _selectedCountry.isEmpty ? null : _selectedCountry,
              decoration: const InputDecoration(
                labelText: 'Country *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.flag),
              ),
              items:
                  ['USA', 'Canada', 'UK', 'Germany', 'France', 'India', 'Australia']
                      .map(
                        (country) =>
                            DropdownMenuItem(value: country, child: Text(country)),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value ?? '';
                });
              },
            ),
          ],
    );
  }

  FormPage _buildPaymentPage() {
    return FormPage(
      title: 'Payment Method',
      subtitle: 'How would you like to pay?',
      description: 'Your payment information is secure',
      isRequired: true,
      
      builderItems:
          (context) => [
            Card(
              child: Column(
                children: [
                  RadioListTile<String>(
                    title: const Text('Credit Card'),
                    value: 'Credit Card',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value ?? '';
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('PayPal'),
                    value: 'PayPal',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value ?? '';
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Bank Transfer'),
                    value: 'Bank Transfer',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value ?? '';
                      });
                    },
                  ),
                ],
              ),
            ),
            if (_selectedPaymentMethod == 'Credit Card') ...[
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.credit_card),
                ),
                keyboardType: TextInputType.number,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _expiryController,
                      decoration: const InputDecoration(
                        labelText: 'MM/YY',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _cvvController,
                      decoration: const InputDecoration(
                        labelText: 'CVV',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ],
          ],
    );
  }

  FormPage _buildTermsPage() {
    return FormPage(
      title: 'Terms & Conditions',
      subtitle: 'Please review and accept',
      description: 'You must accept the terms to continue',
      isRequired: true,
      
      builderItems:
          (context) => [
            Container(
              height: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const SingleChildScrollView(
                child: Text('''Terms and Conditions

1. Acceptance of Terms
By using this service, you agree to be bound by these terms and conditions.

2. Use of Service
You may use our service for lawful purposes only.

3. Privacy Policy
We respect your privacy and will protect your personal information.

4. Limitation of Liability
Our liability is limited to the maximum extent permitted by law.

5. Changes to Terms
We may update these terms from time to time.

6. Contact Information
If you have questions, please contact us at support@example.com.

Last updated: January 1, 2024''', style: TextStyle(fontSize: 12)),
              ),
            ),
            CheckboxListTile(
              title: const Text('I agree to the Terms and Conditions'),
              value: _agreeToTerms,
              onChanged: (value) {
                setState(() {
                  _agreeToTerms = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
    );
  }

  FormPage _buildFeedbackPage() {
    return FormPage(
      title: 'Feedback (Optional)',
      subtitle: 'Help us improve',
      description: 'Your feedback is valuable to us',
      isRequired: false,
      builderItems:
          (context) => [
            TextFormField(
              controller: _feedbackController,
              decoration: const InputDecoration(
                labelText: 'Your feedback',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
            ),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'This page is optional. You can skip it and continue to the summary.',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
    );
  }

  FormPage _buildSummaryPage() {
    return FormPage(
      title: 'Summary',
      subtitle: 'Review your information',
      description: 'Please review all details before submitting',
      isRequired: false,
      builderItems:
          (context) => [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personal Information',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    _buildSummaryItem('Name', _nameController.text),
                    _buildSummaryItem('Email', _emailController.text),
                    _buildSummaryItem('Phone', _phoneController.text),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Address', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    _buildSummaryItem('Address', _addressController.text),
                    _buildSummaryItem('City', _cityController.text),
                    _buildSummaryItem('ZIP', _zipController.text),
                    _buildSummaryItem('Country', _selectedCountry),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Payment', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    _buildSummaryItem('Method', _selectedPaymentMethod),
                    if (_selectedPaymentMethod == 'Credit Card')
                      _buildSummaryItem(
                        'Card',
                        '**** **** **** ${_cardNumberController.text.length > 4 ? _cardNumberController.text.substring(_cardNumberController.text.length - 4) : '****'}',
                      ),
                  ],
                ),
              ),
            ),
            if (_feedbackController.text.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Feedback', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(_feedbackController.text),
                    ],
                  ),
                ),
              ),
          ],
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text('$label:', style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
          Expanded(child: Text(value.isEmpty ? 'Not provided' : value)),
        ],
      ),
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
                    // Reset form
                    _resetForm();
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

  void _resetForm() {
    setState(() {
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _addressController.clear();
      _cityController.clear();
      _zipController.clear();
      _cardNumberController.clear();
      _expiryController.clear();
      _cvvController.clear();
      _feedbackController.clear();
      _agreeToTerms = false;
      _selectedCountry = '';
      _selectedPaymentMethod = '';
    });
  }
}
