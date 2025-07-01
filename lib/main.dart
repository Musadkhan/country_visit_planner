import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'Presentation/controller/country_controller.dart';
import 'Presentation/controller/filter_controller.dart';
import 'Presentation/controller/visited_controller.dart';
import 'Presentation/controller/wishlist_controller.dart';
import 'Presentation/data/country_repository.dart';
import 'app.dart';
import 'core/models/CountryResponseModel.dart';
import 'core/models/visited_country_model.dart';
import 'core/services/country_api_service.dart';

void main() async{


  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(CountryResponseModelAdapter());
  Hive.registerAdapter(VisitedCountryModelAdapter());

  await Hive.openBox<CountryResponseModel>('wishlist_box');
  await Hive.openBox<VisitedCountryModel>('visited_countries');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
          CountryController(CountryRepository(CountryApiService()))
            ..loadCountries(),
        ),
        ChangeNotifierProvider(create: (_) => WishlistController()),
        ChangeNotifierProvider(create: (_) => VisitedController()),
        ChangeNotifierProvider(create: (_) => FilterController()),
      ],
      child: const CountryVisitPlannerApp(),
    ),
  );
}

