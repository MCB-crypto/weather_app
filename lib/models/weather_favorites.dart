//
// import 'dart:convert';
//
// // WeatherFavorites weatherFavoritesFromJson(String str) => WeatherFavorites.fromJson(json.decode(str));
//
// // String weatherFavoritesToJson(WeatherFavorites data) => json.encode(data.toJson());
//
// // class WeatherFavorites {
// //   WeatherFavorites({
// //     required this.favorites,
// //   });
// //
// //   List<Favorite> favorites;
// //
// //   factory WeatherFavorites.fromJson(Map<String, dynamic> json) => WeatherFavorites(
// //     favorites: List<Favorite>.from(json["favorites"].map((x) => Favorite.fromJson(x))),
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "favorites": List<dynamic>.from(favorites.map((x) => x.toJson())),
// //   };
// // }
//
// class WeatherFavorite {
//   WeatherFavorite({
//     required this.cityName,
//     required this.description,
//     required this.icon,
//     required this.index,
//   });
//
//   String cityName;
//   String description;
//   String icon;
//   int index;
//
//
//
//   factory WeatherFavorite.fromJson(Map<String, dynamic> json) => WeatherFavorite(
//     cityName: json["cityName"],
//     description: json["description"],
//     icon: json["icon"],
//     index: json["index"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "cityName": cityName,
//     "description": description,
//     "icon": icon,
//     "index": index,
//   };
// }
