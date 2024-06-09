import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_app/constants/const.dart';
import 'package:threads_app/controller/post_controller.dart';
import 'package:threads_app/widget/feed_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PostController postController;

  @override
  void initState() {
    // TODO: implement onInit
    postController = Get.put(PostController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Icon(
          Icons.app_registration,
          size: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<PostController>(
                init: postController,
                builder: (controller) {
                  return controller.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.posts.value.length,
                          itemBuilder: (context, index) {
                            return FeedWidget(
                              post: controller.posts.value[index],
                            );
                          },
                        );
                })
          ],
        ),
      ),
    );
  }
}

