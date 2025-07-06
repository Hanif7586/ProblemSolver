import 'config.dart';

class ApiEndpoints {
  static final String apiUrl = '${AppConfig.baseUrl}/api';

  static final Uri register = Uri.parse('$apiUrl/user-register');
  static final Uri login = Uri.parse('$apiUrl/user-login');
  static final Uri problempost = Uri.parse('$apiUrl/posts');
  static final Uri comments = Uri.parse('$apiUrl/comments');



}
