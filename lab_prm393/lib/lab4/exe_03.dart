import 'package:flutter/material.dart';

class Exercise3Page extends StatelessWidget {
  const Exercise3Page({super.key});

  final List<Map<String, String>> movies = const [
    {
      'letter': 'A',
      'title': 'Avatar',
      'description': 'A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following orders and protecting the world he feels is his home.',
    },
    {
      'letter': 'I',
      'title': 'Inception',
      'description': 'A thief who steals corporate secrets through dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.',
    },
    {
      'letter': 'I',
      'title': 'Interstellar',
      'description': "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.",
    },
    {
      'letter': 'J',
      'title': 'Joker',
      'description': 'A mentally troubled stand-up comedian embarks on a downward spiral that leads to the creation of an iconic villain.',
    },
    {
      'letter': 'T',
      'title': 'Tenet',
      'description': 'Armed with only one word, Tenet, and fighting for the survival of the entire world, a Protagonist journeys through a twilight world of international espionage.',
    },
    {
      'letter': 'D',
      'title': 'Dune',
      'description': "A noble family becomes embroiled in a war for control over the galaxy's most valuable asset while its heir becomes troubled by visions of a dark future.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise 3 – Layout Basics: Column, Row, Padding, ListView"),
      ),
      body:  Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16.0), // 16px horizontal padding
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 6.0), // 12px spacing between items
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 12), // 12px padding inside card
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Text(
                        movie['letter']!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          movie['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4), // 8px spacing between title and subtitle
                    child: Text(
                          movie['description']!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                  ),
                  isThreeLine: true,
                ),
              ),
            );
          },
        ),
      ),
      );
  }
}

// Extracted CategoryChip widget
class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16, // 16px horizontal padding
        vertical: 8,    // 8px vertical padding
      ),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}