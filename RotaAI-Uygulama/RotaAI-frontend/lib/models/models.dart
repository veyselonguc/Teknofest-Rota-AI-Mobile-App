class City {
  final int id;
  final String name;
  final String description;
  final String imageUrl;

  City({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}

class Place {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final String address;
  final double rating;
  final List<String> categories;

  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.rating,
    required this.categories,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      address: json['address'],
      rating: json['rating'].toDouble(),
      categories: List<String>.from(json['categories']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'rating': rating,
      'categories': categories,
    };
  }
}

class VisitedPlace {
  final int id;
  final int placeId;
  final int userId;
  final double rating;
  final DateTime visitedDate;

  VisitedPlace({
    required this.id,
    required this.placeId,
    required this.userId,
    required this.rating,
    required this.visitedDate,
  });

  factory VisitedPlace.fromJson(Map<String, dynamic> json) {
    return VisitedPlace(
      id: json['id'],
      placeId: json['placeId'],
      userId: json['userId'],
      rating: json['rating'].toDouble(),
      visitedDate: DateTime.parse(json['visitedDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'placeId': placeId,
      'userId': userId,
      'rating': rating,
      'visitedDate': visitedDate.toIso8601String(),
    };
  }
}
