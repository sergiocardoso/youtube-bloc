import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:youtube_app/blocs/favorite_bloc.dart';
import 'package:youtube_app/models/video.dart';

import '../api.dart';

class VideoTile extends StatelessWidget {
  final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);
    return GestureDetector(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16.0 / 9.0,
                child: Image.network(video.thumb, fit: BoxFit.cover),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            video.title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                          child: Text(
                            video.channel,
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  StreamBuilder<Map<String, Video>>(
                    stream: bloc.outFav,
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return IconButton(
                            icon: Icon(snapshot.data.containsKey(video.id)
                                ? Icons.star
                                : Icons.star_border),
                            color: Colors.white,
                            iconSize: 30.0,
                            onPressed: () {
                              bloc.toggleFavorite(video);
                            });
                      else {
                        return CircularProgressIndicator();
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
        onTap: () {
          FlutterYoutube.playYoutubeVideoById(
              apiKey: API_KEY, videoId: video.id);
        });
  }
}
