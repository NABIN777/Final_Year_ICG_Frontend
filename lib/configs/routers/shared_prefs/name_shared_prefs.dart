import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../failure/failure.dart';

class IconPressedValue {
  bool isPressed;

  IconPressedValue({required this.isPressed});

  Map<String, dynamic> toJson() {
    return {
      'isPressed': isPressed,
    };
  }

  factory IconPressedValue.fromJson(Map<String, dynamic> json) {
    return IconPressedValue(
      isPressed: json['isPressed'] ?? false,
    );
  }
}

class UserRepository {
  SharedPreferences? _sharedPreferences;

  // Set icon pressed value
  Future<Either<Failure, bool>> setIconPressedValue(
      IconPressedValue value) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final jsonString = json.encode(value.toJson());
      _sharedPreferences?.setString('iconPressedValue', jsonString);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  // Get icon pressed value
  Future<Either<Failure, IconPressedValue>> getIconPressedValue() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      final jsonString = _sharedPreferences?.getString('iconPressedValue');
      if (jsonString != null) {
        final iconPressedValue = IconPressedValue.fromJson(
          Map<String, dynamic>.from(json.decode(jsonString)),
        );
        return Right(iconPressedValue);
      } else {
        // Return default value if no value is stored yet
        return Right(IconPressedValue(isPressed: false));
      }
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
