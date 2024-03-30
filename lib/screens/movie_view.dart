import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/api_services.dart';

class MovieView extends StatefulWidget {
  const MovieView({super.key, required this.movie});
  final MovieModel movie;

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: size.width,
            height: 170,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.movie.backdropPath.toString()))),
            child: const Stack(
              children: [
                BackButton(color: Color.fromARGB(255, 255, 255, 255)),
              ],
            ),
          ),
          Text(
            widget.movie.title.toString(),
            style: const TextStyle(
                color: Color.fromARGB(144, 5, 5, 5),
                fontWeight: FontWeight.w800,
                fontSize: 22),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 120,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              widget.movie.posterPath.toString()))),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.movie.overview.toString()),
          ),
          FutureBuilder(
              future: ApiServices().getMovieDetails(widget.movie.id.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  MovieModel movie = snapshot.data!;
                  return Text(movie.budget.toString());
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ],
      ),
    );
  }
}
