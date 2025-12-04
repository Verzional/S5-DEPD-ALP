import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  final String name;
  final String bio;
  final String location;

  const StudentCard({
    super.key,
    required this.name,
    required this.bio,
    required this.location,
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
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            bio,
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
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Recruit"),
            ),
          ),
        ],
      ),
    );
  }
}
