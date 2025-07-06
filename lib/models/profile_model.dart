class ProfileModel {
  final int id;
  final String name, email, profile_photo, reference, coin;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profile_photo,
    required this.reference,
    required this.coin,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profile_photo: json['profile_photo'] ?? '',
      reference: json['reference'] ?? '',
      coin: json['coin']?.toString() ?? '',
    );
  }
}
