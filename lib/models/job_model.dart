// lib/models/job_model.dart

class JobModel {
  final String id;
  final String title;
  final String companyName;
  final String companyLogoUrl;
  final String location;
  final String type;
  final String salaryRange;
  
  final List<String> category; 
  
  final String description;
  final List<String> responsibilities;
  final List<String> qualifications;
  final List<String> benefits;

  JobModel({
    required this.id,
    required this.title,
    required this.companyName,
    required this.companyLogoUrl,
    required this.location,
    required this.type,
    required this.salaryRange,
    required this.category,
    this.description = "", 
    this.responsibilities = const [],
    this.qualifications = const [],
    this.benefits = const [],
  });
}