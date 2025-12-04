// lib/models/application_model.dart

class TimelineEvent {
  final String title;
  final String date;
  final bool isCompleted;
  final bool isActive;
  final String? subtitle;

  TimelineEvent({
    required this.title,
    required this.date,
    this.isCompleted = false,
    this.isActive = false,
    this.subtitle,
  });
}

class ApplicationModel {
  final String id;
  final String userId; // --- FIELD BARU (PENTING) ---
  final String jobId;
  
  final String jobTitle;
  final String companyName;
  final String companyLogoUrl;
  final String location;
  final String type;
  
  final String appliedDate;
  final String status;
  
  final List<TimelineEvent> timeline; 
  final String cvFileName;
  final String? portfolioFileName;
  final String? coverLetterFileName;

  ApplicationModel({
    required this.id,
    required this.userId, // --- WAJIB DIISI ---
    required this.jobId,
    required this.jobTitle,
    required this.companyName,
    required this.companyLogoUrl,
    required this.location,
    required this.type,
    required this.appliedDate,
    required this.status,
    required this.timeline,
    required this.cvFileName,
    this.portfolioFileName,
    this.coverLetterFileName,
  });
}