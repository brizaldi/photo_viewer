part of 'photo_bloc.dart';

enum PhotoStatus { initial, success, failure }

class PhotoState extends Equatable {
  const PhotoState({
    this.status = PhotoStatus.initial,
    this.photos = const <Photo>[],
    this.page = 1,
    this.hasReachedMax = true,
  });

  final PhotoStatus status;
  final List<Photo> photos;
  final int page;
  final bool hasReachedMax;

  PhotoState copyWith({
    PhotoStatus? status,
    List<Photo>? photos,
    int? page,
    bool? hasReachedMax,
  }) {
    return PhotoState(
      status: status ?? this.status,
      photos: photos ?? this.photos,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, photos, page, hasReachedMax];
}
