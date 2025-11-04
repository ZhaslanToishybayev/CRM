/// Category Model
/// Educational Project - Gamified Task Management App
///
/// Represents a task category

import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required String id,
    required String userId,
    required String name,
    required String color,
    String? icon,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}

/// Predefined categories
class PredefinedCategories {
  static const List<CategoryModel> defaults = [
    CategoryModel(
      id: 'work',
      userId: 'default',
      name: 'Work',
      color: '#2196F3',
      icon: 'work',
      createdAt: _defaultDate,
      updatedAt: _defaultDate,
    ),
    CategoryModel(
      id: 'personal',
      userId: 'default',
      name: 'Personal',
      color: '#4CAF50',
      icon: 'person',
      createdAt: _defaultDate,
      updatedAt: _defaultDate,
    ),
    CategoryModel(
      id: 'health',
      userId: 'default',
      name: 'Health',
      color: '#FF5722',
      icon: 'health',
      createdAt: _defaultDate,
      updatedAt: _defaultDate,
    ),
    CategoryModel(
      id: 'shopping',
      userId: 'default',
      name: 'Shopping',
      color: '#FFC107',
      icon: 'shopping',
      createdAt: _defaultDate,
      updatedAt: _defaultDate,
    ),
    CategoryModel(
      id: 'education',
      userId: 'default',
      name: 'Education',
      color: '#9C27B0',
      icon: 'school',
      createdAt: _defaultDate,
      updatedAt: _defaultDate,
    ),
  ];

  static const DateTime _defaultDate = DateTime.fromMillisecondsSinceEpoch(0);
}
