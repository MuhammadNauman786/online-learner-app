import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_learner/library_main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final List<Video> videoList;
  final Video? video;

  const VideoScreen({Key? key, required this.videoList, this.video})
      : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .read(miniPlayerControllerProvider)
          .state
          .animateToHeight(state: PanelState.MAX),
      child: Scaffold(
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: CustomScrollView(
            controller: _scrollController,
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                child: Consumer(
                  builder: (context, watch, _) {
                    final selectedVideo = watch(selectedVideoProvider).state;

                    return SafeArea(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              YoutubePlayer(
                                controller: YoutubePlayerController(
                                  initialVideoId: selectedVideo!.video_url,
                                  flags: const YoutubePlayerFlags(
                                    mute: false,
                                    autoPlay: true,
                                  ),
                                ),
                                showVideoProgressIndicator: true,
                                progressIndicatorColor: Colors.red,

                                bottomActions: [
                                  CurrentPosition(),
                                  ProgressBar(
                                    isExpanded: true,
                                    colors: const ProgressBarColors(
                                        playedColor: Colors.red,
                                        bufferedColor: Colors.grey,
                                        handleColor: Colors.red,
                                        backgroundColor: Colors.black),
                                  ),
                                  RemainingDuration(),
                                  const PlaybackSpeedButton(),
                                  FullScreenButton(),
                                ],
                                onReady: () {
                                  print('Player is ready.');
                                },
                              ),
                              IconButton(
                                iconSize: 30.0,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                onPressed: () => context
                                    .read(miniPlayerControllerProvider)
                                    .state
                                    .animateToHeight(state: PanelState.MIN),
                              ),
                            ],
                          ),
                          // const LinearProgressIndicator(
                          //   value: 0.4,
                          //   valueColor: AlwaysStoppedAnimation<Color>(
                          //     Colors.red,
                          //   ),
                          // ),
                          VideoInfo(video: selectedVideo),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final video = widget.videoList[index];
                    return VideoCard(
                      video: video,
                      hasPadding: true,
                      onTap: () => _scrollController!.animateTo(
                        0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      ),
                    );
                  },
                  childCount: widget.videoList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
