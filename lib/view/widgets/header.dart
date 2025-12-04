import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xffFF6F61),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "UC",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "UC HUB",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff333333),
                ),
              ),
            ],
          ),

          // Navigation
          Row(
            children: [
              _headerLink("Home"),
              _headerLink("Features"),
              _headerLink("How it Works"),
              _headerLink("About"),

              const SizedBox(width: 18),

              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(width: 15),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xffff8a8a), Color(0xffff69c2)],
                  ),
                ),
                child: const Text(
                  "Register Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _headerLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xff333333),
        ),
      ),
    );
  }
}
