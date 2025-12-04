import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final String title;
  final String company;
  final String location;
  final List<String> tags;

  const JobCard({
    super.key,
    required this.title,
    required this.company,
    required this.location,
    this.tags = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          const SizedBox(
            height: 8,
          ), 
          // Content area
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            company,
            style: const TextStyle(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            location,
            style: const TextStyle(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 8),

          Row(
            children: tags.map((tag) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: tag == 'Remote'
                        ? Colors.blueAccent
                        : Colors.purpleAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
