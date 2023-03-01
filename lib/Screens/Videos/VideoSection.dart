import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:online_learner/library_main.dart';

final selectedVideoProvider = StateProvider<Video?>((ref) => null);

final miniPlayerControllerProvider =
    StateProvider.autoDispose<MiniplayerController>(
  (ref) => MiniplayerController(),
);

class VideoSection extends StatefulWidget {
  final Course? course;

  const VideoSection({
    Key? key,
    this.course,
  }) : super(key: key);

  @override
  _VideoSectionState createState() => _VideoSectionState();
}

class _VideoSectionState extends State<VideoSection> {
  static const double _playerMinHeight = 60.0;
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child("videos");
  late List<Video> videos = [
    Video(
        video_title: '',
        video_id: '',
        thumbNailUrl: 'https://i.ytimg.com/vi/ERFn-11i0u4/0.jpg',
        video_url: '',
        duration: '000')
  ];

  Future<void> _loadVideos() async {
    videos.clear();
    try {
      databaseReference.child(widget.course!.course_id).onValue.listen((event) {
        setState(() {
          for (final child in event.snapshot.children) {
            final json = child.value as Map<dynamic, dynamic>;
            final video = Video.fromJson(json);
            videos.add(video);
          }
        });
      });
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  @override
  void initState() {
    _loadVideos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _pinned = false;
    bool _snap = true;
    bool _floating = true;

    return Scaffold(
      body: Consumer(builder: (context, watch, _) {
        final selectedVideo = watch(selectedVideoProvider).state;
        final miniPlayerController = watch(miniPlayerControllerProvider).state;
        return Stack(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: _pinned,
                  snap: _snap,
                  floating: _floating,
                  backgroundColor: Colors.grey,
                  systemOverlayStyle:
                  const SystemUiOverlayStyle(statusBarColor: Colors.grey),
                  centerTitle: true,
                  elevation: 0.0,
                  iconTheme: const IconThemeData(color: Colors.black),
                  title: const Text(
                    "Video Lectures",
                    style: TextStyle(color: Colors.black),
                  ),
                  actions: <Widget>[
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                title: const Text(
                                  "Logout",
                                  style: TextStyle(fontSize: 20),
                                ),
                                content: const Text("Are you sure?",
                                    style: TextStyle(fontSize: 18)),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  TextButton(
                                    child: const Text("No"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text("Yes"),
                                    onPressed: () {
                                      FirebaseAuth.instance.signOut();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.logout,
                      ),
                      tooltip: 'Logout',
                    ),
                  ],
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final video = videos[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: VideoCard(video: video),
                      );
                    },
                    childCount: videos.length,
                  ),
                ),

              ],
            ),

            Offstage(
              offstage: selectedVideo == null,
              child: Miniplayer(
                controller: miniPlayerController,
                minHeight: _playerMinHeight,
                maxHeight: MediaQuery.of(context).size.height,
                builder: (height, percentage) {
                  if (selectedVideo == null) {
                    return const SizedBox.shrink();
                  }
                  if (height <= _playerMinHeight + 50.0) {
                    return Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.network(
                                selectedVideo.thumbNailUrl,
                                height: _playerMinHeight - 4.0,
                                width: 120.0,
                                fit: BoxFit.cover,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          selectedVideo.video_title,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          "",
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                              fontWeight:
                                              FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.play_arrow),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  context.read(selectedVideoProvider).state =
                                  null;
                                },
                              ),
                            ],
                          ),
                          // const LinearProgressIndicator(
                          //   value: 0.4,
                          //   valueColor: AlwaysStoppedAnimation<Color>(
                          //     Colors.red,
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  }
                  return HomeScreen(pageId: "VideoScreen", videos: videos,);
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
