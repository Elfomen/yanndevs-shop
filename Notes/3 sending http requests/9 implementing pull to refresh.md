# Implementing the pull to refresh functionality in flutter

Now, any time a user enters our application, we have the home screen that sends a query to our database and fetch all the products, now when we want to access the edit screeen now, we simply get the products we already fetched in the home screen. Now we want to implement the pull to refresh functionality there to get the latest data from the api

to do that , go to the screen where you cwant to implement the refresh and on the body that is rendered there, wrap with the folowing widget

   body: RefreshIndicator(
        onRefresh: () => _refreshIndicator(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (_, i) => Column(
              children: [
                UserProductItem(
                    title: productDat

The method onRefresh calling a function _refreshIndicator, the content of that function is as follows

  Future<void> _refreshIndicator(BuildContext context)async {
    await Provider.of<Products>( context, listen: false).fetchAndSetProducts();
  }
and every thing works perfectly