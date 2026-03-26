import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'movie_card.dart';

class CustomResponsiveGrid extends StatelessWidget {
  final List<Movie> movies;
  final double maxWidth;

  const CustomResponsiveGrid({
    super.key,
    required this.movies,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    // Tính số cột dựa trên chiều rộng
    final crossAxisCount = (maxWidth / 350).floor().clamp(2, 4);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Sử dụng LayoutBuilder để biết chiều rộng thực tế
          LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;
              final itemWidth = (availableWidth - (crossAxisCount - 1) * 16) / crossAxisCount;

              // Tạo các hàng (rows)
              final List<Widget> rows = [];
              for (int i = 0; i < movies.length; i += crossAxisCount) {
                final rowChildren = <Widget>[];
                for (int j = 0; j < crossAxisCount && i + j < movies.length; j++) {
                  rowChildren.add(
                    SizedBox(
                      width: itemWidth,
                      child: MovieCard(
                        movie: movies[i + j],
                        isWideScreen: true,
                      ),
                    ),
                  );
                }

                // Thêm spacing giữa các card trong hàng
                rows.add(
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...rowChildren.expand((child) => [
                          child,
                          if (rowChildren.indexOf(child) != rowChildren.length - 1)
                            const SizedBox(width: 16),
                        ]),
                      ],
                    ),
                  ),
                );
              }

              return Column(
                children: rows,
              );
            },
          ),
        ],
      ),
    );
  }
}