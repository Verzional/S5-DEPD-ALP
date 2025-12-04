import 'package:flutter/material.dart';

class CandidateCard extends StatelessWidget {
  const CandidateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 14),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Administration",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff5b7df8),
                  ),
                ),
                Icon(
                  Icons.open_in_new,
                  color: Color(0xff5b7df8),
                  size: 22,
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xff82b6ff),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Text(
                      "John Doe",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 12),

                Text(
                  "Experienced Administration professional with a proven track "
                  "record in organizations and operations. Available for hire, "
                  "bringing strong skills in communication, problem solving, "
                  "and team leadership.",
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.45,
                    color: Color(0xff505050),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
