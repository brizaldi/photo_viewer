import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_viewer/features/photo/core/domain/photo.dart';
import 'package:stream_transform/stream_transform.dart';

part 'photo_event.dart';
part 'photo_state.dart';

const _perPage = 20;
const _throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc({required this.dio}) : super(const PhotoState()) {
    on<PhotoEvent>(
      (event, emit) {
        if (event is PhotoRefreshed) {
          return _onPhotoRefreshed(emit);
        }

        return _onPhotoFetched(emit);
      },
      transformer: throttleDroppable(_throttleDuration),
    );
  }

  final Dio dio;

  Future<void> _onPhotoFetched(Emitter<PhotoState> emit) async {
    try {
      if (state.status == PhotoStatus.initial) {
        final photos = await _fetchPhotos();
        emit(state.copyWith(
          status: PhotoStatus.success,
          photos: photos,
          page: state.page + 1,
          hasReachedMax: false,
        ));
      }

      final photos = await _fetchPhotos(page: state.page);
      if (photos.isEmpty) {
        emit(state.copyWith(hasReachedMax: true));
      } else {
        emit(state.copyWith(
          status: PhotoStatus.success,
          photos: List.from(state.photos)..addAll(photos),
          page: state.page + 1,
          hasReachedMax: false,
        ));
      }
    } on Exception catch (_) {
      emit(state.copyWith(status: PhotoStatus.failure));
    }
  }

  Future<void> _onPhotoRefreshed(Emitter<PhotoState> emit) async {
    emit(const PhotoState());
    await _onPhotoFetched(emit);
  }

  Future<List<Photo>> _fetchPhotos({int page = 1}) async {
    final response = await dio.get(
      'https://api.pexels.com/v1/curated',
      queryParameters: {
        'page': page,
        'per_page': _perPage,
      },
      options: Options(
        headers: {
          'Authorization':
              '54mvW1jSVofT3AGG2RUiJXpfxmIZd35FX07iVVF2mixL9gyUu53lSTqz',
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = response.data;
      final photos = List<Map<String, dynamic>>.from(data['photos']);

      return photos.map((photo) {
        return Photo(
          id: photo['id'],
          width: photo['width'],
          height: photo['height'],
          url: photo['url'],
          photographer: photo['photographer'],
          photographerUrl: photo['photographer_url'],
          alt: photo['alt'],
          source: PhotoSource(
            original: photo['src']['original'],
            medium: photo['src']['medium'],
          ),
        );
      }).toList();
    }

    throw Exception('error fetching photos');
  }
}
