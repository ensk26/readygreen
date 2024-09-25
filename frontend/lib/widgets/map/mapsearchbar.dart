import 'package:flutter/material.dart';

class MapSearchBar extends StatelessWidget {
  final Function(String) onSearchSubmitted;
  // final Function() onVoiceSearch;
  final Function(String) onSearchChanged;
  final Function()? onTap;

  const MapSearchBar({
    super.key,
    required this.onSearchSubmitted,
    // required this.onVoiceSearch,
    required this.onSearchChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.black54),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: '검색어를 입력하세요.',
                border: InputBorder.none,
              ),
              onTap: onTap,
              onChanged: onSearchChanged,
              onSubmitted: (value) {
                onSearchSubmitted(value);
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.mic_none_rounded, color: Colors.black54),
            onPressed: () {
              // onVoiceSearch();
            },
          ),
        ],
      ),
    );
  }
}
