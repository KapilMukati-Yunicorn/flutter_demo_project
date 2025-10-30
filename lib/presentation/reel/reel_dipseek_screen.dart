import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/video_model.dart';
import '../../logic/reel/video_bloc.dart';
import '../../logic/reel/video_event.dart';
import '../../logic/reel/video_state.dart';
import 'video_player_widget.dart';

class ReelScreen extends StatelessWidget {
  const ReelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReelBloc()..add(LoadReelsEvent()),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocListener<ReelBloc, ReelState>(
          listener: (context, state) {
            if (state is ReelLoaded) {
              debugPrint('Current index: ${state.currentIndex}, Playing: ${state.isPlaying}');
            }
          },
          child: BlocBuilder<ReelBloc, ReelState>(
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
      itemCount: state.videos.length,
      scrollDirection: Axis.vertical,
      onPageChanged: (index) {
        context.read<ReelBloc>().add(PageChangedEvent(index));
      },
      itemBuilder: (context, index) {
        final video = state.videos[index];
        final isCurrentVideo = index == state.currentIndex;
        final isLoading = state.videoLoadingStates[index] ?? true;

        return Stack(
          children: [
            // Video Player or Loading
            VideoPlayerWidget(
              videoUrl: video.videoUrl,
              thumbnailUrl: video.thumbnailUrl,
              autoPlay: isCurrentVideo && state.isPlaying,
              onTap: () {
                if (isCurrentVideo) {
                  context.read<ReelBloc>().add(PlayPauseVideoEvent(index));
                }
              },
              onInitialized: (isLoading) {
                if (!isLoading) {
                  context.read<ReelBloc>().add(VideoInitializedEvent(index));
                }
              },
            ),

            // Loading overlay if current video is still loading
            if (isCurrentVideo && isLoading)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
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

  Widget _buildVideoInfoOverlay(BuildContext context, VideoItem video) {
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

  Widget _buildRightSideActions(BuildContext context, VideoItem video) {
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