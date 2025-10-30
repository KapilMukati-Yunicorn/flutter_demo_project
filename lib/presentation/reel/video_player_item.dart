/*// widgets/video_player_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_player_plus/better_player_plus.dart';
import '../../data/models/video_model.dart';
import '../../logic/reel/video_bloc.dart';

class VideoPlayerItem extends StatefulWidget {
  final VideoItem video;
  final bool isPlaying;

  const VideoPlayerItem({
    super.key,
    required this.video,
    required this.isPlaying,
  });

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  BetterPlayerController? _controller;
  bool _controllerReady = false;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    final bloc = context.read<VideoBloc>();
    _controller = bloc.getController(widget.video.id);
    _controllerReady = _controller != null;

    if (_controllerReady) {
      // Force a rebuild when controller becomes ready
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant VideoPlayerItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!_controllerReady) {
      _initializeController();
    }

    if (_controllerReady) {
      if (widget.isPlaying && !oldWidget.isPlaying) {
        _playVideo();
      } else if (!widget.isPlaying && oldWidget.isPlaying) {
        _pauseVideo();
      }
    }
  }

  Future<void> _playVideo() async {
    if (_controller != null && !(_controller!.isPlaying() ?? false)) {
      try {
        await _controller!.play();
      } catch (e) {
        print('Error playing video: $e');
      }
    }
  }

  Future<void> _pauseVideo() async {
    if (_controller != null && (_controller!.isPlaying() ?? false)) {
      try {
        await _controller!.pause();
      } catch (e) {
        print('Error pausing video: $e');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controllerReady || _controller == null) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Stack(
      children: [
        // Video player
        Positioned.fill(
          child: BetterPlayer(
            controller: _controller!,
            key: ValueKey(widget.video.id), // Important for rebuilding
          ),
        ),

        // Debug overlay (optional - remove in production)
        Positioned(
          top: 40,
          left: 16,
          child: Text(
            'Video: ${widget.video.id} | Playing: ${widget.isPlaying}',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }
}*/