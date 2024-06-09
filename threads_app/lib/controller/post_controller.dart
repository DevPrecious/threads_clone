import 'package:get/get.dart';
import 'package:threads_app/services/api_services.dart';
import 'package:threads_app/models/post_model.dart';
import 'package:threads_app/constants/const.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:threads_app/widget/bottom_bar.dart';

class PostController extends GetxController {
  final ApiService _apiService =
      ApiService(baseUrl: 'http://172.20.10.4:8000/api/');
  bool isLoading = false;

  final Rx<List<PostsModel>> posts = Rx<List<PostsModel>>([]);

  @override
  void onInit() {
    getAllPosts();
    super.onInit();
  }

  void responseLoad() {
    isLoading = !isLoading;
    update();
  }

  Future<void> getAllPosts() async {
    responseLoad();
    try {
      var response = await _apiService.get(
        'threads',
        box.read('token'),
      );
      var data = response['threads'];
      print(data.length);
      print(data);
      posts.value = [];
      for (var item in data) {
        posts.value.add(PostsModel.fromJson(item));
      }
      update();
    } catch (e) {
      print(e.toString());
    } finally {
      responseLoad();
    }
  }

  Future<void> createPost(String body, File? image) async {
    responseLoad();
    final url = Uri.parse('http://172.20.10.4:8000/api/create/thread');
    final request = http.MultipartRequest('POST', url);
    request.headers['Accept'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ${box.read('token')}';
    request.fields['body'] = body;
    if (image != null) {
      request.files.add(
        await http.MultipartFile.fromPath('image', image.path),
      );
    }

    try {
      final response = await http.Response.fromStream(await request.send());
      print(response.body);
      if (response.statusCode == 201) {
        print(jsonDecode(response.body)['threads']);
        await getAllPosts();
        Get.snackbar('Success', 'posted');
        Get.to(() => const BottomBar());
      } else {
        Get.snackbar('Error', jsonDecode(response.body)['message']);
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      responseLoad();
    }
  }

  Future<void> likePost(int postId) async {
    final url = Uri.parse('http://172.20.10.4:8000/api/thread/like/$postId');
    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      if (response.statusCode == 201) {
        // Find the post in the list and update its isLiked status
        final postIndex = posts.value.indexWhere((post) => post.id == postId);
        print(postIndex);
        if (postIndex != -1) {
          posts.value[postIndex].isLiked = !posts.value[postIndex].isLiked!;
          update();
        }
      } else {
        final postIndex = posts.value.indexWhere((post) => post.id == postId);
        if (postIndex != -1) {
          posts.value[postIndex].isLiked = !posts.value[postIndex].isLiked!;
          update();
        }
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'An error occurred while liking the post');
    }
  }

  Future<void> postComment(postId, String body) async {
    responseLoad();
    try {
      final request = await _apiService.postWithToken(
        'thread/comment',
        {'thread_id': postId, 'body': body},
        box.read('token'),
      );
      print(request);
      if (request['message'] == "success") {
        await getAllPosts();
        Get.snackbar('Success', 'Reply sent');
      } else {
        Get.snackbar('Error', request['message']);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      responseLoad();
    }
  }
}
