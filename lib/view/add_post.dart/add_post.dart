import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:wings/controller/provider/provider.dart';
import '../utils/utils.dart';
import 'widget/custom_text_field.dart';

Future addPost({context}) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Consumer<UserProvider>(
        builder: (BuildContext context, postModel, _) {
          return Container(
            padding: const EdgeInsets.all(16),
            color: white,
            child: Column(
              children: [
                kHeight30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        postModel.clearPostController();
                      },
                      icon: const Icon(Icons.close),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (postModel.titleController.text.isNotEmpty &&
                            postModel.bodyController.text.isNotEmpty) {
                          postModel.createUser();
                          Navigator.pop(context);
                          Navigator.pop(context);
                         
                        } else {
                          Fluttertoast.showToast(msg: 'Enter valid data');
                        }
                      },
                      child: const Text(
                        'Create',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                CustomTextfield(
                  controller: postModel.titleController,
                  hintText: 'What\'s your name?',
                  maxLen: 20,
                ),
                CustomTextfield(
                  controller: postModel.bodyController,
                  hintText: 'What\'s your address?',
                  maxLen: 100,
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
