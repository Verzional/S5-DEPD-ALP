// lib/models/favorite_model.dart

class FavoriteModel {
  final String id;        // ID unik untuk record favorit ini
  final String userId;    // Siapa yang menyukai?
  final String jobId;     // Pekerjaan apa yang disukai?
  final bool isFavorite;  // Status: true (disimpan) atau false (sudah di-unlike)

  FavoriteModel({
    required this.id,
    required this.userId,
    required this.jobId,
    required this.isFavorite,
  });

  // Helper untuk membuat salinan objek dengan nilai baru (berguna untuk update status)
  FavoriteModel copyWith({
    String? id,
    String? userId,
    String? jobId,
    bool? isFavorite,
  }) {
    return FavoriteModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      jobId: jobId ?? this.jobId,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}