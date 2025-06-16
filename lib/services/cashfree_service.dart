import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:js_util' as js_util;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CashfreeService {
  // Your backend URL - CHANGE THIS TO YOUR ACTUAL BACKEND URL
  static const String baseUrl = 'https://your-backend-url.com/api';
  
  // Environment setting
  static const String environment = 'sandbox'; // Change to 'production' for live
  
  static bool _isPaymentActive = false;
  static int _paymentCounter = 0;

  // Create payment session via your backend
  static Future<Map<String, dynamic>?> createPaymentSession({
    required double amount,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
    String? orderId,
  }) async {
    try {
      print('Creating payment session...');
      
      final requestBody = {
        'amount': amount,
        'customer_name': customerName,
        'customer_email': customerEmail,
        'customer_phone': customerPhone,
        'order_id': orderId ?? 'ORDER_${DateTime.now().millisecondsSinceEpoch}',
      };

      print('Request body: $requestBody');

      final response = await http.post(
        Uri.parse('$baseUrl/create-payment-session'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          return {
            'paymentSessionId': data['payment_session_id'],
            'orderId': data['order_id'],
          };
        } else {
          throw Exception(data['message'] ?? 'Failed to create payment session');
        }
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Error creating payment session: $e');
      return null;
    }
  }

  // Verify payment via your backend
  static Future<Map<String, dynamic>?> verifyPayment({
    required String orderId,
  }) async {
    try {
      print('Verifying payment for order: $orderId');
      
      final response = await http.post(
        Uri.parse('$baseUrl/verify-payment'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'order_id': orderId,
        }),
      );

      print('Verification response: ${response.statusCode}');
      print('Verification body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Verification failed: ${response.body}');
      }
    } catch (e) {
      print('Error verifying payment: $e');
      return null;
    }
  }

  // Main payment initiation method
  static Future<void> initiatePayment({
    required double amount,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
    required Function(Map<String, dynamic>) onSuccess,
    required Function(String) onFailure,
    String? orderId,
  }) async {
    if (_isPaymentActive) {
      onFailure('Another payment is already in progress');
      return;
    }

    print('=== Starting Payment Process ===');
    print('Amount: ₹$amount');
    print('Customer: $customerName');

    try {
      _isPaymentActive = true;
      _paymentCounter++;

      // Step 1: Create payment session via backend
      final sessionData = await createPaymentSession(
        amount: amount,
        customerName: customerName,
        customerEmail: customerEmail,
        customerPhone: customerPhone,
        orderId: orderId,
      );

      if (sessionData == null) {
        _isPaymentActive = false;
        onFailure('Failed to create payment session');
        return;
      }

      final paymentSessionId = sessionData['paymentSessionId'];
      final finalOrderId = sessionData['orderId'];

      print('Payment session created: $paymentSessionId');
      print('Order ID: $finalOrderId');

      // Step 2: Check if Cashfree SDK is ready
      if (!await _checkCashfreeAvailability()) {
        _isPaymentActive = false;
        onFailure('Payment system not ready. Please refresh and try again.');
        return;
      }

      // Step 3: Set up callback and initiate payment
      final callbackName = 'cashfreeCallback_${DateTime.now().millisecondsSinceEpoch}_$_paymentCounter';

      js.context[callbackName] = js.allowInterop((dynamic result) {
        print('=== Payment Callback Received ===');
        print('Result: $result');

        // Clean up callback
        try {
          js.context[callbackName] = null;
        } catch (e) {
          print('Error removing callback: $e');
        }

        _isPaymentActive = false;

        try {
          if (result != null) {
            String status = _getStringProperty(result, 'status') ?? 'FAILED';
            
            if (status.toUpperCase() == 'SUCCESS') {
              Map<String, dynamic> resultMap = {
                'status': status,
                'orderId': _getStringProperty(result, 'orderId') ?? finalOrderId,
                'paymentId': _getStringProperty(result, 'paymentId') ?? '',
                'signature': _getStringProperty(result, 'signature') ?? '',
              };
              
              print('Payment successful: $resultMap');
              onSuccess(resultMap);
            } else {
              String message = _getStringProperty(result, 'message') ?? 'Payment failed';
              print('Payment failed: $message');
              onFailure(message);
            }
          } else {
            onFailure('No payment result received');
          }
        } catch (e) {
          print('Callback error: $e');
          onFailure('Payment processing error');
        }
      });

      // Step 4: Start payment
      _startPayment(paymentSessionId, callbackName, onFailure);

      // Safety timeout
      Timer(Duration(minutes: 10), () {
        if (_isPaymentActive) {
          _isPaymentActive = false;
          try {
            if (js.context[callbackName] != null) {
              js.context[callbackName] = null;
            }
          } catch (e) {
            print('Timeout cleanup error: $e');
          }
          onFailure('Payment timeout');
        }
      });

    } catch (e) {
      _isPaymentActive = false;
      print('Payment initiation error: $e');
      onFailure('Error starting payment: $e');
    }
  }

  static void _startPayment(
    String paymentSessionId,
    String callbackName,
    Function(String) onFailure,
  ) {
    try {
      print('Starting payment with session: $paymentSessionId');
      
      final paymentData = {
        'type': 'start_cashfree_payment',
        'data': {
          'paymentSessionId': paymentSessionId,
          'environment': environment,
          'callbackName': callbackName,
        },
      };
      
      html.window.postMessage(paymentData, '*');
      print('Payment message posted');
    } catch (e) {
      print('Error posting payment message: $e');
      onFailure('Failed to start payment: $e');
    }
  }

  static Future<bool> _checkCashfreeAvailability({int maxWaitSeconds = 10}) async {
    int attempts = 0;
    int maxAttempts = maxWaitSeconds * 2;
    
    while (attempts < maxAttempts) {
      try {
        var cashfree = js.context['Cashfree'];
        if (cashfree != null) {
          print('Cashfree SDK available');
          return true;
        }
      } catch (e) {
        print('Cashfree check error: $e');
      }
      
      await Future.delayed(Duration(milliseconds: 500));
      attempts++;
    }
    
    print('Cashfree SDK not available');
    return false;
  }

  static String? _getStringProperty(dynamic obj, String key) {
    try {
      if (obj == null) return null;
      
      if (obj is Map) {
        return obj[key]?.toString();
      }
      
      dynamic value = js_util.getProperty(obj, key);
      return value?.toString();
    } catch (e) {
      print('Error getting property $key: $e');
      return null;
    }
  }

  // Debug methods
  static void debugCashfree() {
    try {
      if (js.context.hasProperty('debugCashfree')) {
        js.context.callMethod('debugCashfree');
      }
    } catch (e) {
      print('Debug error: $e');
    }
  }
}

// Payment result model
class PaymentResult {
  final String status;
  final String? orderId;
  final String? paymentId;
  final String? signature;
  final String? message;

  PaymentResult({
    required this.status,
    this.orderId,
    this.paymentId,
    this.signature,
    this.message,
  });

  bool get isSuccess => status.toLowerCase() == 'success';

  factory PaymentResult.fromMap(Map<String, dynamic> map) {
    return PaymentResult(
      status: map['status'] ?? 'FAILED',
      orderId: map['orderId'],
      paymentId: map['paymentId'],
      signature: map['signature'],
      message: map['message'],
    );
  }

  @override
  String toString() {
    return 'PaymentResult(status: $status, orderId: $orderId, paymentId: $paymentId)';
  }
}