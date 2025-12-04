import 'package:flutter/material.dart';
import 'widgets/header.dart';
import 'widgets/footer.dart';
import 'widgets/candidate_card.dart';

class ScoutPage extends StatelessWidget {
  const ScoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2e8ff),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(),

            const SizedBox(height: 40),

            const Text(
              "Scout Future Employees",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w700,
                color: Color(0xff5b1aa0),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Explore potential candidates that match your\ncompany’s needs.",
              style: TextStyle(
                fontSize: 16,
                height: 1.4,
                color: Color(0xff5b5b5b),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            // Candidate cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: List.generate(
                  5,
                  (index) => const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: CandidateCard(),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            const Footer(),
          ],
        ),
      ),
    );
  }
}
