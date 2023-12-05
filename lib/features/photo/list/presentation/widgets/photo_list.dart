import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_viewer/features/photo/core/application/photo_bloc/photo_bloc.dart';
import 'package:photo_viewer/features/photo/list/presentation/widgets/loading.dart';
import 'package:photo_viewer/features/photo/list/presentation/widgets/photo_list_item.dart';

class PhotoList extends StatefulWidget {
  const PhotoList({super.key});

  @override
  State<PhotoList> createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoBloc, PhotoState>(
      builder: (context, state) {
        switch (state.status) {
          case PhotoStatus.success:
            if (state.photos.isEmpty) {
              return const Center(child: Text('No data'));
            }

            return ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              itemCount: state.hasReachedMax
                  ? state.photos.length
                  : state.photos.length + 1,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 8),
              itemBuilder: (BuildContext context, int index) {
                return index >= state.photos.length
                    ? const Loading()
                    : PhotoListItem(photo: state.photos[index]);
              },
            );
          case PhotoStatus.failure:
            return const Center(child: Text('Error fetching photos'));
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<PhotoBloc>().add(PhotoFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
