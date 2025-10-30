import 'package:equatable/equatable.dart';

import '../../data/models/cache_video_model.dart';

abstract class CacheReelState extends Equatable {
  const CacheReelState();

  @override
  List<Object> get props => [];
}

class ReelInitial extends CacheReelState {}

class ReelLoading extends CacheReelState {}

class ReelLoaded extends CacheReelState {
  final List<CacheVideoItem> videos;
  final int currentIndex;
  final bool isPlaying;
  final Map<int, bool> videoLoadingStates;

  const ReelLoaded({
    required this.videos,
    this.currentIndex = 0,
    this.isPlaying = true,
    this.videoLoadingStates = const {},
  });

  ReelLoaded copyWith({
    List<CacheVideoItem>? videos,
    int? currentIndex,
    bool? isPlaying,
    Map<int, bool>? videoLoadingStates,
  }) {
    return ReelLoaded(
      videos: videos ?? this.videos,
      currentIndex: currentIndex ?? this.currentIndex,
      isPlaying: isPlaying ?? this.isPlaying,
      videoLoadingStates: videoLoadingStates ?? this.videoLoadingStates,
    );
  }

  @override
  List<Object> get props => [
    videos,
    currentIndex,
    isPlaying,
    videoLoadingStates,
  ];
}

class ReelError extends CacheReelState {
  final String message;
  const ReelError(this.message);

  @override
  List<Object> get props => [message];
}