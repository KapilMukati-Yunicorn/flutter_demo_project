class VideoItem {
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

  const VideoItem({
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
}