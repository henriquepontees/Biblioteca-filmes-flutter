class Movie {
  int? id;
  final String imageUrl;
  final String title;
  final String genre;
  final String ageRating;
  final String duration;
  final double rating;
  final String description;
  final int year;

  Movie({
    this.id,
    required this.imageUrl,
    required this.title,
    required this.genre,
    required this.ageRating,
    required this.duration,
    required this.rating,
    required this.description,
    required this.year,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'genre': genre,
      'ageRating': ageRating,
      'duration': duration,
      'rating': rating,
      'description': description,
      'year': year,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      imageUrl: map['imageUrl'],
      title: map['title'],
      genre: map['genre'],
      ageRating: map['ageRating'],
      duration: map['duration'],
      rating: map['rating'],
      description: map['description'],
      year: map['year'],
    );
  }
}