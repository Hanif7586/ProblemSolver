
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/login_model.dart';
import '../../models/post_model.dart';
import '../../models/register_model.dart';
import '../../utils/endpoints.dart';

class ApiService {




  //fetchproblempost
  static Future<List<Post>> fetchPosts() async {
    final response = await http.get(
      ApiEndpoints.problempost,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    print('Status: ${response.statusCode}');
    print('Raw Body: ${response.body}');

    if (response.statusCode == 200) {
      try {
        final body = jsonDecode(response.body);
        print('Decoded Body: $body');

        // ✅ Access posts > data
        if (body is Map &&
            body['posts'] is Map &&
            body['posts']['data'] is List) {
          final List data = body['posts']['data'];
          return data.map((json) => Post.fromJson(json)).toList();
        } else {
          throw Exception('Unexpected JSON structure');
        }
      } catch (e) {
        print('JSON Parse Error: $e');
        throw Exception('Invalid JSON response');
      }
    } else {
      throw Exception('Failed to load posts: ${response.statusCode}');
    }
  }







  static Future<bool> addComment(int postId, String content) async {
    final url = ApiEndpoints.comments;  // এখানে সরাসরি ApiEndpoints.comments ইউজ করলাম
    final body = {
      "module_id": postId.toString(),
      "content": content,
      "module": "post",
      "type": "comment",
    };

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',

      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print('Failed to add comment: ${response.body}');
      return false;
    }
  }





  Future<Map<String, dynamic>> register(User user) async {
    try {
      final response = await http.post(
        ApiEndpoints.register,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 201) {
        return {'success': true, 'data': responseData};
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Registration failed'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }


  static Future<LoginResponse?> login(String email, String password) async {
    final response = await http.post(
      ApiEndpoints.login, // Use the endpoint from the centralized class
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'login': email,
        'password': password,
      },
    );

    print("Status: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return LoginResponse.fromJson(data);
    } else {
      print("Login failed: ${response.body}");
      return null;
    }
  }



  // Image compression helper
  static Future<File> compressImage(File file) async {
    final rawImage = img.decodeImage(await file.readAsBytes());
    if (rawImage == null) return file;

    final compressedBytes = img.encodeJpg(rawImage, quality: 70); // adjust quality here

    final tempDir = await getTemporaryDirectory();
    final compressedPath = '${tempDir.path}/compressed_${basename(file.path)}';
    final compressedFile = File(compressedPath)..writeAsBytesSync(compressedBytes);

    return compressedFile;
  }

  // Multipart POST method for problem upload
  static Future<http.StreamedResponse> postProblem({
    required String token,
    required String userId,
    required String title,
    required String content,
    File? imageFile,
  }) async {
    final uri = ApiEndpoints.problempost;
    var request = http.MultipartRequest('POST', uri);

    // Add headers
    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    // Add form fields
    request.fields['title'] = title;
    request.fields['content'] = content;
    request.fields['user_id'] = userId;

    // Add image file if available
    if (imageFile != null) {
      final compressed = await compressImage(imageFile);
      final multipartFile = await http.MultipartFile.fromPath(
        'image',
        compressed.path,
        filename: basename(imageFile.path),
      );
      request.files.add(multipartFile);
    }

    return await request.send(); // Sends multipart request
  }
}
