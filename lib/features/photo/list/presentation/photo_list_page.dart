import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_viewer/features/photo/core/application/photo_bloc/photo_bloc.dart';
import 'package:photo_viewer/features/photo/list/presentation/widgets/photo_list.dart';

class PhotoListPage extends StatelessWidget {
  const PhotoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhotoBloc(dio: Dio())..add(PhotoFetched()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Photo Viewer'),
        ),
        body: const PhotoList(),
        floatingActionButton: BlocBuilder<PhotoBloc, PhotoState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () => context.read<PhotoBloc>().add(PhotoRefreshed()),
              child: const Icon(Icons.refresh),
            );
          },
        ),
      ),
    );
  }
}
