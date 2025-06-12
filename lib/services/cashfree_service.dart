// lib/services/cashfree_service.dart
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:js_util' as js_util;
import 'dart:async';

class CashfreeService {
  // Use only public/client-side credentials
  static const String _appId = '992060107cd5c2bce28587a7e7060299';
  static const String _environment = 'sandbox';

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
        print('Payment callback executed once');

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
          onFailure('Payment processing error');
        }
      });

      // Simple payment initiation
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
      Timer(Duration(minutes: 5), () {
        if (_isPaymentActive) {
          print('Payment timeout - cleaning up');
          js.context[callbackName] = null;
          _isPaymentActive = false;
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
    // Simple direct call without complex JavaScript
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
      },
    }, '*');
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
  }
}

// Simplified extensions and models
extension CashfreeUrlHandler on String {
  Map<String, String> get urlParameters {
    final uri = Uri.parse(this);
    return uri.queryParameters;
  }
}

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
}
