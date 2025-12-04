import 'package:flutter/material.dart';
import 'dart:math'; 

import 'apply_modal_components.dart';
import '../models/job_model.dart';
import '../data/dummy_data.dart';

import 'listjob.dart';

class AppColors {
  static const Color backgroundCream = Color(0xFFFFF8F4);
  static const Color whiteCard = Colors.white;
  static const Color gradientStart = Color(0xFFFF8C42);
  static const Color gradientEnd = Color(0xFFFF3E8D);
  static const Color textDark = Color(0xFF2D3436);
  static const Color textGrey = Color(0xFF636E72);
  static const Color textLightGrey = Color(0xFFB2B2B2);
  static const Color iconGrey = Color(0xFF9E9E9E);
}

class TextStyles {
  static const TextStyle h1 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );
  static const TextStyle h2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );
  static const TextStyle h3 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );
  static const TextStyle body = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    color: AppColors.textGrey,
    height: 1.6,
  );
  static const TextStyle detailText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15,
    color: AppColors.textDark,
    fontWeight: FontWeight.w500,
  );
}

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double height;
  final double fontSize;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 45,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.gradientStart, AppColors.gradientEnd],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}

class JobDetailPage extends StatelessWidget {
  // Parameter Data Pekerjaan
  final String id;
  final String jobTitle;
  final String companyName;
  final String jobType;
  final String location;
  final String salaryRange;
  final String logoUrl;

  final List<String> category;

  final String description;
  final List<String> responsibilities;
  final List<String> qualifications;
  final List<String> benefits;

  const JobDetailPage({
    super.key,
    this.id = "",
    required this.jobTitle,
    required this.companyName,
    required this.jobType,
    required this.location,
    required this.salaryRange,
    required this.logoUrl,
    this.category = const [],
    required this.description,
    required this.responsibilities,
    required this.qualifications,
    required this.benefits,
  });

  List<JobModel> _getSimilarJobs() {
    if (category.isEmpty) return [];

    var similar = dummyJobs.where((item) {
      if (item.id == id) return false;

      bool hasMatchingCategory = item.category.any(
        (cat) => category.contains(cat),
      );
      return hasMatchingCategory;
    }).toList();

    similar.shuffle();
    return similar.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    final similarJobsList = _getSimilarJobs();

    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textDark),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const JobListingPage()),
              (route) => false, 
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 100.0,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Header Section
                  JobHeaderSection(
                    title: jobTitle,
                    company: companyName,
                    type: jobType,
                    location: location,
                    salary: salaryRange,
                    logoUrl: logoUrl,
                    category: category,
                  ),

                  const SizedBox(height: 40),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 2. Kolom Kiri: Deskripsi Lengkap
                      Expanded(
                        flex: 7,
                        child: Container(
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            color: AppColors.whiteCard,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 20,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: JobDescriptionContent(
                            description: description,
                            responsibilities: responsibilities,
                            qualifications: qualifications,
                            benefits: benefits,
                          ),
                        ),
                      ),

                      const SizedBox(width: 30),

                      // 3. Kolom Kanan: Sidebar Pekerjaan Serupa (Dinamis)
                      Expanded(
                        flex: 3,
                        child: SimilarJobsSidebar(similarJobs: similarJobsList),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

// ================= HEADER SECTION =================
class JobHeaderSection extends StatelessWidget {
  final String title;
  final String company;
  final String type;
  final String location;
  final String salary;
  final String logoUrl;
  final List<String> category;

  const JobHeaderSection({
    super.key,
    required this.title,
    required this.company,
    required this.type,
    required this.location,
    required this.salary,
    required this.logoUrl,
    this.category = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.grey[200],
              backgroundImage: NetworkImage(logoUrl),
              onBackgroundImageError: (_, __) {},
            ),
            const SizedBox(width: 12),
            Text(
              company.toUpperCase(),
              style: TextStyles.h3.copyWith(color: AppColors.textGrey),
            ),
          ],
        ),
        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(title, style: TextStyles.h1)),
            Icon(Icons.bookmark_border, color: AppColors.textDark, size: 28),
          ],
        ),
        const SizedBox(height: 25),

        DetailItem(icon: Icons.location_on_outlined, text: location),
        DetailItem(icon: Icons.access_time, text: type),
        DetailItem(icon: Icons.monetization_on_outlined, text: salary),

        if (category.isNotEmpty)
          DetailItem(icon: Icons.category_outlined, text: category.join(", ")),

        const SizedBox(height: 30),

        Align(
          alignment: Alignment.centerRight,
          child: GradientButton(
            text: "Apply",
            width: 120,
            height: 45,
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return ApplyJobModalWrapper(jobTitle: title);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class DetailItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const DetailItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.iconGrey, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: TextStyles.detailText)),
        ],
      ),
    );
  }
}

