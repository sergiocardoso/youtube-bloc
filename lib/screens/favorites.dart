import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app/api.dart';
import 'package:youtube_app/blocs/favorite_bloc.dart';
import 'package:youtube_app/models/video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder<Map<String, Video>>(
        initialData: {},
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values.map((video) {
              return InkWell(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(video.thumb),
                    ),
                    Expanded(
                        child: Text(video.title,
                            style: TextStyle(color: Colors.white70),
                            maxLines: 2))
                  ],
                ),
                onTap: () {
                  FlutterYoutube.playYoutubeVideoById(
                      apiKey: API_KEY, videoId: video.id);
                },
                onLongPress: () {
                  bloc.toggleFavorite(video);
                },
              );
            }).toList(),
          );
        },
        stream: bloc.outFav,
      ),
    );
  }
}
