import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_project/logic/reel/video_event.dart';
import 'package:bloc_project/logic/reel/video_state.dart';

import '../../data/models/video_model.dart';

class ReelBloc extends Bloc<ReelEvent, ReelState> {
  ReelBloc() : super(ReelInitial()) {
    on<LoadReelsEvent>(_onLoadReels);
    on<PlayPauseVideoEvent>(_onPlayPauseVideo);
    on<PageChangedEvent>(_onPageChanged);
    on<VideoInitializedEvent>(_onVideoInitialized);
  }

  final List<VideoItem> _videos = [
    const VideoItem(
      id: '1',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      thumbnailUrl: 'https://i3.ytimg.com/vi/aqz-KE-bpKQ/maxresdefault.jpg',
      username: 'user1',
      description: 'Beautiful scenery #nature',
      likes: 1500,
      comments: 120,
      shares: 45,
      favorites: 89,
    ),
    const VideoItem(
      id: '2',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      thumbnailUrl: 'https://i3.ytimg.com/vi/aqz-KE-bpKQ/maxresdefault.jpg',
      username: 'user2',
      description: 'Amazing dance moves #dance',
      likes: 2300,
      comments: 180,
      shares: 67,
      favorites: 123,
    ),
    const VideoItem(
      id: '3',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
      thumbnailUrl: 'https://i3.ytimg.com/vi/aqz-KE-bpKQ/maxresdefault.jpg',
      username: 'user3',
      description: 'Funny moments #comedy',
      likes: 8900,
      comments: 450,
      shares: 230,
      favorites: 567,
    ),
  ];

  Future<void> _onLoadReels(LoadReelsEvent event, Emitter<ReelState> emit) async {
    emit(ReelLoading());

    // Simulate loading delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Check if emitter is still valid
    if (emit.isDone) return;

    final loadingStates = Map<int, bool>.fromIterable(
      List.generate(_videos.length, (index) => index),
      value: (index) => true,
    );

    emit(ReelLoaded(
      videos: _videos,
      videoLoadingStates: loadingStates,
    ));
  }

  Future<void> _onPlayPauseVideo(PlayPauseVideoEvent event, Emitter<ReelState> emit) async {
    if (state is ReelLoaded) {
      final currentState = state as ReelLoaded;
      if (event.index == currentState.currentIndex) {
        // Check if emitter is still valid
        if (emit.isDone) return;

        emit(currentState.copyWith(
          isPlaying: !currentState.isPlaying,
        ));
      }
    }
  }

  Future<void> _onPageChanged(PageChangedEvent event, Emitter<ReelState> emit) async {
    if (state is ReelLoaded) {
      final currentState = state as ReelLoaded;
      // Check if emitter is still valid
      if (emit.isDone) return;

      emit(currentState.copyWith(
        currentIndex: event.index,
        isPlaying: true,
      ));
    }
  }

  Future<void> _onVideoInitialized(VideoInitializedEvent event, Emitter<ReelState> emit) async {
    if (state is ReelLoaded) {
      final currentState = state as ReelLoaded;
      final updatedLoadingStates = Map<int, bool>.from(currentState.videoLoadingStates);
      updatedLoadingStates[event.index] = false;

      // Check if emitter is still valid
      if (emit.isDone) return;

      emit(currentState.copyWith(
        videoLoadingStates: updatedLoadingStates,
      ));
    }
  }
}

class EmitHelper {
  static Future<void> safeEmit(
      Emitter emitter,
      Future<void> Function() emitFunction,
      ) async {
    if (!emitter.isDone) {
      await emitFunction();
    }
  }

  static void safeEmitSync(
      Emitter emitter,
      void Function() emitFunction,
      ) {
    if (!emitter.isDone) {
      emitFunction();
    }
  }
}