import 'package:flutter/material.dart';
import 'package:peliculas/src/search/search_delegate.dart';

import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/providers/movies_providers.dart';
import 'package:peliculas/src/widgets/circular_progress_indicator_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {

  final moviesProviders = new MoviesProviders();

  @override
  Widget build(BuildContext context) {

    moviesProviders.getPopulars();

    return Scaffold(
      appBar: _myAppBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _nowPlaying(),
          _populars(context),
        ],
      ),
    );
  }

  Widget _myAppBar(BuildContext context) {
    return AppBar(
      title: Text('Películas En Cines'),
      backgroundColor: Colors.indigoAccent,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          color: Colors.white,
          onPressed: () {
            showSearch(
              context: context,
              delegate: DataSearch(),
            );
          },
        )
      ],
    );
  }

  Widget _nowPlaying() {
    return FutureBuilder(
      future: moviesProviders.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(movies: snapshot.data);
        } else {
          return Container(
            height: 300.0,
            child: Center(
              child: MyCircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _populars(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Populares',
              style: Theme.of(context).textTheme.subhead)),
          SizedBox(height: 5.0),

          StreamBuilder(
            stream: moviesProviders.popularsStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  movies: snapshot.data,
                  nextPage: moviesProviders.getPopulars,
                );
              } else {
                return Center(child: MyCircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
