import 'package:flutter/material.dart';
import 'package:photo_viewer/features/photo/core/domain/photo.dart';
import 'package:photo_viewer/utils/strings.dart';

class PhotoDetailsPage extends StatelessWidget {
  const PhotoDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final photo = ModalRoute.of(context)!.settings.arguments as Photo;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Center(
            child: Hero(
              tag: photo.id,
              child: Image.network(
                photo.source.original,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!Strings.isEmptyOrNull(photo.photographer)) ...[
                  Text(
                    photo.photographer!,
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                if (!Strings.isEmptyOrNull(photo.url)) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      photo.url!,
                      style: textTheme.bodySmall?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
                if (!Strings.isEmptyOrNull(photo.photographerUrl)) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      photo.photographerUrl!,
                      style: textTheme.bodySmall?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
                if (!Strings.isEmptyOrNull(photo.alt)) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      photo.alt!,
                      style: textTheme.bodySmall?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
