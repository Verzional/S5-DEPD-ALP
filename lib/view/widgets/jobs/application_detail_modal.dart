import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../model/application_model.dart';

class AppColors {
  static const Color backgroundCream = Color(0xFFFFF8F4);
  static const Color textDark = Color(0xFF2D3436);
  static const Color textGrey = Color(0xFF636E72);
  static const Color whiteCard = Colors.white;
  static const Color gradientStart = Color(0xFFFF8C42);
  static const Color gradientEnd = Color(0xFFFF3E8D);

  static const Color statusGreen = Color(0xFF4CD964);
  static const Color statusYellow = Color(0xFFFFCC00);
  static const Color statusBlue = Color(0xFF5856D6);
  static const Color statusRed = Color(0xFFFF3B30);
}

class ApplicationDetailModal extends StatelessWidget {
  final ApplicationModel applicationData;

  const ApplicationDetailModal({super.key, required this.applicationData});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Color badgeColor;
    switch (applicationData.status) {
      case "Diterima":
        badgeColor = AppColors.statusGreen;
        break;
      case "Ditinjau":
        badgeColor = AppColors.statusYellow;
        break;
      case "Wawancara":
        badgeColor = AppColors.statusBlue;
        break;
      case "Ditolak":
        badgeColor = AppColors.statusRed;
        break;
      default:
        badgeColor = AppColors.textGrey;
    }

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Container(
          width: screenWidth > 700 ? 700 : screenWidth * 0.9,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // --- HEADER ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Detail Aplikasi: ${applicationData.jobTitle}",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.textGrey,
                        size: 28,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // --- STATUS ---
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: badgeColor.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    applicationData.status,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline Progress
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: applicationData.timeline.asMap().entries.map((
                          entry,
                        ) {
                          int idx = entry.key;
                          var event = entry.value;

                          IconData icon = event.isCompleted
                              ? Icons.check_circle
                              : (event.isActive
                                    ? Icons.radio_button_checked
                                    : Icons.circle_outlined);
                          Color color = event.isActive
                              ? badgeColor
                              : (event.isCompleted
                                    ? AppColors.statusGreen
                                    : AppColors.textGrey);

                          return _TimelineItem(
                            icon: icon,
                            color: color,
                            date: event.date,
                            title: event.title,
                            subtitle: event.subtitle,
                            isFirst: idx == 0,
                            isLast: idx == applicationData.timeline.length - 1,
                            isActive: event.isActive,
                          );
                        }).toList(),
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Dokumen Terkirim",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(height: 20),

                          _DocumentItem(
                            title: "CV",
                            fileName: applicationData.cvFileName,
                          ),

                          if (applicationData.portfolioFileName != null) ...[
                            const SizedBox(height: 15),
                            _DocumentItem(
                              title: "Portofolio",
                              fileName: applicationData.portfolioFileName!,
                            ),
                          ],

                          if (applicationData.coverLetterFileName != null) ...[
                            const SizedBox(height: 15),
                            _DocumentItem(
                              title: "Motivation Letter",
                              fileName: applicationData.coverLetterFileName!,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),

                if (applicationData.status == "Ditolak") ...[
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA53F3F),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Lihat Alasan",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String date;
  final String title;
  final String? subtitle;
  final bool isFirst;
  final bool isLast;
  final bool isActive;

  const _TimelineItem({
    required this.icon,
    required this.color,
    required this.date,
    required this.title,
    this.subtitle,
    this.isFirst = false,
    this.isLast = false,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isActive ? Colors.white : color,
                  shape: BoxShape.circle,
                  border: isActive ? Border.all(color: color, width: 3) : null,
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: color.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  icon,
                  color: isActive ? color : Colors.white,
                  size: 20,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.grey[300],
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 30.0, top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: AppColors.textGrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isActive ? AppColors.textDark : AppColors.textGrey,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentItem extends StatelessWidget {
  final String title;
  final String fileName;
  const _DocumentItem({required this.title, required this.fileName});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                fileName,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: AppColors.textGrey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            side: const BorderSide(color: AppColors.textGrey),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.white,
          ),
          child: const Text(
            "Lihat",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: AppColors.textGrey,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
