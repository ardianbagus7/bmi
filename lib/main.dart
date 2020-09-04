import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udacoding_bootcamp/week4/week4.dart';
import 'cores/cores.dart';
// import 'week1/week1.dart';
import 'week2/week2.dart';
import 'week3/week3.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        //! Week 4
        ChangeNotifierProvider(create: (context) => AuthProvider4()),
        ChangeNotifierProvider(create: (context) => NoteProvider()),
        ChangeNotifierProvider(create: (context) => MarketplaceProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          '/pilih': (BuildContext context) => PilihPage(),
          '/login': (BuildContext context) => Login(),
          '/kalkulator': (BuildContext context) => Kalkulator(),
          '/bmi': (BuildContext context) => HomeBMI(),
          '/loginweek3': (BuildContext context) => LoginSql(),
          '/kamus': (BuildContext context) => KamusPage(),
          '/note': (BuildContext context) => MainPage4(),
          '/marketplace': (BuildContext context) => MainPageMarketplace(),
          '/gallery' : (BuildContext context) => GalleryHomePage(),
        },
      ),
    ),
  );
}
