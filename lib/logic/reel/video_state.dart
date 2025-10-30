import 'package:equatable/equatable.dart';

import '../../data/models/video_model.dart';

abstract class ReelState extends Equatable {
  const ReelState();

  @override
  List<Object> get props => [];
}

class ReelInitial extends ReelState {}

class ReelLoading extends ReelState {}

class ReelLoaded extends ReelState {
  final List<VideoItem> videos;
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
    List<VideoItem>? videos,
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

class ReelError extends ReelState {
  final String message;
  const ReelError(this.message);

  @override
  List<Object> get props => [message];
}