import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app/blocs/favorite_bloc.dart';
import 'package:youtube_app/blocs/videos_block.dart';
import 'package:youtube_app/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: BlocProvider(
        child: MaterialApp(
          title: 'FlutterTube',
          home: Home(),
          debugShowCheckedModeBanner: false,
        ),
        bloc: FavoriteBloc(),
      ),
      bloc: VideosBlock(),
    );
  }
}
