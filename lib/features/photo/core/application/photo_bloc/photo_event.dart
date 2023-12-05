part of 'photo_bloc.dart';

sealed class PhotoEvent extends Equatable {
  const PhotoEvent();

  @override
  List<Object> get props => [];
}

class PhotoFetched extends PhotoEvent {}

class PhotoRefreshed extends PhotoEvent {}
