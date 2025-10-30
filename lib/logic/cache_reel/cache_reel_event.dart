import 'package:equatable/equatable.dart';

abstract class CacheReelEvent extends Equatable {
  const CacheReelEvent();

  @override
  List<Object> get props => [];
}

class LoadReelsEvent extends CacheReelEvent {
  const LoadReelsEvent();
}

class PlayPauseVideoEvent extends CacheReelEvent {
  final int index;
  const PlayPauseVideoEvent(this.index);

  @override
  List<Object> get props => [index];
}

class PageChangedEvent extends CacheReelEvent {
  final int index;
  const PageChangedEvent(this.index);

  @override
  List<Object> get props => [index];
}

class VideoInitializedEvent extends CacheReelEvent {
  final int index;
  const VideoInitializedEvent(this.index);

  @override
  List<Object> get props => [index];
}

class PreloadVideosEvent extends CacheReelEvent {
  final int currentIndex;
  const PreloadVideosEvent(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}

class DisposeVideosEvent extends CacheReelEvent {
  final int currentIndex;
  const DisposeVideosEvent(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}
class PauseAllVideosEvent extends CacheReelEvent {
  const PauseAllVideosEvent();
}