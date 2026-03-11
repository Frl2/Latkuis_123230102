import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import 'movie_detail_page.dart';

// AddToListButton Widget
class AddToListButton extends StatefulWidget {
  final VoidCallback? onPressed;

  const AddToListButton({super.key, this.onPressed});

  @override
  State<AddToListButton> createState() => _AddToListButtonState();
}

class _AddToListButtonState extends State<AddToListButton> {
  bool _isAdded = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _isAdded = !_isAdded;
        });
        widget.onPressed?.call();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _isAdded ? Colors.blue : Colors.white,
        foregroundColor: _isAdded ? Colors.white : Colors.black,
        side: BorderSide(color: _isAdded ? Colors.blue : Colors.grey, width: 1),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(_isAdded ? 'Added' : 'Add to List'),
    );
  }
}

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie List'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          final movie = movieList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailPage(movie: movie),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Movie Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        movie.imgUrl,
                        width: 80,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 80,
                            height: 120,
                            color: Colors.grey[300],
                            child: const Icon(Icons.movie, size: 40),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Movie Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('${movie.year} • ${movie.genre}'),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                movie.rating.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          AddToListButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${movie.title} added to list'),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
