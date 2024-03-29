import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app/blocs/favorite_bloc.dart';
import 'package:youtube_app/blocs/videos_block.dart';
import 'package:youtube_app/delegates/data_search.dart';
import 'package:youtube_app/models/video.dart';
import 'package:youtube_app/screens/favorites.dart';
import 'package:youtube_app/widgets/video_tile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<VideosBlock>(context);

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Container(
            height: 25.0,
            child: Image.asset("images/yt_logo_rgb_dark.png"),
          ),
          elevation: 0,
          backgroundColor: Colors.black,
          actions: <Widget>[
            Align(
              alignment: Alignment.center,
              child: StreamBuilder<Map<String, Video>>(
                stream: BlocProvider.of<FavoriteBloc>(context).outFav,
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return Text("${snapshot.data.length}");
                  else
                    return Container();
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.star),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Favorites()));
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String result =
                    await showSearch(context: context, delegate: DataSearch());
                print("Resultado pesquisado:" + result);
                if (result != null) bloc.inSearch.add(result);
              },
            ),
          ],
        ),
        body: StreamBuilder(
          initialData: [],
          stream: bloc.outVideos,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return ListView.builder(
                itemBuilder: (context, index) {
                  if (index < snapshot.data.length) {
                    return VideoTile(snapshot.data[index]);
                  } else if (index > 1) {
                    bloc.inSearch.add(null);
                    return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                itemCount: snapshot.data.length + 1,
              );
            else
              return Container();
          },
        ));
  }
}
