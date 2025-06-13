// lib/widgets/secure_payment_widget.dart
import 'package:flutter/material.dart';
import '../services/cashfree_service.dart';

class SecurePaymentWidget extends StatefulWidget {
  final double amount;
  final String customerName;
  final String customerEmail;
  final String customerPhone;

  const SecurePaymentWidget({
    Key? key,
    required this.amount,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
  }) : super(key: key);

  @override
  State<SecurePaymentWidget> createState() => _SecurePaymentWidgetState();
}

class _SecurePaymentWidgetState extends State<SecurePaymentWidget> {
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  @override
  void initState() {
    super.initState();
    // Ensure Cashfree SDK is loaded
    CashfreeService.ensureCashfreeSDKLoaded();
  }

  // Method 1: Popup Payment (Recommended)
  void _initiatePopupPayment() {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      CashfreeService.initiateDropInPayment(
        amount: widget.amount,
        customerName: widget.customerName,
        customerEmail: widget.customerEmail,
        customerPhone: widget.customerPhone,
        onSuccess: (result) {
          setState(() {
            _isLoading = false;
            _successMessage =
                'Payment successful! Order ID: ${result['orderId'] ?? 'N/A'}';
          });
          _showSuccessDialog(result);
        },
        onFailure: (error) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Payment failed: $error';
          });
        },
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error: $e';
      });
    }
  }

  void _showSuccessDialog(Map<String, dynamic> result) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            icon: const Icon(Icons.check_circle, color: Colors.green, size: 64),
            title: const Text('Payment Successful!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (result['orderId'] != null)
                  Text('Order ID: ${result['orderId']}'),
                if (result['paymentId'] != null)
                  Text('Payment ID: ${result['paymentId']}'),
                Text('Amount: ₹${widget.amount.toStringAsFixed(2)}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Optionally navigate to success page or reset form
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Security Info
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            border: Border.all(color: Colors.blue.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.security, color: Colors.blue.shade700),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Secure Frontend Implementation - No API keys exposed',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Payment Details Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Details',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                _buildDetailRow(
                  'Amount',
                  '₹${widget.amount.toStringAsFixed(2)}',
                ),
                _buildDetailRow('Customer', widget.customerName),
                _buildDetailRow('Email', widget.customerEmail),
                _buildDetailRow('Phone', widget.customerPhone),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Success Message
        if (_successMessage != null)
          Card(
            color: Colors.green.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green.shade700),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _successMessage!,
                      style: TextStyle(color: Colors.green.shade700),
                    ),
                  ),
                ],
              ),
            ),
          ),

        // Error Message
        if (_errorMessage != null)
          Card(
            color: Colors.red.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.error, color: Colors.red.shade700),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red.shade700),
                    ),
                  ),
                ],
              ),
            ),
          ),

        const SizedBox(height: 16),

        // Payment Methods
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose Payment Method',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),

                // Popup Payment (Recommended)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _initiatePopupPayment,
                    icon:
                        _isLoading
                            ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                            : const Icon(Icons.payment),
                    label: const Text('Pay Now'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '✓ Secure payment window',
                  style: TextStyle(fontSize: 12, color: Colors.green.shade600),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
