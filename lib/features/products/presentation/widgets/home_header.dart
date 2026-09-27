import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.onSearchChanged});

  final ValueChanged<String> onSearchChanged;

  static const _primary = Color(0xFF004087);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Elevate Task - Mustafa Sayed',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: _primary,
            fontStyle: FontStyle.italic,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'what do you search for?',
                  hintStyle: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9CA3AF),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: _primary,
                    size: 22,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(color: _primary, width: 1.2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(color: _primary, width: 1.4),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: _primary,
                size: 26,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
