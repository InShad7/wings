import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:wings/controller/db/db_fun.dart';

class UserProvider extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();


//fetch user from api
  Future<List<dynamic>> fetchUser() async {
    try {
      final response = await http
          .get(Uri.parse('https://64ccfcf4bb31a268409a37b0.mockapi.io/user'));

      if (response.statusCode == 200) {
        final users = json.decode(response.body);
        await saveUserToLocal(users); // save fetched data to local storage
        return users; // return fetched data
      } else {
        Fluttertoast.showToast(
            msg: 'Failed to fetch posts. Status code: ${response.statusCode}');
        throw Exception(
            'Failed to fetch posts. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data from API: $e');

      // load data from local storage
      final _db = await db;
      final List<Map<String, dynamic>> localUsers = await _db.query('user');
      // await _db.close();

      if (localUsers.isNotEmpty) {
        return localUsers;
      } else {
        Fluttertoast.showToast(msg: 'Failed to fetch posts. Status code: ${e}');
        throw Exception('Failed to fetch posts. Error: $e');
      }
    }
  }

//clear the controllers
  clearPostController() {
    titleController.clear();
    bodyController.clear();
  }


//create  a new user
  Future<Map<String, dynamic>> createUser() async {
    try {
      //data for new user
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

//save user to local storage
  Future<void> saveUserToLocal(List<dynamic> users) async {
    try {
      //open the database
      final _db = await db;
      await _db.transaction((database) async {
        await database.rawDelete('DELETE FROM user');

        for (var user in users) {
          await database.insert('user', {
            'id': user['id'],
            'name': user['name'],
            'description': user['description'],
          });
        }
      });
      // await _db.close();
      print('Data stored in local storage: $users');
    } catch (e) {
      print('Error saving data to local storage: $e');
    }
  }
}
