the provider can be also written as follows

instead of using the change notifier with the create method in the main file for example,

    return ChangeNotifierProvider(
      create: (ctx) => Products(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
    
you can also use the ChangeNotifierProvider.value if you don't want to use the context like below

    return ChangeNotifierProvider.value(
      value: Products(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

# The recommended way is to use the  change notifier provider.value