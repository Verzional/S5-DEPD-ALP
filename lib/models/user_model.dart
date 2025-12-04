// lib/models/user_model.dart

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String major;
  final int semester;
  final String photoUrl;
  
  final String? savedCvName;
  final String? savedPortfolioName;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.major,
    required this.semester,
    required this.photoUrl,
    this.savedCvName,
    this.savedPortfolioName,
  });
}