import 'package:get/get.dart';

import '../core/services/api_service.dart';
import '../models/post_model.dart';

class PostController extends GetxController {
  var posts = <Post>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      isLoading(true);
      final fetchedPosts = await ApiService.fetchPosts();
      posts.value = fetchedPosts;
    } catch (e) {
      print("Error fetching posts: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> addComment(int postId, String content) async {
    final success = await ApiService.addComment(postId, content);
    if (success) {
      fetchPosts();
    }
  }
}
