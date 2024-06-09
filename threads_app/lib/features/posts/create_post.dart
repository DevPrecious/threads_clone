import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threads_app/controller/logic_controller.dart';
import 'package:threads_app/controller/post_controller.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  late final LogicController logicController;
  late final PostController postController;
  
  late final TextEditingController bodyController;

  @override
  void initState() {
    // TODO: implement initState
    logicController = Get.put(LogicController());
    postController = Get.put(PostController());
    bodyController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Thread'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                GetBuilder<LogicController>(
                    init: logicController,
                    builder: (controller) {
                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Username',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            controller.imageFile != null
                                ? Container(
                                    height: 300,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(
                                          File(controller.imageFile!.path),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(),
                            TextField(
                              controller: bodyController,
                              autofocus: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "What's new?",
                                hintStyle: TextStyle(
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await controller
                                        .pickImage(ImageSource.gallery);
                                  },
                                  icon: Icon(Icons.photo_outlined),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await controller
                                        .pickImage(ImageSource.camera);
                                  },
                                  icon: Icon(Icons.camera_alt_outlined),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GetBuilder<PostController>(
                  init: postController,
                  builder: (controller) {
                    return GetBuilder<LogicController>(
                        init: logicController,
                        builder: (logic) {
                          return controller.isLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: () async {
                                    await controller.createPost(
                                      bodyController.text.trim(),
                                      logic.imageFile != null ? File(logic.imageFile!.path)
                                      : null,
                                    );
                                  },
                                  child: const Text('Post'),
                                );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

