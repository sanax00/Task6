class Movies {
  String? title;
  num ? vote_average;
  String? poster_path;
  String? overview;
  int ? vote_count;
  Movies.frommap(Map<String, dynamic>map){
    title = map["title"];
    overview = map["overview"];
    poster_path = "https://image.tmdb.org/t/p/original/${map["poster_path"]}";
    vote_average = map["vote_average"];
    vote_count=map["vote_count"];
  }
}