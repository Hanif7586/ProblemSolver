import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/problem_fetch_controller.dart';
import '../../widgets/custom_app_bar.dart';

class HomeView extends StatelessWidget {
  final PostController controller = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // Wrap ListView.builder with RefreshIndicator
        return RefreshIndicator(
          onRefresh: () async {
            await controller.fetchPosts(); // Refresh posts
          },
          child: ListView.builder(
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {
              final post = controller.posts[index];
              final isCommentsVisible = false.obs;
              final commentController = TextEditingController();

              return Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.title,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(post.content),
                      if (post.image.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Image.network(
                            'https://hritinstitute.com/post/${post.image}', // Full URL
                            width: double.infinity,

                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Colors.grey,
                            ),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:0),

                        ),
                      SizedBox(height: 10),
                      TextField(
                        controller: commentController,
                        decoration: InputDecoration(
                          labelText: "Add a comment",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send, color: Colors.blueGrey),
                            onPressed: () async {
                              final content = commentController.text.trim();
                              if (content.isNotEmpty) {
                                await controller.addComment(post.id, content);
                                commentController.clear();
                                isCommentsVisible(true);
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(() => TextButton(
                        onPressed: () => isCommentsVisible.toggle(),
                        child: Text(
                          isCommentsVisible.value ? "Hide Comments" : "Show Comments",
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      )),
                      Obx(() {
                        if (!isCommentsVisible.value) return SizedBox.shrink();
                        if (post.comments.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("No comments yet."),
                          );
                        }
                        return Column(
                          children: post.comments.map((comment) {
                            return ListTile(
                              title: Text(comment.content),
                              subtitle: comment.images.isNotEmpty
                                  ? Wrap(
                                spacing: 8,
                                children: comment.images
                                    .map((img) => Image.network(
                                  img,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ))
                                    .toList(),
                              )
                                  : null,
                            );
                          }).toList(),
                        );
                      }),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}