import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_project/logic/cache_reel/cache_reel_event.dart';
import 'package:bloc_project/logic/cache_reel/cache_reel_state.dart';

import '../../data/models/cache_video_model.dart';



class CacheReelBloc extends Bloc<CacheReelEvent, CacheReelState> {
  CacheReelBloc() : super(ReelInitial()) {
    on<LoadReelsEvent>(_onLoadReels);
    on<PlayPauseVideoEvent>(_onPlayPauseVideo);
    on<PageChangedEvent>(_onPageChanged);
    on<PreloadVideosEvent>(_onPreloadVideos);
    on<DisposeVideosEvent>(_onDisposeVideos);
    on<PauseAllVideosEvent>(_onPauseAllVideos);
  }

  final List<CacheVideoItem> _videos = [
    CacheVideoItem(
      id: '1',
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      thumbnailUrl: 'https://i3.ytimg.com/vi/aqz-KE-bpKQ/maxresdefault.jpg',
      username: 'user1',
      description: 'Beautiful bee with flower #nature',
      likes: 150,
      comments: 20,
      shares: 4,
      favorites: 79,
    ),
    CacheVideoItem(
      id: '2',
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      thumbnailUrl: 'https://i3.ytimg.com/vi/aqz-KE-bpKQ/maxresdefault.jpg',
      username: 'user2',
      description: 'Beautiful butterfly with flower #nature',
      likes: 450,
      comments: 210,
      shares: 49,
      favorites: 39,
    ),
    CacheVideoItem(
      id: '3',
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      thumbnailUrl: 'https://i3.ytimg.com/vi/aqz-KE-bpKQ/maxresdefault.jpg',
      username: 'user3',
      description: 'Beautiful bee with flower #nature',
      likes: 150,
      comments: 20,
      shares: 4,
      favorites: 79,
    ),
    CacheVideoItem(
      id: '4',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      thumbnailUrl: 'https://i3.ytimg.com/vi/aqz-KE-bpKQ/maxresdefault.jpg',
      username: 'user4',
      description: 'Beautiful scenery #nature',
      likes: 1500,
      comments: 120,
      shares: 45,
      favorites: 89,
    ),
    CacheVideoItem(
      id: '5',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      thumbnailUrl: 'https://i3.ytimg.com/vi/aqz-KE-bpKQ/maxresdefault.jpg',
      username: 'user5',
      description: 'Amazing dance moves #dance',
      likes: 2300,
      comments: 180,
      shares: 67,
      favorites: 123,
    ),
    CacheVideoItem(
      id: '6',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
      thumbnailUrl: 'https://i3.ytimg.com/vi/aqz-KE-bpKQ/maxresdefault.jpg',
      username: 'user6',
      description: 'Funny moments #comedy',
      likes: 8900,
      comments: 450,
      shares: 230,
      favorites: 567,
    ),
    CacheVideoItem(
      id: '7',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4',
      thumbnailUrl: 'https://i3.ytimg.com/vi/aqz-KE-bpKQ/maxresdefault.jpg',
      username: 'user7',
      description: 'Funny blog #comedy',
      likes: 200,
      comments: 150,
      shares: 230,
      favorites: 7,
    ),
    CacheVideoItem(
      id: '8',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4',
      thumbnailUrl: 'https://i3.ytimg.com/vi/aqz-KE-bpKQ/maxresdefault.jpg',
      username: 'user8',
      description: 'Funny blog #comedy',
      likes: 900,
      comments: 40,
      shares: 30,
      favorites: 7,
    ),
    CacheVideoItem(
      id: '9',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
      thumbnailUrl: 'https://i3.ytimg.com/vi/aqz-KE-bpKQ/maxresdefault.jpg',
      username: 'user9',
      description: 'Funny advertisement #comedy',
      likes: 200,
      comments: 500,
      shares: 3,
      favorites: 2,
    ),
  ];

  Future<void> _onLoadReels(LoadReelsEvent event, Emitter<CacheReelState> emit) async {
    emit(ReelLoading());

    // Preload first 2 videos immediately
    await _preloadVideos(0, 1);

    if (emit.isDone) return;

    emit(ReelLoaded(
      videos: _videos,
      currentIndex: 0,
      isPlaying: true,
    ));
  }

  Future<void> _preloadVideos(int startIndex, int count) async {
    final endIndex = startIndex + count;
    for (int i = startIndex; i < endIndex && i < _videos.length; i++) {
      if (!_videos[i].isInitialized && !_videos[i].isInitializing) {
        await _videos[i].initializeController();
      }
    }
  }

  Future<void> _onPreloadVideos(PreloadVideosEvent event, Emitter<CacheReelState> emit) async {
    // Preload next and previous videos for smooth scrolling
    final preloadStart = event.currentIndex;
    final preloadCount = 3; // Preload current, next, and previous

    await _preloadVideos(preloadStart, preloadCount);
  }

  Future<void> _onDisposeVideos(DisposeVideosEvent event, Emitter<CacheReelState> emit) async {
    // Dispose videos that are far from current position to save memory
    for (int i = 0; i < _videos.length; i++) {
      if ((i < event.currentIndex - 2 || i > event.currentIndex + 2) &&
          _videos[i].isInitialized) {
        _videos[i].disposeController();
      }
    }
  }

  Future<void> _onPageChanged(PageChangedEvent event, Emitter<CacheReelState> emit) async {
    if (state is ReelLoaded) {
      final currentState = state as ReelLoaded;

      // Pause current video
      if (currentState.currentIndex < _videos.length &&
          _videos[currentState.currentIndex].isInitialized) {
        _videos[currentState.currentIndex].controller?.pause();
      }

      // Play new video if initialized, or initialize and play
      if (event.index < _videos.length) {
        if (_videos[event.index].isInitialized) {
          await _videos[event.index].controller?.play();
        } else if (!_videos[event.index].isInitializing) {
          await _videos[event.index].initializeController();
          if (_videos[event.index].isInitialized && _videos[event.index].controller != null) {
            await _videos[event.index].controller!.play();
          }
        }
      }

      if (emit.isDone) return;

      emit(currentState.copyWith(
        currentIndex: event.index,
        isPlaying: true,
      ));

      // Preload adjacent videos
      add(PreloadVideosEvent(event.index));
      add(DisposeVideosEvent(event.index));
    }
  }

  Future<void> _onPlayPauseVideo(PlayPauseVideoEvent event, Emitter<CacheReelState> emit) async {
    if (state is ReelLoaded) {
      final currentState = state as ReelLoaded;
      if (event.index == currentState.currentIndex) {
        if (currentState.isPlaying) {
          _videos[event.index].controller?.pause();
        } else {
          await _videos[event.index].controller?.play();
        }

        if (emit.isDone) return;

        emit(currentState.copyWith(
          isPlaying: !currentState.isPlaying,
        ));
      }
    }
  }




  // Add this event handler
  Future<void> _onPauseAllVideos(PauseAllVideosEvent event, Emitter<CacheReelState> emit) async {
    pauseAllVideos();
  }
  // Add this method to pause all videos
  void pauseAllVideos() {
    for (final video in _videos) {
      if (video.isInitialized && video.controller != null) {
        video.controller?.pause();
      }
    }
  }

  // Your existing event handlers...

  @override
  Future<void> close() {
    // Dispose all video controllers when bloc is closed
    for (final video in _videos) {
      video.disposeController();
    }
    return super.close();
  }
}

