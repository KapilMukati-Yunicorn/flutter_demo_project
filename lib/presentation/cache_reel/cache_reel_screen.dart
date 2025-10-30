import 'package:bloc_project/core/colors/colors.dart';
import 'package:bloc_project/core/constants/string_constants.dart';
import 'package:bloc_project/core/navigation/navigation_service.dart';
import 'package:bloc_project/core/themes/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/cache_video_model.dart';
import '../../logic/cache_reel/cache_reel_bloc.dart';
import '../../logic/cache_reel/cache_reel_event.dart';
import '../../logic/cache_reel/cache_reel_state.dart';
import 'cache_video_player_widget.dart';

class CacheReelScreen extends StatefulWidget {
  const CacheReelScreen({super.key});

  @override
  State<CacheReelScreen> createState() => _ReelScreenState();
}

class _ReelScreenState extends State<CacheReelScreen> {
  final PageController _pageController = PageController();

  late CacheReelBloc _reelBloc;

  @override
  void initState() {
    super.initState();
    _reelBloc = CacheReelBloc()..add(LoadReelsEvent());
  }

  @override
  void dispose() {
    _pageController.dispose();
    _reelBloc.add(PauseAllVideosEvent());
    _reelBloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _reelBloc,
      child: WillPopScope(
        onWillPop: () async {
          _reelBloc.add(PauseAllVideosEvent());
          return true; // Allow navigation
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(StringConstants.reels,style: AppTextStyle.titleStyle18bw,),
            leading:GestureDetector(
              onTap: () {
                _reelBloc.add(PauseAllVideosEvent());
                NavigationService.pop();
              },
              child: Icon(Icons.arrow_back_ios, size: 30, color: AppColors.white),
            ),
          ),
          backgroundColor: Colors.black,
          body: BlocBuilder<CacheReelBloc, CacheReelState>(
            builder: (context, state) {
              if (state is ReelLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ReelError) {
                return Center(child: Text(state.message));
              } else if (state is ReelLoaded) {
                return _buildVideoList(context, state);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
  Widget _buildVideoList(BuildContext context, ReelLoaded state) {
    return PageView.builder(
      controller: _pageController,
      itemCount: state.videos.length,
      scrollDirection: Axis.vertical,
      onPageChanged: (index) {
        context.read<CacheReelBloc>().add(PageChangedEvent(index));
      },
      itemBuilder: (context, index) {
        final video = state.videos[index];
        final isCurrentVideo = index == state.currentIndex;

        return Stack(
          children: [
            // Video Player - No loading indicators!
            CacheVideoPlayerWidget(
              video: video,
              autoPlay: isCurrentVideo && state.isPlaying,
              onTap: () {
                if (isCurrentVideo) {
                  context.read<CacheReelBloc>().add(PlayPauseVideoEvent(index));
                }
              },
            ),

            // Video Info Overlay
            _buildVideoInfoOverlay(context, video),

            // Right Side Actions
            _buildRightSideActions(context, video),
          ],
        );
      },
    );
  }

  Widget _buildVideoInfoOverlay(BuildContext context, CacheVideoItem video) {
    return Positioned(
      bottom: 80,
      left: 16,
      right: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Username
          Text(
            video.username,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Description
          Text(
            video.description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),

          // Sound
          Row(
            children: [
              const Icon(Icons.music_note, color: Colors.white, size: 16),
              const SizedBox(width: 4),
              Text(
                video.soundName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRightSideActions(BuildContext context, CacheVideoItem video) {
    return Positioned(
      right: 16,
      bottom: 100,
      child: Column(
        children: [
          // Profile Image
          _buildActionButton(
            icon: Icons.account_circle,
            count: null,
            onTap: () {},
          ),
          const SizedBox(height: 20),

          // Like Button (icon only)
          _buildActionButton(
            icon: Icons.favorite_border,
            count: video.likes,
            onTap: () {},
          ),
          const SizedBox(height: 20),

          // Comment Button (icon only)
          _buildActionButton(
            icon: Icons.chat_bubble_outline,
            count: video.comments,
            onTap: () {},
          ),
          const SizedBox(height: 20),

          // Share Button (icon only)
          _buildActionButton(
            icon: Icons.share,
            count: video.shares,
            onTap: () {},
          ),
          const SizedBox(height: 20),

          // Favorite Button (icon only)
          _buildActionButton(
            icon: Icons.bookmark_border,
            count: video.favorites,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required int? count,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.white, size: 32),
          onPressed: onTap,
        ),
        if (count != null)
          Text(
            _formatCount(count),
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
      ],
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}