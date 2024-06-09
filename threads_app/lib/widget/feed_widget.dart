import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_app/controller/post_controller.dart';
import 'package:threads_app/features/posts/single_post.dart';
import 'package:threads_app/models/post_model.dart';
import 'package:threads_app/widget/comment_sheet.dart';

class FeedWidget extends StatelessWidget {
  final PostsModel post;

  const FeedWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final PostController controller = Get.put(PostController());
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    post.user!.username ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    post.createdAt.toString(),
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.more_horiz,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
            Get.to(() => SinglePost(post: post),);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.body ?? '',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                post.image == null
                    ? Container()
                    : Container(
                        width: double.infinity,
                        height: 400,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(post.image!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    GetBuilder<PostController>(
                        init: controller,
                        builder: (controller) {
                          return InkWell(
                            onTap: () async {
                             await controller.likePost(post.id!);
                            },
                            child: post.isLiked!
                                ? const Icon(
                                    CupertinoIcons.heart_fill,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    CupertinoIcons.heart,
                                  ),
                          );
                        }),
                   Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                          isScrollControlled: true,
                            FractionallySizedBox(
                              heightFactor: 0.9,
                              child: CommentSheet(
                                  post: post,
                              ),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.comment,
                        ),
                      ),
                    ),
                    Icon(Icons.reset_tv),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Icons.share),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



