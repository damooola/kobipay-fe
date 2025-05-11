import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:kobipay_fe/consts.dart';
import 'package:kobipay_fe/db/transaction_db.dart';
import 'package:kobipay_fe/models/transaction_history.dart';
import 'package:http/http.dart' as http;

class KobiPayTransactionApi {
   List<KobiPayTransaction> getTransactionHistoryFromLocal() {
    return KobiPayTransactionDB.kobiPayTransactions;
  }

   List<KobiPayTransaction> getTransactionHistoryFromJsonList() {
    return KobiPayTransactionDB.mockJsonList
        .map((json) => KobiPayTransaction.fromjson(json))
        .toList();
  }

  Future<List<KobiPayTransaction>> getTransactionHistoryFromLocalJson() async {
    final String response = await rootBundle.loadString(kobiPayMockJson);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => KobiPayTransaction.fromjson(json)).toList();
  }

  //mock api call
  Future<List<KobiPayTransaction>> getTransactionHistoryFromRemote() async {
    final String url = '';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => KobiPayTransaction.fromjson(json)).toList();
      } else {
        throw Exception('Failed to load transactions from remote server');
      }
    } catch (e) {
      throw Exception('Error fetching transactions: $e');
    }
  }
}
