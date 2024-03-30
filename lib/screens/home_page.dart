import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screens/movie_view.dart';
import 'package:movie_app/services/api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiServices service = ApiServices();
  List<MovieModel>? movies = [];
  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  Text(
                    "MOVIES",
                    style: TextStyle(
                        color: Colors.white38,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Container(
              width: screensize.width * 0.9,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.white38),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white38,
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder(
              future: service.getPopularMovies(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  movies = snapshot.data;
                  return CarouselSlider(
                    options: CarouselOptions(
                        height: 200.0, autoPlay: true, viewportFraction: 0.8),
                    items: movies!.map((movie) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.2),
                                        BlendMode.darken),
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        movie.backdropPath.toString())),
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(15)),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 5,
                                  left: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.green.shade600,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                movie.voteAverage
                                                        ?.toStringAsFixed(1) ??
                                                    "N/A",
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        movie.title.toString(),
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                    top: 5,
                                    right: 5,
                                    child: FilledButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color.fromARGB(
                                                    20, 0, 0, 0)),
                                      ),
                                      child: const Icon(Icons.movie),
                                    ))
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: FractionalOffset.bottomLeft,
              child: Text(
                "Top Rated Movies",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 10),
            FutureBuilder(
              future: service.getTopRatedMovies(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<MovieModel> topRatedMovies = snapshot.data!;
                  return SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: topRatedMovies.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.1),
                                        BlendMode.darken),
                                    fit: BoxFit.cover,
                                    image: NetworkImage(topRatedMovies[index]
                                        .posterPath
                                        .toString()))),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: 65,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 3),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              topRatedMovies[index]
                                                      .voteAverage
                                                      ?.toStringAsFixed(1) ??
                                                  "N/A",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 20,
                                              weight: 1.4,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: 120,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.amber.shade800,
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          topRatedMovies[index]
                                              .title
                                              .toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          softWrap: true),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: FractionalOffset.bottomLeft,
              child: Text(
                "Upcoming Movies",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 10),
            FutureBuilder(
              future: service.getUpcomingMoves(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<MovieModel> upcomingMovies = snapshot.data!;
                  return SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: upcomingMovies.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  MovieView(movie: upcomingMovies[index],)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.1),
                                          BlendMode.darken),
                                      fit: BoxFit.cover,
                                      image: NetworkImage(upcomingMovies[index]
                                          .posterPath
                                          .toString()))),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        width: 65,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 3),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                upcomingMovies[index]
                                                        .voteAverage
                                                        ?.toStringAsFixed(1) ??
                                                    "N/A",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w900),
                                              ),
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 20,
                                                weight: 1.4,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: 120,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.amber.shade800,
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            upcomingMovies[index]
                                                .title
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            softWrap: true),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
