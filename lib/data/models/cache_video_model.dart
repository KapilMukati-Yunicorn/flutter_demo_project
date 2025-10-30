import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CacheVideoItem {
  final String id;
  final String videoUrl;
  final String thumbnailUrl;
  final String username;
  final String profilePic;
  final String description;
  final String soundName;
  final int likes;
  final int comments;
  final int shares;
  final int favorites;
  VideoPlayerController? controller;
  bool isInitialized = false;
  bool isInitializing = false;

  CacheVideoItem({
    required this.id,
    required this.videoUrl,
    required this.thumbnailUrl,
    this.username = 'username',
    this.profilePic = 'https://via.placeholder.com/150',
    this.description = 'Video description',
    this.soundName = 'Original Sound',
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.favorites = 0,
  });

  Future<void> initializeController() async {
    if (isInitialized || isInitializing) return;

    isInitializing = true;
    try {
      controller = VideoPlayerController.networkUrl(
        Uri.parse(videoUrl),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );

      await controller!.initialize();
      controller!.setLooping(true);
      isInitialized = true;
    } catch (e) {
      debugPrint('Failed to initialize video $id: $e');
      controller?.dispose();
      controller = null;
    }
    isInitializing = false;
  }

  void disposeController() {
    controller?.dispose();
    controller = null;
    isInitialized = false;
    isInitializing = false;
  }

  CacheVideoItem copyWith({
    String? id,
    String? videoUrl,
    String? thumbnailUrl,
    String? username,
    String? profilePic,
    String? description,
    String? soundName,
    int? likes,
    int? comments,
    int? shares,
    int? favorites,
  }) {
    return CacheVideoItem(
      id: id ?? this.id,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      username: username ?? this.username,
      profilePic: profilePic ?? this.profilePic,
      description: description ?? this.description,
      soundName: soundName ?? this.soundName,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
      favorites: favorites ?? this.favorites,
    )..controller = controller;
  }
}