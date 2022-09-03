we need to declare our own classes that are going to handle the http exceptions

In your models, create a new folder exceptions and a new file named http exceptions

class HttpExceptions implements Exception {
  final String message;

  HttpExceptions({required this.message});

  @override
  String toString() {
    return message;
  }
}

we have created our class and override the method toString() so that it should not more show the instance of http exception but the actual message