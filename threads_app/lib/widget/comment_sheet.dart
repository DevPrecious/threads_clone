import 'package:flutter/material.dart';
import 'package:threads_app/controller/post_controller.dart';
import 'package:threads_app/models/post_model.dart';
import 'package:get/get.dart';

class CommentSheet extends StatelessWidget {
  final PostsModel post;

  const CommentSheet({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final PostController postController = Get.put(PostController());
    final TextEditingController commentController = TextEditingController();
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.user!.username ?? ''),
                      SizedBox(
                        height: 10,
                      ),
                      Text(post.body ?? ''),
                      SizedBox(
                        height: 10,
                      ),
                      post.image == null
                          ? const SizedBox()
                          : Container(
                              width: double.infinity,
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(post.image ?? ''),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Username'),
                      TextField(
                        autofocus: true,
                        controller: commentController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Reply to ${post.user!.username ?? ''}',
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GetBuilder<PostController>(
                          init: postController,
                          builder: (controller) {
                            return controller.isLoading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () async {
                                      await controller.postComment(
                                        post.id.toString(),
                                        commentController.text.trim(),
                                      );
                                      commentController.text = '';
                                    },
                                    child: Text('Reply'),
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

