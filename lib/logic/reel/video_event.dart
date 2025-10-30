import 'package:equatable/equatable.dart';

abstract class ReelEvent extends Equatable {
  const ReelEvent();

  @override
  List<Object> get props => [];
}

class LoadReelsEvent extends ReelEvent {
  const LoadReelsEvent();
}

class PlayPauseVideoEvent extends ReelEvent {
  final int index;
  const PlayPauseVideoEvent(this.index);

  @override
  List<Object> get props => [index];
}

class PageChangedEvent extends ReelEvent {
  final int index;
  const PageChangedEvent(this.index);

  @override
  List<Object> get props => [index];
}

class VideoInitializedEvent extends ReelEvent {
  final int index;
  const VideoInitializedEvent(this.index);

  @override
  List<Object> get props => [index];
}