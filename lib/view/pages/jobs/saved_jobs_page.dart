import 'package:flutter/material.dart';

import '../../../model/job_model.dart';
import '../../../data/dummy_jobs_data.dart';
import 'detailjob.dart';
import 'listjob.dart';

class SavedJobsPage extends StatefulWidget {
  const SavedJobsPage({super.key});

  @override
  State<SavedJobsPage> createState() => _SavedJobsPageState();
}

class AppColors {
  static const Color backgroundCream = Color(0xFFFFF8F4);
  static const Color filterBackground = Color(0xFFFFEFE2);
  static const Color gradientStart = Color(0xFFFF8C42);
  static const Color gradientEnd = Color(0xFFFF3E8D);
  static const Color textDark = Color(0xFF2D3436);
  static const Color textGrey = Color(0xFF636E72);
  static const Color textLightGrey = Color(0xFFB2B2B2);
  static const Color primaryOrange = Color(0xFFFF6B6B);
}

class _SavedJobsPageState extends State<SavedJobsPage> {
  List<JobModel> _displayedJobs = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteJobs();
  }

  void _loadFavoriteJobs() {
    final favoriteJobIds = dummyFavorites
        .where((fav) => fav.userId == currentUser.id && fav.isFavorite)
        .map((fav) => fav.jobId)
        .toList();

    setState(() {
      _displayedJobs = dummyJobs.where((job) {
        return favoriteJobIds.contains(job.id);
      }).toList();
    });
  }

  void _removeFromFavorites(String jobId) {
    setState(() {
      _displayedJobs.removeWhere((job) => job.id == jobId);

      final index = dummyFavorites.indexWhere(
        (fav) => fav.jobId == jobId && fav.userId == currentUser.id,
      );

      if (index != -1) {
        dummyFavorites.removeAt(index);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Job removed from favorites"),
        backgroundColor: AppColors.textDark,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: "Undo",
          textColor: AppColors.gradientStart,
          onPressed: () {
            //
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Saved Jobs",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _displayedJobs.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              itemCount: _displayedJobs.length,
              itemBuilder: (context, index) {
                final job = _displayedJobs[index];

                return Stack(
                  children: [
                    JobCard(
                      title: job.title,
                      company: job.companyName,
                      type: job.type,
                      location: job.location,
                      logoUrl: job.companyLogoUrl,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobDetailPage(
                              id: job.id,
                              category: job.category,
                              jobTitle: job.title,
                              companyName: job.companyName,
                              jobType: job.type,
                              location: job.location,
                              salaryRange: job.salaryRange,
                              logoUrl: job.companyLogoUrl,
                              description: job.description,
                              responsibilities: job.responsibilities,
                              qualifications: job.qualifications,
                              benefits: job.benefits,
                            ),
                          ),
                        );
                      },
                    ),

                    Positioned(
                      top: 15,
                      right: 15,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () => _removeFromFavorites(job.id),
                          icon: const Icon(
                            Icons.favorite,
                            color: AppColors.primaryOrange,
                          ),
                          tooltip: "Remove from favorites",
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.gradientStart.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.favorite_border,
              size: 60,
              color: AppColors.gradientStart,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "No Saved Jobs Yet",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Jobs you save will appear here.\nStart exploring now!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
