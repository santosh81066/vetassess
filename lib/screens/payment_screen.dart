import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vetassess/widgets/login_page_layout.dart';

class CashfreePaymentScreen extends StatefulWidget {
  const CashfreePaymentScreen({Key? key}) : super(key: key);

  @override
  State<CashfreePaymentScreen> createState() => _CashfreePaymentScreenState();
}

class _CashfreePaymentScreenState extends State<CashfreePaymentScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerEmailController =
      TextEditingController();
  final TextEditingController _customerPhoneController =
      TextEditingController();

  bool _isLoading = false;
  String _paymentStatus = '';

  // Cashfree Configuration
  // Note: For production, these should be stored securely in your backend
  static const String APP_ID = ""; // Replace with your Cashfree App ID
  static const String CLIENT_SECRET = ""; // Replace with your Client Secret
  static const String BASE_URL =
      "https://sandbox.cashfree.com/pg"; // Use https://api.cashfree.com/pg for production

  // For Flutter Web, you need a backend to create payment sessions due to CORS restrictions

  @override
  void initState() {
    super.initState();
    // Initialize Cashfree Payment Gateway
    CFPaymentGatewayService().setCallback(verifyPayment, onError);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _customerNameController.dispose();
    _customerEmailController.dispose();
    _customerPhoneController.dispose();
    super.dispose();
  }

  // Create Payment Session
  // Option 1: Mock payment session for testing (CORS workaround)
  Future<Map<String, dynamic>?> createPaymentSession({
    required String orderId,
    required double orderAmount,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
  }) async {
    try {
      // For testing purposes, we'll create a mock payment session
      // In production, this should be done from your backend server

      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock response (replace with actual backend call)
      return {
        "payment_session_id":
            "session_${DateTime.now().millisecondsSinceEpoch}",
        "order_id": orderId,
        "order_amount": orderAmount,
        "order_currency": "INR",
        "customer_details": {
          "customer_id": "customer_${DateTime.now().millisecondsSinceEpoch}",
          "customer_name": customerName,
          "customer_email": customerEmail,
          "customer_phone": customerPhone,
        },
      };

      // Uncomment below code and comment above mock code when you have backend
      /*
      final Map<String, dynamic> requestBody = {
        "order_id": orderId,
        "order_amount": orderAmount,
        "order_currency": "INR",
        "customer_details": {
          "customer_id": "customer_${DateTime.now().millisecondsSinceEpoch}",
          "customer_name": customerName,
          "customer_email": customerEmail,
          "customer_phone": customerPhone,
        },
        "order_meta": {
          "return_url": "https://test.cashfree.com/pgappsdemos/return.php?order_id=$orderId"
        }
      };

      // Call your backend API instead of directly calling Cashfree
      final response = await http.post(
        Uri.parse('YOUR_BACKEND_URL/create-payment-session'), // Replace with your backend URL
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Error creating payment session: ${response.body}');
        return null;
      }
      */
    } catch (e) {
      print('Exception in createPaymentSession: $e');
      return null;
    }
  }

  // Start Payment Process
  Future<void> startPayment() async {
    if (!_validateInputs()) return;

    setState(() {
      _isLoading = true;
      _paymentStatus = '';
    });

    try {
      final String orderId = "order_${DateTime.now().millisecondsSinceEpoch}";
      final double amount = double.parse(_amountController.text);

      // Create payment session
      final sessionData = await createPaymentSession(
        orderId: orderId,
        orderAmount: amount,
        customerName: _customerNameController.text,
        customerEmail: _customerEmailController.text,
        customerPhone: _customerPhoneController.text,
      );

      if (sessionData == null) {
        setState(() {
          _paymentStatus = 'Failed to create payment session';
          _isLoading = false;
        });
        return;
      }

      // Create CFSession
      final CFSession session =
          CFSessionBuilder()
              .setEnvironment(
                CFEnvironment.SANDBOX,
              ) // Use CFEnvironment.PRODUCTION for production
              .setOrderId(orderId)
              .setPaymentSessionId(sessionData['payment_session_id'])
              .build();

      // Create CFTheme (optional customization)
      final CFTheme theme =
          CFThemeBuilder()
              .setNavigationBarBackgroundColorColor("#FF6B35")
              .setNavigationBarTextColor("#FFFFFF")
              .setPrimaryFont("Menlo")
              .setSecondaryFont("Futura")
              .build();

      // Create CFDropCheckoutPayment
      final CFDropCheckoutPayment dropCheckoutPayment =
          CFDropCheckoutPaymentBuilder()
              .setSession(session)
              .setTheme(theme)
              .build();

      // Start payment
      CFPaymentGatewayService().doPayment(dropCheckoutPayment);
    } catch (e) {
      setState(() {
        _paymentStatus = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  bool _validateInputs() {
    if (_amountController.text.isEmpty) {
      _showSnackBar('Please enter amount');
      return false;
    }
    if (_customerNameController.text.isEmpty) {
      _showSnackBar('Please enter customer name');
      return false;
    }
    if (_customerEmailController.text.isEmpty) {
      _showSnackBar('Please enter customer email');
      return false;
    }
    if (_customerPhoneController.text.isEmpty) {
      _showSnackBar('Please enter customer phone');
      return false;
    }

    try {
      double.parse(_amountController.text);
    } catch (e) {
      _showSnackBar('Please enter valid amount');
      return false;
    }

    return true;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // Payment Success Callback
  void verifyPayment(String orderId) {
    setState(() {
      _paymentStatus = 'Payment Successful! Order ID: $orderId';
      _isLoading = false;
    });
    print("Payment Success: $orderId");

    // Here you can verify the payment status from your backend
    // or redirect to success page
  }

  // Payment Error Callback
  void onError(CFErrorResponse errorResponse, String orderId) {
    setState(() {
      _paymentStatus = 'Payment Failed: ${errorResponse.getMessage()}';
      _isLoading = false;
    });
    print("Payment Error: ${errorResponse.getMessage()}");
  }

  @override
  Widget build(BuildContext context) {
    return LoginPageLayout(
      child: Column(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Color(0xFF00565B)),
                    child: Column(
                      children: [
                        Icon(Icons.payment, size: 50, color: Colors.white),
                        const SizedBox(height: 10),
                        const Text(
                          'Secure Payment',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'Powered by Cashfree',
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Payment Form
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Payment Details',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Amount Field
                        _buildTextField(
                          controller: _amountController,
                          label: 'Amount (₹)',
                          icon: Icons.currency_rupee,
                          keyboardType: TextInputType.number,
                        ),

                        const SizedBox(height: 16),

                        // Customer Name Field
                        _buildTextField(
                          controller: _customerNameController,
                          label: 'Customer Name',
                          icon: Icons.person,
                        ),

                        const SizedBox(height: 16),

                        // Customer Email Field
                        _buildTextField(
                          controller: _customerEmailController,
                          label: 'Email Address',
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 16),

                        // Customer Phone Field
                        _buildTextField(
                          controller: _customerPhoneController,
                          label: 'Phone Number',
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Pay Button
                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : startPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    child:
                        _isLoading
                            ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text('Processing...'),
                              ],
                            )
                            : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.lock, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'Pay Now',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                  ),
                ),

                const SizedBox(height: 20),

                // Payment Status
                if (_paymentStatus.isNotEmpty)
                  Card(
                    elevation: 2,
                    color:
                        _paymentStatus.contains('Successful')
                            ? Colors.green[50]
                            : Colors.red[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            _paymentStatus.contains('Successful')
                                ? Icons.check_circle
                                : Icons.error,
                            color:
                                _paymentStatus.contains('Successful')
                                    ? Colors.green
                                    : Colors.red,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _paymentStatus,
                              style: TextStyle(
                                color:
                                    _paymentStatus.contains('Successful')
                                        ? Colors.green[700]
                                        : Colors.red[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 20),

                // Security Info
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.security, color: Colors.grey[600]),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Your payment information is secure and encrypted',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Note: Currently using mock payment session for testing. Implement backend for production.',
                        style: TextStyle(
                          color: Colors.orange[700],
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue[600]!),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }
}