// ================= KONTEN DESKRIPSI =================
class JobDescriptionContent extends StatelessWidget {
  final String description;
  final List<String> responsibilities;
  final List<String> qualifications;
  final List<String> benefits;

  const JobDescriptionContent({
    super.key,
    required this.description,
    required this.responsibilities,
    required this.qualifications,
    required this.benefits,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Job Description", style: TextStyles.h2),
        const SizedBox(height: 16),
        Text(description, style: TextStyles.body),
        const SizedBox(height: 30),

        if (responsibilities.isNotEmpty) ...[
          const Text("Responsibilities", style: TextStyles.h2),
          const SizedBox(height: 16),
          BulletList(items: responsibilities),
          const SizedBox(height: 30),
        ],

        if (qualifications.isNotEmpty) ...[
          const Text("Qualifications", style: TextStyles.h2),
          const SizedBox(height: 16),
          BulletList(items: qualifications),
          const SizedBox(height: 30),
        ],

        if (benefits.isNotEmpty) ...[
          const Text("Benefits", style: TextStyles.h2),
          const SizedBox(height: 16),
          BulletList(items: benefits),
        ],
      ],
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> items;
  const BulletList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "• ",
                style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              Expanded(child: Text(item, style: TextStyles.body)),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ================= SIDEBAR SERUPA =================
class SimilarJobsSidebar extends StatelessWidget {
  final List<JobModel> similarJobs;

  const SimilarJobsSidebar({super.key, this.similarJobs = const []});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Pekerjaan Serupa", style: TextStyles.h2),
        const SizedBox(height: 20),

        if (similarJobs.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Tidak ada pekerjaan serupa saat ini.",
              style: TextStyle(color: Colors.grey),
            ),
          )
        else
          ...similarJobs.map((job) => SimilarJobCard(job: job)),
      ],
    );
  }
}

class SimilarJobCard extends StatelessWidget {
  final JobModel job;

  const SimilarJobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteCard,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[200],
            backgroundImage: NetworkImage(job.companyLogoUrl),
            onBackgroundImageError: (_, __) {},
          ),
          const SizedBox(height: 15),
          Text(job.title, style: TextStyles.h3.copyWith(fontSize: 18)),
          const SizedBox(height: 8),
          Text(
            job.companyName,
            style: TextStyles.body.copyWith(color: AppColors.textGrey),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: AppColors.textGrey,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  job.location,
                  style: TextStyles.body.copyWith(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GradientButton(
            text: "Lihat Detail",
            width: double.infinity,
            height: 40,
            fontSize: 12,
            onPressed: () {
              // Navigasi Rekursif tetap menggunakan Push biasa agar bisa di-back
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobDetailPage(
                    id: job.id,
                    jobTitle: job.title,
                    companyName: job.companyName,
                    jobType: job.type,
                    location: job.location,
                    salaryRange: job.salaryRange,
                    logoUrl: job.companyLogoUrl,
                    category: job.category,
                    description: job.description,
                    responsibilities: job.responsibilities,
                    qualifications: job.qualifications,
                    benefits: job.benefits,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ================= FOOTER =================
class Footer extends StatelessWidget {
  const Footer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(80, 60, 80, 30),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.gradientStart,
                                AppColors.gradientEnd,
                              ],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            "UC",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "UC HUB",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Platform job & internship\nuntuk mahasiswa\nUniversitas Ciputra.",
                      style: TextStyle(color: AppColors.textGrey, height: 1.5),
                    ),
                  ],
                ),
              ),
              _footerLinkColumn("Platform", [
                "For Students",
                "For Companies",
                "For Departments",
              ]),
              _footerLinkColumn("Resources", [
                "Help Center",
                "Career Guide",
                "Blog",
              ]),
              _footerLinkColumn("Legal", ["Privacy", "Terms", "Contact"]),
            ],
          ),
          const SizedBox(height: 60),
          Divider(color: Colors.grey[200]),
          const SizedBox(height: 30),
          const Text(
            "© 2025 UC HUB — Universitas Ciputra. All rights reserved.",
            style: TextStyle(color: AppColors.textLightGrey),
          ),
        ],
      ),
    );
  }

  Widget _footerLinkColumn(String title, List<String> links) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 20),
          ...links.map(
            (link) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                link,
                style: const TextStyle(color: AppColors.textGrey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
