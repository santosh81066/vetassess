// lib/services/cashfree_service.dart
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:js_util' as js_util;
import 'dart:async';
import 'dart:convert';

class CashfreeService {
  // Use only public/client-side credentials
  static const String _appId = '992060107cd5c2bce28587a7e7060299';
  static const String _environment =
      'sandbox'; // Change to 'production' for live

  // Simple flag to track payment state
  static bool _isPaymentActive = false;

  static void initiateDropInPayment({
    required double amount,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
    required Function(Map<String, dynamic>) onSuccess,
    required Function(String) onFailure,
    String? orderId,
  }) {
    // Prevent multiple payments
    if (_isPaymentActive) {
      onFailure('Payment already in progress');
      return;
    }

    try {
      _isPaymentActive = true;
      final orderIdFinal =
          orderId ?? 'ORDER_${DateTime.now().millisecondsSinceEpoch}';

      // Use a unique callback name for this payment
      final callbackName =
          'cashfreeCallback_${DateTime.now().millisecondsSinceEpoch}';

      // Set up one-time callback
      js.context[callbackName] = js.allowInterop((dynamic result) {
        print('Payment callback executed: $result');

        // Immediately remove the callback to prevent loops
        js.context[callbackName] = null;
        _isPaymentActive = false;

        try {
          if (result != null) {
            String status = _getStringProperty(result, 'status') ?? 'FAILED';

            if (status.toUpperCase() == 'SUCCESS') {
              Map<String, dynamic> resultMap = {
                'status': status,
                'orderId': _getStringProperty(result, 'orderId'),
                'paymentId': _getStringProperty(result, 'paymentId'),
                'signature': _getStringProperty(result, 'signature'),
              };
              onSuccess(resultMap);
            } else {
              String message =
                  _getStringProperty(result, 'message') ?? 'Payment failed';
              onFailure(message);
            }
          } else {
            onFailure('No payment result received');
          }
        } catch (e) {
          print('Callback error: $e');
          onFailure('Payment processing error: $e');
        }
      });

      // For production, you should create order on your backend
      // and get paymentSessionId. For now, we'll use order details directly
      _startPayment(
        orderIdFinal,
        amount,
        customerName,
        customerEmail,
        customerPhone,
        callbackName,
        onFailure,
      );

      // Safety timeout
      Timer(Duration(minutes: 10), () {
        if (_isPaymentActive) {
          print('Payment timeout - cleaning up');
          if (js.context[callbackName] != null) {
            js.context[callbackName] = null;
          }
          _isPaymentActive = false;
          onFailure('Payment timeout');
        }
      });
    } catch (e) {
      _isPaymentActive = false;
      onFailure('Error starting payment: $e');
    }
  }

  static void _startPayment(
    String orderId,
    double amount,
    String customerName,
    String customerEmail,
    String customerPhone,
    String callbackName,
    Function(String) onFailure,
  ) {
    // In a real app, you should:
    // 1. Call your backend to create an order
    // 2. Get paymentSessionId from the response
    // 3. Pass paymentSessionId to the frontend

    // For demo purposes, we're passing order details directly
    html.window.postMessage({
      'type': 'start_cashfree_payment',
      'data': {
        'appId': _appId,
        'orderId': orderId,
        'amount': amount,
        'customerName': customerName,
        'customerEmail': customerEmail,
        'customerPhone': customerPhone,
        'environment': _environment,
        'callbackName': callbackName,
        // Note: In production, you should get this from your backend
        // 'paymentSessionId': 'session_id_from_backend',
      },
    }, '*');
  }

  // Create order (this should be done on your backend in production)
  static Future<Map<String, dynamic>?> createOrder({
    required String orderId,
    required double amount,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
  }) async {
    // WARNING: This is for demo only - never put secret keys in frontend!
    // In production, this should be done on your backend server

    try {
      // This is just a placeholder - you need to implement backend order creation
      return {
        'orderId': orderId,
        'paymentSessionId': 'demo_session_id', // This should come from backend
        'status': 'OK',
      };
    } catch (e) {
      print('Error creating order: $e');
      return null;
    }
  }

  // Simple property extraction
  static String? _getStringProperty(dynamic obj, String key) {
    try {
      if (obj == null) return null;

      // Try direct access first
      if (obj is Map) {
        return obj[key]?.toString();
      }

      // Try JS property access
      dynamic value = js_util.getProperty(obj, key);
      return value?.toString();
    } catch (e) {
      print('Error getting property $key: $e');
      return null;
    }
  }

  static void ensureCashfreeSDKLoaded() {
    print('Checking Cashfree SDK...');

    // Check if Cashfree is available
    Timer.periodic(Duration(seconds: 1), (timer) {
      try {
        var cashfree = js.context['Cashfree'];
        if (cashfree != null) {
          print('Cashfree SDK loaded successfully');
          timer.cancel();
        }
      } catch (e) {
        // Still loading
      }
    });
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
}

// Extension for URL parameters (keeping for compatibility)
extension CashfreeUrlHandler on String {
  Map<String, String> get urlParameters {
    final uri = Uri.parse(this);
    return uri.queryParameters;
  }
}
