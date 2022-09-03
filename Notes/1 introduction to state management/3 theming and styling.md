in the main file lets declare our theme

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange
      ),
      home: ProductOverviewScreen(),

adding the fonts, if you remember what we did in the last videos

so to do that, first include all your ttf fonts in an assets folder inside the font folder, then make sure you go to the pubspec.yaml file and add the following

      fonts:
    - family: Lato
      fonts:
        - asset: assets/fonts/Latto-Regular.ttf
        - asset: assets/fonts/Latto-Bold.ttf
          weight: 700
    - family: Anton
      fonts:
        - asset: assets/fonts/Anton-Regular.ttf

Now in the main dart file, go on to your themes and setup the main font family to one of waht you just registered above

