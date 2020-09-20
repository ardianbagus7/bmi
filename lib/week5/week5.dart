import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:udacoding_bootcamp/cores/cores.dart';
import 'package:udacoding_bootcamp/week4/week4.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'movie/model/movie_model.dart';
part 'movie/repository/movie_repository.dart';
part 'movie/provider/movie_provider.dart';
part 'movie/ui/home_movie_page.dart';
part 'movie/ui/detail_movie_page.dart';
part 'movie/ui/favorite_movie_page.dart';
part 'youtube/ui/youtube_home_page.dart';
part 'youtube/ui/detail_youtube_page.dart';
part 'youtube/model/youtube_model.dart';

class MainMoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider4>(
      builder: (context, provider, child) {
        switch (provider.status) {
          case Status.Uninitialized:
            return InitAuth4();
          case Status.Relogin:
            return Loading();
          case Status.Unauthenticated:
            return AuthPage4();
          case Status.Authenticated:
            return MovieHomePage();
          default:
            return Loading();
        }
      },
    );
  }
}
