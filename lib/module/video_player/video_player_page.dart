import 'package:flutter/material.dart';
import 'package:women_fitness_flutter/generated/l10n.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';
import 'package:women_fitness_flutter/shared/utils.dart';
import 'package:women_fitness_flutter/shared/widget/page_container.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  final WorkOut workOut;

  VideoPlayerPage({@required this.workOut});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  bool isShowVideo = false;
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.workOut.video,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(Utils.getLanguageDevice(context));
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      appBar: AppBar(
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                isShowVideo = !isShowVideo;
              });
            },
            child: Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(top: 5, bottom: 5, right: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  isShowVideo
                      ? Icon(
                          Icons.videocam,
                          size: 30,
                          color: AppColor.main,
                        )
                      : Icon(
                          Icons.image,
                          size: 30,
                          color: AppColor.main,
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  TextApp(
                    textColor: AppColor.main,
                    content: isShowVideo
                        ? S.current.video.toUpperCase()
                        : S.current.video_gif.toUpperCase(),
                  )
                ],
              ),
            ),
          )
        ],
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isShowVideo
                ? YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.amber,
                  )
                : Image.asset(
                    'assets/data/${widget.workOut.anim}_0.gif',
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: 220,
                  ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: TextApp(
                size: 25,
                content: '${widget.workOut.title.toUpperCase()} ${widget.workOut.type == 0 ? '${widget.workOut.timeDefault}s' : 'x${widget.workOut.countDefault}'}',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: TextApp(
                content: widget.workOut.description,
                size: 18,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
