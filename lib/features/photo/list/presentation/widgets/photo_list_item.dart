import 'package:flutter/material.dart';
import 'package:photo_viewer/features/photo/core/domain/photo.dart';
import 'package:photo_viewer/main.dart';

class PhotoListItem extends StatelessWidget {
  const PhotoListItem({super.key, required this.photo});

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.details,
        arguments: photo,
      ),
      child: Hero(
        tag: photo.id,
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(photo.source.medium),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
