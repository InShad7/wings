import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  Future<List<dynamic>> fetchUser() async {
    try {
      final response = await http
          .get(Uri.parse('https://64ccfcf4bb31a268409a37b0.mockapi.io/user'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        Fluttertoast.showToast(
            msg: 'Failed to fetch posts. Status code: ${response.statusCode}');

        throw Exception(
            'Failed to fetch posts. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts. Error: $e');
    }
  }

  Future<Map<String, dynamic>> createPost() async {
    try {
      final postData = {
        'id': null,
        'name': titleController.text,
        'description': bodyController.text,
      };
      final response = await http.post(
        Uri.parse('https://64ccfcf4bb31a268409a37b0.mockapi.io/user'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(postData),
      );

      if (response.statusCode == 201) {
        final createdPost = json.decode(response.body);
        notifyListeners();
        Fluttertoast.showToast(msg: 'user created successfully');

        clearPostController();
        print('Post created successfully: $createdPost');
        return createdPost;
      } else {
        Fluttertoast.showToast(
            msg: 'Failed to create post. Status code: ${response.statusCode}');

        throw Exception(
            'Failed to create post. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating post: $e');
      throw Exception('Failed to create post.');
    }
  }

  clearPostController() {
    titleController.clear();
    bodyController.clear();
  }
}
