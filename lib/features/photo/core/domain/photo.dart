import 'package:equatable/equatable.dart';

class Photo extends Equatable {
  const Photo({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.photographer,
    required this.photographerUrl,
    required this.alt,
    required this.source,
  });

  final int id;
  final int width;
  final int height;
  final String? url;
  final String? photographer;
  final String? photographerUrl;
  final String? alt;
  final PhotoSource source;

  @override
  List<Object?> get props => [
        id,
        width,
        height,
        url,
        photographer,
        photographerUrl,
        alt,
        source,
      ];
}

class PhotoSource extends Equatable {
  const PhotoSource({
    required this.original,
    required this.medium,
  });

  final String original;
  final String medium;

  @override
  List<Object?> get props => [original, medium];
}
