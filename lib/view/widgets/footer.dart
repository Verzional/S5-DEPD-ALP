import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              bool isWide = constraints.maxWidth > 700;

              return isWide
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _footerColumn1(),
                        _footerColumn("Platform",
                            ["For Students", "For Companies", "For Departments"]),
                        _footerColumn("Resources",
                            ["Help Center", "Career Guide", "Blog"]),
                        _footerColumn("Legal", ["Privacy", "Terms", "Contact"]),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _footerColumn1(),
                        const SizedBox(height: 30),
                        _footerColumn("Platform",
                            ["For Students", "For Companies", "For Departments"]),
                        const SizedBox(height: 20),
                        _footerColumn("Resources",
                            ["Help Center", "Career Guide", "Blog"]),
                        const SizedBox(height: 20),
                        _footerColumn("Legal", ["Privacy", "Terms", "Contact"]),
                      ],
                    );
            },
          ),

          const SizedBox(height: 35),

          const Center(
            child: Text(
              "© 2025 UC HUB — Universitas Ciputra. All rights reserved.",
              style: TextStyle(
                color: Color(0xff6f6f6f),
                fontSize: 13,
              ),
            ),
          )
        ],
      ),
    );
  }

  // Column 1 (Logo and description)
  Widget _footerColumn1() {
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xffFF6F61),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "UC",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "UC HUB",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Text(
            "Platform job & internship untuk mahasiswa Universitas Ciputra.",
            style: TextStyle(
              color: Color(0xff505050),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // Other footer columns
  Widget _footerColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 15),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xff505050),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
