import 'package:about/about_page.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/bloc/search_tv/search_tv_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:movie/movie.dart';
import 'package:tvseries/tvseries.dart';
import 'package:search/search.dart';
import 'package:core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SslPinnings.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) { return MultiProvider(
      providers: [
        //Movie Bloc
        BlocProvider(create: (_) => di.locator<DetailsMoviesBloc>(),),
        BlocProvider(create: (_) => di.locator<PopularsMoviesBloc>(),),
        BlocProvider(create: (_) => di.locator<RecommendMoviesBloc>(),),
        BlocProvider(create: (_) => di.locator<SearchMoviesBloc>(),),
        BlocProvider(create: (_) => di.locator<TopRatedsMoviesBloc>(),),
        BlocProvider(create: (_) => di.locator<NowPlayingsMoviesBloc>(),),
        BlocProvider(create: (_) => di.locator<WatchlistMoviesBloc>(),),

        //Tv Bloc
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
            case '/home': return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.routeName: return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.routeName: return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );

            case '/tv': return MaterialPageRoute(builder: (_) => HomeTelevisionPage());
            case PopularTelevisionPage.routeName: return CupertinoPageRoute(builder: (_) => PopularTelevisionPage());
            case TopRatedTelevisionPage.routeName: return CupertinoPageRoute(builder: (_) => TopRatedTelevisionPage());
            case TelevisionDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TelevisionDetailPage(id: id),
                settings: settings,
              );

            case SearchPage.routeName: return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.routeName: return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case SearchTelevisionPage.routeName: return CupertinoPageRoute(builder: (_) => SearchTelevisionPage());
            case WatchlistTelevisionPage.routeName: return MaterialPageRoute( builder: (_) => WatchlistTelevisionPage());
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
            }},
      ),
    );
  }
}
