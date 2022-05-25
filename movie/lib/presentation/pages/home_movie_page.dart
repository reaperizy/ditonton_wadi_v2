import 'package:about/about.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'package:search/presentation/pages/search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie/movie.dart';
import 'package:core/core.dart';
import 'package:tvseries/tvseries.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  HomeMoviePageState createState() => HomeMoviePageState();
  static const routeName = '/home';
}

class HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {super.initState();
    Future.microtask(() {
      context.read<NowPlayingsMoviesBloc>().add(NowPlayingsMoviesGetEvent());

      context.read<PopularsMoviesBloc>().add(PopularsMoviesGetEvent());

      context.read<TopRatedsMoviesBloc>().add(TopRatedsMoviesGetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('Television'),
              onTap: () {
                Navigator.pushNamed(context, HomeTelevisionPage.routeName);
              },
            ),
            ExpansionTile(
              title: const Text('Watchlist'),
              leading: const Icon(Icons.save_alt),
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.movie),
                  title: const Text('Movies'),
                  onTap: () {
                    Navigator.pushNamed(context, WatchlistMoviesPage.routeName);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.tv),
                  title: const Text('Television'),
                  onTap: () {
                    Navigator.pushNamed(
                        context, WatchlistTelevisionPage.routeName);
                  },
                ),
              ],
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.routeName);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              //FirebaseCrashlytics.instance.crash(); // Force a crash
              Navigator.pushNamed(context, SearchPage.routeName);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing Movies',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingsMoviesBloc, NowPlayingsMoviesState>(
                builder: (context, state) {
                  if (state is NowPlayingsMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if (state is NowPlayingsMoviesLoaded) {
                    return MovieList(state.movies);
                  }
                  else if (state is NowPlayingsMoviesError) {
                    return Text(state.message);
                  }
                  else {
                    return const Text('Failed to load Now Playing movies');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular Movies',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.routeName),
              ),
              BlocBuilder<PopularsMoviesBloc, PopularsMoviesState>(
                builder: (context, state) {
                  if (state is PopularsMoviesLoading) { return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if (state is PopularsMoviesLoaded) { return MovieList(state.result);
                  }
                  else if (state is PopularsMoviesError) { return Text(state.message);
                  } else {
                    return const Text('Failed to load Popular movies');
                  }
                },
              ),
              _buildSubHeading( title: 'Top Rated Movies',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.routeName),
              ),
              BlocBuilder<TopRatedsMoviesBloc, TopRatedsMoviesState>(
                builder: (context, state) {
                  if (state is TopRatedsMoviesLoading) { return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if (state is TopRatedsMoviesLoaded) { return MovieList(state.result);
                  }
                  else if (state is TopRatedsMoviesError) { return Text(state.message);
                  }
                  else { return const Text('Failed to load TopRated movies');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
