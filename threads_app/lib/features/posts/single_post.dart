import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_app/constants/const.dart';
import 'package:threads_app/controller/post_controller.dart';
import 'package:threads_app/models/post_model.dart';
import 'package:threads_app/widget/comment_sheet.dart';

class SinglePost extends StatelessWidget {
  final PostsModel post;

  const SinglePost({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final PostController controller = Get.put(PostController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                    Icon(
                      Icons.more_horiz,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
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
                        GestureDetector(
                          onTap: () async {
                            await box.erase();
                          }, 
                          child: Icon(Icons.reset_tv),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.share),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Replies'),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: post.comments!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(post.comments![index].body ?? ''),
                          //subtitle: Text(post.comments![index]),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
