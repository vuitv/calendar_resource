import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Resource extends Equatable {
  const Resource({
    required this.id,
    this.displayName = '',
    this.subtitle = '',
    this.image,
    this.color = const Color(0xFFCBF0F8),
  });

  final Object id;
  final String displayName;
  final String subtitle;
  final ImageProvider? image;
  final Color color;

  @override
  List<Object?> get props => [
        id,
        displayName,
        subtitle,
        image,
        color,
      ];
}
