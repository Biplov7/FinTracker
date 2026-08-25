/// Formats a double amount in Indian numbering system with USD currency symbol
/// Example: 1234567 → $ 12,34,567.00
String formatCurrency(double amount) {
  // Fix to 2 decimal places
  String fixed = amount.toStringAsFixed(2);

  // Split into integer part and decimal part
  List<String> parts = fixed.split('.');
  String integerPart = parts[0];
  String decimalPart = parts[1];

  // Indian numbering: First 3 from right, then groups of 2
  String formattedInteger = '';

  if (integerPart.length <= 3) {
    formattedInteger = integerPart;
  } else {
    // Take last 3 digits
    String lastThree = integerPart.substring(integerPart.length - 3);
    // Remaining digits
    String remaining = integerPart.substring(0, integerPart.length - 3);
    // Insert comma every 2 digits in the remaining part (from right to left)
    String formattedRemaining = '';
    int count = 0;
    for (int i = remaining.length - 1; i >= 0; i--) {
      if (count == 2) {
        formattedRemaining = ',$formattedRemaining';
        count = 0;
      }
      formattedRemaining = remaining[i] + formattedRemaining;
      count++;
    }

    formattedInteger = '$formattedRemaining,$lastThree';
  }

  return '\$$formattedInteger.$decimalPart';
}
