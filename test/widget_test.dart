// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:retaste_app/bloc/cubit/cubit/check_connection_cubit.dart';
import 'package:retaste_app/bloc/cubit/cubit/favorite_restaurant_cubit.dart';
import 'package:retaste_app/bloc/cubit/cubit/restaurant_search_keywords_cubit.dart';
import 'package:retaste_app/bloc/restaurant_bloc.dart';

import 'package:retaste_app/main.dart';
import 'package:retaste_app/repository/local/restaurant_database.dart';
import 'package:retaste_app/repository/restaurant_data.dart';
import 'package:retaste_app/repository/restaurant_search_keywords_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final CheckConnectionCubit checkConnectionCubit = CheckConnectionCubit();
  final RestaurantData restaurantData = RestaurantData();
  final RestaurantBloc restaurantBloc = RestaurantBloc(restaurantData);
  final RestaurantDatabase restaurantDatabase = RestaurantDatabase();
  final RestaurantSearchKeywordsData restaurantSearchKeywordsData =
      RestaurantSearchKeywordsData(prefs: sharedPreferences);
  final RestaurantSearchKeywordsCubit restaurantSearchKeywordsCubit =
      RestaurantSearchKeywordsCubit(restaurantSearchKeywordsData);
  final FavoriteRestaurantCubit favoriteRestaurantCubit =
      FavoriteRestaurantCubit(restaurantDatabase);
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(RetasteApp(
      checkConnectionCubit: checkConnectionCubit,
      restaurantBloc: restaurantBloc,
      restaurantSearchKeywordsCubit: restaurantSearchKeywordsCubit,
      favoriteRestaurantCubit: favoriteRestaurantCubit,
    ));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
