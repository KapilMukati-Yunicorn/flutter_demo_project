import 'package:flutter/material.dart';
import 'package:better_player_plus/better_player_plus.dart';

/*class ReelScreen extends StatefulWidget {
  const ReelScreen({super.key});

  @override
  State<ReelScreen> createState() => _ReelsWithBetterPlayerState();
}

class _ReelsWithBetterPlayerState extends State<ReelScreen> {
  // 5 free sample MP4 URLs (replace with your content/API later)
  final List<String> videoUrls = [
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
  ];

  final PageController _pageController = PageController();
  final Map<int, BetterPlayerController> _controllers = {};
  int _currentIndex = 0;
  bool _disposed = false;
  final Map<int, bool> _muted = {};
  // Shared player configuration used for creating controllers.
  BetterPlayerConfiguration get _playerConfig => BetterPlayerConfiguration(
    autoPlay: false, // we will explicitly play only the visible controller
    looping: true,
    fit: BoxFit.cover,
    controlsConfiguration: BetterPlayerControlsConfiguration(
      showControls: false, // Instagram-like: no controls visible
    ),
    // keep other defaults; tune if you want other behavior
  );

  @override
  void initState() {
    super.initState();
    // Prepare initial neighborhood: 0, 1
    _prepareAroundIndex(0);
    _pageController.addListener(_pageListener);
  }

  void _pageListener() {
    // Detect final page when scrolling stops (page can be fractional while dragging)
    final page = _pageController.page;
    if (page == null) return;
    final newIndex = page.round();
    if (newIndex != _currentIndex) {
      _onPageChanged(newIndex);
    }
  }

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);

    // Preload previous (if in range)
    if (index - 1 >= 0) {
      _prepareController(index - 1);
    }

    // Preload next (if in range)
    if (index + 1 < videoUrls.length) {
      _prepareController(index + 1);
    }

    // Dispose far-away controllers (keep only current ±2 alive)
    final toRemove = <int>[];
    _controllers.forEach((i, ctrl) {
      if ((i - index).abs() > 2) {
        ctrl.dispose();
        toRemove.add(i);
      }
    });
    for (final i in toRemove) {
      _controllers.remove(i);
    }
  }




  Future<void> _prepareAroundIndex(int index) async {
    final toPrepare = <int>[index - 1, index, index + 1, index + 2];
    for (final i in toPrepare) {
      if (i >= 0 && i < videoUrls.length) {
        await _prepareController(i);
      }
    }
  }

  Future<void> _prepareController(int index) async {
    if (_controllers.containsKey(index)) return; // already prepared

    final url = videoUrls[index];

    // Data source with cache configuration (plugin will pre-cache up to preCacheSize bytes)
    final dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      url,
      cacheConfiguration: const BetterPlayerCacheConfiguration(
        useCache: true,
        // tune sizes for your app; these are examples
        maxCacheSize: 200 * 1024 * 1024, // 200 MB total cache (Android)
        maxCacheFileSize: 50 * 1024 * 1024, // 50 MB per file (Android)
        preCacheSize: 4 * 1024 * 1024, // pre-cache first ~4 MB
      ),
    );

    final controller = BetterPlayerController(_playerConfig);
    _controllers[index] = controller;

    try {
      // Setup the data source (this triggers plugin cache / buffering logic)
      await controller.setupDataSource(dataSource);

      // Mute by default (Instagram style). When visible we call play().
      await controller.setVolume(0.0);
      _muted[index] = true;

      // If this index is currently visible, start playing
      if (index == _currentIndex) {
        await controller.play();
      }
      // We don't call setState here for every controller to avoid thrashing;
      // build will pick up new controllers when required.
    } catch (e) {
      // Keep app alive on errors
      debugPrint("Error preparing controller for $index: $e");
    }
  }

  void _disposeFarControllers(int currentIndex) {
    final keys = List<int>.from(_controllers.keys);
    for (final k in keys) {
      if (k < currentIndex - 1 || k > currentIndex + 1) {
        try {
          _controllers[k]?.dispose(forceDispose: true);
        } catch (_) {}
        _controllers.remove(k);
      }
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    for (final c in _controllers.values) {
      try {
        c.dispose(forceDispose: true);
      } catch (_) {}
    }
    _controllers.clear();
    super.dispose();
  }

  Widget _buildPage(int index) {
    final controller = _controllers[index];

    if (controller == null || !(controller.isVideoInitialized()??false)) {
      // Controller not ready yet
      _prepareController(index);
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    final isCurrent = index == _currentIndex;

    // ✅ Safely schedule play/pause after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_disposed) {
        if (isCurrent && !(controller.isPlaying()??false)) {
          controller.play();
        } else if (!isCurrent && (controller.isPlaying()??false)) {
          controller.pause();
        }
      }
    });

    return GestureDetector(
      onTap: () async {
        final isMuted = _muted[index] ?? true;
        await controller.setVolume(isMuted ? 1.0 : 0.0);
        _muted[index] = !isMuted;
        setState(() {});
      },
      child: SizedBox.expand(
        child: BetterPlayer(controller: controller),
      ),
    );
  }











  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Positioned.fill(child: _buildPage(index)),
              // Optional small overlay (username + caption)
              Positioned(
                left: 16,
                bottom: 36,
                right: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("@sample_user",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(
                      "This is a sample caption for video #$index",
                      style: const TextStyle(color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Optional right-side action column (visual only)
              Positioned(
                right: 12,
                bottom: 120,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _actionIcon(Icons.favorite, "1.2K"),
                    const SizedBox(height: 16),
                    _actionIcon(Icons.comment, "345"),
                    const SizedBox(height: 16),
                    _actionIcon(Icons.share, "Share"),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _actionIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}*/
