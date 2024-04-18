// // // To parse this JSON data, do
// // //
// // //     final dog = dogFromJson(jsonString);
// //
// // import 'package:meta/meta.dart';
// // import 'dart:convert';
// //
// // Dog dogFromJson(String str) => Dog.fromJson(json.decode(str));
// //
// // String dogToJson(Dog data) => json.encode(data.toJson());
// //
// // class Dog {
// //   int id;
// //   String message;
// //   String status;
// //   String price;
// //   bool isInCart;
// //
// //   Dog({
// //     required this.id,
// //     required this.message,
// //     required this.status,
// //     required this.price,
// //     required this.isInCart,
// //   });
// //
// //   factory Dog.fromJson(Map<String, dynamic> json) => Dog(
// //     id: json["id"],
// //     message: json["message"],
// //     status: json["status"],
// //     price: json["price"],
// //     isInCart: json["isInCart"],
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "id": id,
// //     "message": message,
// //     "status": status,
// //     "price": price,
// //     "isInCart": isInCart,
// //   };
// // }
//
// import 'dart:convert';
// import 'dart:math';
//
// import 'package:meta/meta.dart';
//
// Dog dogFromJson(String str) => Dog.fromJson(json.decode(str));
//
// String dogToJson(Dog data) => json.encode(data.toJson());
//
// class Dog {
//   final int id;
//   final String imageUrl;
//   final double price;
//   bool isInCart;
//
//    Dog({
//     required this.id,
//     required this.imageUrl,
//     required this.price,
//     this.isInCart = false, // Default isInCart to false
//   });
//
//   factory Dog.fromJson(Map<String, dynamic> json) => Dog(
//     id: json["id"] ?? 0, // Handle potential missing id
//     imageUrl: json["message"] ?? '',
//     price: _generateRandomPrice(), // Generate random price on creation
//     isInCart: false,
//   );
//
//   static double _generateRandomPrice() {
//     return Random().nextDouble() * 100.0; // Generate random price between 0 and 100
//   }
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "imageUrl": imageUrl,
//     "price": price,
//     "isInCart": isInCart,
//   };
// }
// To parse this JSON data, do
//
//     final dog = dogFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Dog dogFromJson(String str) => Dog.fromJson(json.decode(str));

String dogToJson(Dog data) => json.encode(data.toJson());

class Dog {
  int id;
  String message;
  String price;
  int isInCart;

  Dog({
    required this.id,
    required this.message,
    required this.price,
    required this.isInCart,
  });

  factory Dog.fromJson(Map<String, dynamic> json) => Dog(
    id: json["id"],
    message: json["message"],
    price: json["price"],
    isInCart: json["in_cart"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "price": price,
    "in_cart": isInCart,
  };
}
