import 'package:flutter/cupertino.dart';

class UserModel {
  final String id;
  final String mobile;
  final String name;
  final String email;
  final String address;
  final bool isAdmin;
  final bool isVerified;
  final String token;
  final List<dynamic> addresses;
  final List<dynamic> bag;
  final List<dynamic> favorites;
  final List<dynamic> orders;

  UserModel({
    required this.id,
    required this.mobile,
    required this.name,
    required this.email,
    required this.address,
    required this.isAdmin,
    required this.isVerified,
    required this.token,
    this.addresses = const [],
    this.bag = const [],
    this.favorites = const [],
    this.orders = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
      // If the response contains a nested user object, use that
      final userData = json['user'] ?? json;

      return UserModel(
        id: userData['_id']?.toString() ?? '',
        mobile: userData['mobile']?.toString() ?? '',
        name: userData['name']?.toString() ?? '',
        email: userData['email']?.toString() ?? '',
        address: userData['address']?.toString() ?? '',
        isAdmin: userData['isAdmin'] as bool? ?? false,
        isVerified: userData['isVerified'] as bool? ?? false,
        token: json['token']?.toString() ?? '',  // token is typically in the root object
        addresses: userData['addresses'] as List<dynamic>? ?? [],
        bag: userData['bag'] as List<dynamic>? ?? [],
        favorites: userData['favorites'] as List<dynamic>? ?? [],
        orders: userData['orders'] as List<dynamic>? ?? [],
      );
    } catch (e) {
      debugPrint('Error parsing UserModel from JSON: $e');
      debugPrint('Problematic JSON: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'mobile': mobile,
      'name': name,
      'email': email,
      'address': address,
      'isAdmin': isAdmin,
      'isVerified': isVerified,
      'token': token,
      'addresses': addresses,
      'bag': bag,
      'favorites': favorites,
      'orders': orders,
    };
  }


}