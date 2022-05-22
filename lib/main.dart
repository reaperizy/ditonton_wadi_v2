import 'package:about/about_page.dart';
import 'package:core/common/utils.dart';
import 'package:core/data/datasources/sslpinning/sslpinning.dart';
import 'package:core/presentation/pages/splash_screen.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/detailmovie/detail_movie_bloc.dart';
import 'package:movie/presentation/bloc/nowplaying/nowplaying_movie_bloc.dart';
import 'package:movie/presentation/bloc/popularmovie/popular_movie_bloc.dart';
import 'package:movie/presentation/bloc/recommend_movie/reccomend_movie_bloc.dart';
import 'package:movie/presentation/bloc/toprated_movie/toprated_movie_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:search/presentation/bloc/search_tv/search_tv_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:search/presentation/pages/search_page_tv.dart';
import 'package:tvseries/presentation/bloc/detail_tv/detail_tv_bloc.dart';
import 'package:tvseries/presentation/bloc/onair_tv/onair_tv_bloc.dart';
import 'package:tvseries/presentation/bloc/popular_tv/popular_tv_bloc.dart';
import 'package:tvseries/presentation/bloc/recommend_tv/reccomend_tv_bloc.dart';
import 'package:tvseries/presentation/bloc/toprated_tv/toprated_tv_bloc.dart';
import 'package:tvseries/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:tvseries/presentation/pages/home_tv_page.dart';
import 'package:tvseries/presentation/pages/popular_tv_page.dart';
import 'package:tvseries/presentation/pages/top_rated_tv_page.dart';
import 'package:tvseries/presentation/pages/tv_detail_page.dart';
import 'package:tvseries/presentation/pages/watchlist_tv_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SslPinnings.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<DetailsMoviesBloc>(),),
        BlocProvider(create: (_) => di.locator<PopularsMoviesBloc>(),),
        BlocProvider(create: (_) => di.locator<RecommendMoviesBloc>(),),
        BlocProvider(create: (_) => di.locator<SearchMoviesBloc>(),),
        BlocProvider(create: (_) => di.locator<TopRatedsMoviesBloc>(),),
        BlocProvider(create: (_) => di.locator<NowPlayingsMoviesBloc>(),),
        BlocProvider(create: (_) => di.locator<WatchlistMoviesBloc>(),),

        BlocProvider(create: (_) => di.locator<DetailsTvsBloc>(),),
        BlocProvider(create: (_) => di.locator<RecommendTvsBloc>(),),
        BlocProvider(create: (_) => di.locator<SearchTvsBloc>(),),
        BlocProvider(create: (_) => di.locator<PopularsTvsBloc>(),),
        BlocProvider(create: (_) => di.locator<TopRatedsTvsBloc>(),),
        BlocProvider(create: (_) => di.locator<OnAirsTvsBloc>(),),
        BlocProvider(create: (_) => di.locator<WatchlistTvsBloc>(),),
      ],

      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: SplashScreen(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case '/tv':
              return MaterialPageRoute(builder: (_) => HomeTelevisionPage());
            case PopularTelevisionPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => PopularTelevisionPage());
            case TopRatedTelevisionPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => TopRatedTelevisionPage());
            case TelevisionDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TelevisionDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.routeName:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SearchTelevisionPage.routeName:
              return CupertinoPageRoute(builder: (_) => SearchTelevisionPage());
            case WatchlistMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WatchlistTelevisionPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => WatchlistTelevisionPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
