class Login {
  final int? id;
  final String? phone;
  final String? name;
  final String? email;

  Login({this.id, this.phone, this.name, this.email});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      id: json['id'],
      phone: json['phone'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'name': name,
      'email': email,
    };
  }
}

class LoginResponse {
  final String token;
  final Login user;
  final String message;

  LoginResponse({required this.token, required this.user, required this.message});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      user: Login.fromJson(json['user']),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user.toJson(),
      'message': message,
    };
  }
}
