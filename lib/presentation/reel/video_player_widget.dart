import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final String thumbnailUrl;
  final bool autoPlay;
  final VoidCallback onTap;
  final Function(bool) onInitialized;

  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.autoPlay,
    required this.onTap,
    required this.onInitialized,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitializing = true;
  bool _isDisposed = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      _controller = VideoPlayerController.network(
        widget.videoUrl,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );

      // Listen for initialization
      _controller.addListener(() {
        if (_controller.value.hasError && !_isDisposed) {
          _handleError();
        }
      });

      // Initialize the controller
      await _controller.initialize();

      if (!_isDisposed) {
        setState(() {
          _isInitializing = false;
          _hasError = false;
        });

        // Start playing if autoPlay is true
        if (widget.autoPlay) {
          await _controller.play();
          _controller.setLooping(true);
        }

        widget.onInitialized(false);
      }
    } catch (e) {
      if (!_isDisposed) {
        _handleError();
      }
    }
  }

  void _handleError() {
    setState(() {
      _isInitializing = false;
      _hasError = true;
    });
    widget.onInitialized(false);
    debugPrint('Video initialization error: ${_controller.value.errorDescription}');
  }

  @override
  void didUpdateWidget(covariant VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle autoPlay changes
    if (oldWidget.autoPlay != widget.autoPlay && !_isDisposed && !_isInitializing) {
      if (widget.autoPlay) {
        _controller.play().catchError((_) {});
      } else {
        _controller.pause();
      }
    }

    // Handle video URL changes
    if (oldWidget.videoUrl != widget.videoUrl && !_isDisposed) {
      _reinitializeVideoPlayer();
    }
  }

  Future<void> _reinitializeVideoPlayer() async {
    if (_isDisposed) return;

    setState(() {
      _isInitializing = true;
      _hasError = false;
    });

    await _controller.dispose();
    await _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitializing) {
      return _buildThumbnail();
    }

    if (_hasError) {
      return _buildErrorState();
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          if (!_controller.value.isPlaying)
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
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

  Widget _buildThumbnail() {
    return Image.network(
      widget.thumbnailUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[800],
          child: const Center(
            child: Icon(Icons.broken_image, color: Colors.white),
          ),
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }

  Widget _buildErrorState() {
    return Stack(
      children: [
        _buildThumbnail(),
        Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, color: Colors.white, size: 40),
                const SizedBox(height: 8),
                const Text(
                  'Failed to load video',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _reinitializeVideoPlayer,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}