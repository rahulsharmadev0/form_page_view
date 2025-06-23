import 'package:flutter/material.dart';
import 'package:form_page_view/form_page_view.dart';

class FormPages {
  static FormPage buildPersonalInfoPage() {
    return FormPage(
      title: 'Personal Information',
      subtitle: 'Tell us about yourself',
      description: 'All fields marked with * are required',
      builderItems: (context) => [
        FormBuilderTextField(
          name: 'full_name',
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
        FormBuilderTextField(
          name: 'email',
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
        FormBuilderTextField(
          name: 'phone',
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
    );
  }

  static FormPage buildAddressPage() {
    return FormPage(
      title: 'Address Information',
      subtitle: 'Where do you live?',
      description: 'We need this information for delivery',
      builderItems: (context) => [
        FormBuilderTextField(
          name: 'street_address',
          decoration: const InputDecoration(
            labelText: 'Street Address *',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.home),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: FormBuilderTextField(
                name: 'city',
                decoration: const InputDecoration(
                  labelText: 'City *',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FormBuilderTextField(
                name: 'zip',
                decoration: const InputDecoration(
                  labelText: 'ZIP Code *',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        FormBuilderDropdown<String>(
          name: 'country',
          decoration: const InputDecoration(
            labelText: 'Country *',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.flag),
          ),
          items: ['USA', 'Canada', 'UK', 'Germany', 'France', 'India', 'Australia']
              .map(
                (country) => DropdownMenuItem(value: country, child: Text(country)),
              )
              .toList(),
        ),
      ],
    );
  }

  static FormPage buildPaymentPage() {
    return FormPage(
      title: 'Payment Method',
      subtitle: 'How would you like to pay?',
      description: 'Your payment information is secure',
      builderItems: (context) => [
        Card(
          child: FormBuilderRadioGroup<String>(
            name: 'payment_method',
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            options: const [
              FormBuilderFieldOption(
                value: 'Credit Card',
                child: Text('Credit Card'),
              ),
              FormBuilderFieldOption(value: 'PayPal', child: Text('PayPal')),
              FormBuilderFieldOption(
                value: 'Bank Transfer',
                child: Text('Bank Transfer'),
              ),
            ],
          ),
        ),
        FormBuilder(
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'card_number',
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.credit_card),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'expiry',
                      decoration: const InputDecoration(
                        labelText: 'MM/YY',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'cvv',
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
          ),
        ),
      ],
    );
  }

  static FormPage buildTermsPage() {
    return FormPage(
      title: 'Terms & Conditions',
      subtitle: 'Please review and accept',
      description: 'You must accept the terms to continue',
      builderItems: (context) => [
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
        FormBuilderCheckbox(
          name: 'terms_accepted',
          title: const Text('I agree to the Terms and Conditions'),
          onChanged: (value) {},
        ),
      ],
    );
  }

  static FormPage buildFeedbackPage() {
    return FormPage(
      title: 'Feedback (Optional)',
      subtitle: 'Help us improve',
      description: 'Your feedback is valuable to us',
      builderItems: (context) => [
        FormBuilderTextField(
          name: 'feedback',
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

  static Widget buildSummaryPage() {
    return Builder(
      builder: (context) {
        var formData = FormPageView.of(context).formData;
        return FormPage(
          title: 'Summary',
          subtitle: 'Review your information',
          description: 'Please review all details before submitting',
          builderItems: (context) => [
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
                    _buildSummaryItem('Name', formData['full_name'] ?? ''),
                    _buildSummaryItem('Email', formData['email'] ?? ''),
                    _buildSummaryItem('Phone', formData['phone'] ?? ''),
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
                    _buildSummaryItem('Address', formData['street_address'] ?? ''),
                    _buildSummaryItem('City', formData['city'] ?? ''),
                    _buildSummaryItem('ZIP', formData['zip'] ?? ''),
                    _buildSummaryItem('Country', formData['country'] ?? ''),
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
                    _buildSummaryItem('Method', formData['payment_method'] ?? ''),
                    if (formData['payment_method'] == 'Credit Card')
                      _buildSummaryItem(
                        'Card',
                        '**** **** **** ${(formData['card_number'] ?? '').toString().length > 4 ? (formData['card_number'] ?? '').toString().substring((formData['card_number'] ?? '').toString().length - 4) : '****'}',
                      ),
                  ],
                ),
              ),
            ),
            if ((formData['feedback'] ?? '').toString().isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Feedback', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(formData['feedback'] ?? ''),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  static Widget _buildSummaryItem(String label, String value) {
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
}
