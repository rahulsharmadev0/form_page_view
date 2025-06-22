# example

# FormPageView Example

This example demonstrates the capabilities of the FormPageView package with two comprehensive demos.

## Running the Example

```bash
cd example
flutter run
```

## Demo Options

### 1. Simple Form Demo
A basic 3-step form perfect for getting started:
- **Personal Info**: Name input with validation
- **Contact**: Email input with format validation  
- **Message**: Optional feedback field

**Features demonstrated:**
- Required vs optional pages
- Real-time validation
- Smart navigation (next button disabled until required fields are complete)
- Linear progress indicator

### 2. Advanced Multi-Step Form
A comprehensive 6-step form showcasing advanced features:
- **Personal Information**: Name, email, phone with validation
- **Address**: Street, city, ZIP, country selection
- **Payment**: Multiple payment methods with conditional fields
- **Terms & Conditions**: Scrollable terms with acceptance checkbox
- **Feedback**: Optional user feedback
- **Summary**: Review all entered information

**Features demonstrated:**
- Complex validation logic
- Conditional form fields
- Multiple progress indicator styles (linear + stepped)
- Mixed required/optional pages
- Form summary and review
- Professional UI design

## Key Implementation Details

### Form Validation
```dart
bool _isPersonalInfoComplete() {
  return _nameController.text.trim().isNotEmpty &&
         _emailController.text.trim().isNotEmpty &&
         _phoneController.text.trim().isNotEmpty &&
         _emailController.text.contains('@');
}
```

### Page Configuration
```dart
FormPage(
  title: 'Personal Information',
  subtitle: 'Tell us about yourself',
  isRequired: true,
  
  builder: (context) => [
    // Form fields...
  ],
)
```

### Smart Navigation
```dart
ElevatedButton(
  onPressed: currentPage.isRequirementFulfilled
      ? () => navigateNext()
      : null, // Button disabled if requirements not met
  child: Text('Next'),
)
```

## Customization Examples

### Progress Indicators
- **Linear**: Clean progress bar with customizable styling
- **Stepped**: Circular step indicators showing form progression
- **Circular**: Traditional circular progress (available but not used in demos)

### Layout Options
- **Top Builder**: Progress indicators, titles, instructions
- **Bottom Builder**: Navigation buttons, page counters
- **Flexible Spacing**: Customizable spacing between elements

## Learn More

Check out the [main README](../README.md) for complete API documentation and additional examples.
