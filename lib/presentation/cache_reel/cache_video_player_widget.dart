import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../data/models/cache_video_model.dart';

class CacheVideoPlayerWidget extends StatefulWidget {
  final CacheVideoItem video;
  final bool autoPlay;
  final VoidCallback onTap;

  const CacheVideoPlayerWidget({
    super.key,
    required this.video,
    required this.autoPlay,
    required this.onTap,
  });

  @override
  State<CacheVideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<CacheVideoPlayerWidget> {
  @override
  void initState() {
    super.initState();
    _ensureVideoInitialized();
  }

  Future<void> _ensureVideoInitialized() async {
    if (!widget.video.isInitialized && !widget.video.isInitializing) {
      await widget.video.initializeController();

      // AUTO-PLAY THE VIDEO WHEN IT'S READY
      if (widget.autoPlay && widget.video.isInitialized && widget.video.controller != null) {
        await widget.video.controller!.play();
      }

      // Refresh UI when video is ready
      if (mounted) {
        setState(() {});
      }
    } else if (widget.video.isInitialized && widget.autoPlay) {
      // If video is already initialized but not playing, play it
      if (widget.video.controller != null && !widget.video.controller!.value.isPlaying) {
        await widget.video.controller!.play();
        if (mounted) {
          setState(() {});
        }
      }
    }
  }

  @override
  void didUpdateWidget(covariant CacheVideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle autoPlay changes
    if (widget.video.isInitialized && widget.video.controller != null) {
      if (widget.autoPlay) {
        widget.video.controller!.play();
      } else {
        widget.video.controller!.pause();
      }

      if (mounted) {
        setState(() {});
      }
    }

    // If video changed, initialize the new one
    if (oldWidget.video.id != widget.video.id) {
      _ensureVideoInitialized();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Thumbnail (always visible as fallback)
          Image.network(
            widget.video.thumbnailUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Video player (appears when initialized)
          if (widget.video.isInitialized && widget.video.controller != null)
            AspectRatio(
              aspectRatio: widget.video.controller!.value.aspectRatio,
              child: VideoPlayer(widget.video.controller!),
            ),

          // Play button overlay - ONLY show if video is paused AND not auto-playing
          if (_shouldShowPlayButton())
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.play_arrow,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  bool _shouldShowPlayButton() {
    // Don't show play button if:
    // 1. Video is not initialized, OR
    // 2. Video is playing, OR
    // 3. We're in autoPlay mode (first load)
    if (!widget.video.isInitialized ||
        widget.video.controller == null ||
        widget.video.controller!.value.isPlaying ||
        widget.autoPlay) {
      return false;
    }

    // Only show play button if video is paused and not in autoPlay mode
    return !widget.video.controller!.value.isPlaying;
  }
}