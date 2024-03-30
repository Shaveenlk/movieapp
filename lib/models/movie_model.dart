import 'package:logger/logger.dart';
import 'package:movie_app/models/company_model.dart';

class MovieModel {
  String? backdropPath;
  int? id;
  String? posterPath;
  String? title;
  double? voteAverage;
  String? overview;
  bool? adult;
  int? budget;
  String? tagline;
  int? voteCount;
  String? status;
  List<CompanyModel>? companies;

  MovieModel(
      {this.backdropPath,
      this.id,
      this.posterPath,
      this.title,
      this.voteAverage,
      this.overview,
      this.adult,
      this.budget,
      this.tagline,
      this.voteCount,
      this.status,
      this.companies});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    List<CompanyModel> companies = (json['production_companies'] as List)
        .map((company) => CompanyModel.fromJson(company))
        .toList();
    Logger().d(companies[0].name);

    return MovieModel(
        backdropPath:
            "https://image.tmdb.org/t/p/w500/${json['backdrop_path']}",
        id: json['id'],
        posterPath: "https://image.tmdb.org/t/p/w500/${json['poster_path']}",
        title: json['title'],
        voteAverage: json['vote_average'].toDouble(),
        overview: json['overview'],
        adult: json["adult"] ?? false,
        budget: json["budget"] ?? 0,
        status: json["status"] ?? "",
        tagline: json["tagline"] ?? "",
        voteCount: json["vote_count"] ?? 0,
        companies: companies);
  }
}
