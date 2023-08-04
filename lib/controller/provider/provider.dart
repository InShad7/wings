import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class PostProvider extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  Future<List<dynamic>> fetchPosts() async {
    try {
      final response = await http
          .get(Uri.parse('https://64ccfcf4bb31a268409a37b0.mockapi.io/user'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to fetch posts. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts. Error: $e');
    }
  }

  clearPostController() {
    titleController.clear();
    bodyController.clear();
  }
}
