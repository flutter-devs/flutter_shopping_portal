# Flutter Shopping App using Provider

A flutter app to showcase online shopping portal using `Provider` architecture. `FireStore` has been used as backend for this app.


# Android Screens
<img height="480px" src="https://github.com/flutter-devs/flutter_shopping_portal/blob/master/assets/screens/android/screen1.png"> <img height="480px" src="https://github.com/flutter-devs/flutter_shopping_portal/blob/master/assets/screens/android/screen2.png"> <img height="480px" src="https://github.com/flutter-devs/flutter_shopping_portal/blob/master/assets/screens/android/screen3.png"> <img height="480px" src="https://github.com/flutter-devs/flutter_shopping_portal/blob/master/assets/screens/android/screen4.png">


# iOS Screens
<img height="480px" src="https://github.com/flutter-devs/flutter_shopping_portal/blob/master/assets/screens/ios/screen1.png"> <img height="480px" src="https://github.com/flutter-devs/flutter_shopping_portal/blob/master/assets/screens/ios/screen2.png"> <img height="480px" src="https://github.com/flutter-devs/flutter_shopping_portal/blob/master/assets/screens/ios/screen3.png"> <img height="480px" src="https://github.com/flutter-devs/flutter_shopping_portal/blob/master/assets/screens/ios/screen4.png"> <img height="480px" src="https://github.com/flutter-devs/flutter_shopping_portal/blob/master/assets/screens/ios/screen5.png">



# Provider  [![pub package](https://img.shields.io/pub/v/provider.svg)](https://pub.dev/packages/provider)

Among multiple state management in flutter, `Providet` is now more powerful,  flixible and easy to undersand. It has the power of managing state in efficient manager by using  `Consumer` and `Selector` and now it can deals with `Stream` and `Future` also.

A mixture between dependency injection (DI) and state management, built with widgets for widgets.

## *Why?*
It purposefully uses widgets for DI/state management instead of dart-only classes like `Stream`. The reason is, widgets are very simple yet robust and scalable.

## *Customizable*
By using the power of provider we can make our own provider. `Provider` expose all the small components that makes a fully fledged provider.

`Provider` includes below widgets for customizability:
-   `SingleChildCloneableWidget`, to make any widget works with  `MultiProvider`.
-   `InheritedProvider`, the generic  `InheritedWidget`  obtained when doing  `Provider.of`.
-   `DelegateWidget`/`BuilderDelegate`/`ValueDelegate`  to help handle the logic of "MyProvider() that creates an object" vs "MyProvider.value() that can update over time".

## *Pros of Provider*
-   UI logic and business logic are clearly separated
-   Provider is customizable and gives flexibility to customize provider according to your need to boost the performance and stability.
-   Easy to understand and implement
-   Can be set up with unidirectional data flow without much difficulty, gaining the main benefit of Redux as well as provider is more powerful to handle global state.
-   Robustness, as it is harder to forget to handle the update scenario of a model/widget

## *Existing providers*

`provider` exposes a few different kinds of "provider" for different types of objects.

The complete list of all the objects available is [here](https://pub.dev/documentation/provider/latest/provider/provider-library.html)

| name                                                                                                                          | description                                                                                                                                                            |
| ----------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Provider](https://pub.dartlang.org/documentation/provider/latest/provider/Provider-class.html)                               | The most basic form of provider. It takes a value and exposes it, whatever the value is.                                                                               |
| [ListenableProvider](https://pub.dartlang.org/documentation/provider/latest/provider/ListenableProvider-class.html)           | A specific provider for Listenable object. ListenableProvider will listen to the object and ask widgets which depend on it to rebuild whenever the listener is called. |
| [ChangeNotifierProvider](https://pub.dartlang.org/documentation/provider/latest/provider/ChangeNotifierProvider-class.html)   | A specification of ListenableProvider for ChangeNotifier. It will automatically call `ChangeNotifier.dispose` when needed.                                             |
| [ValueListenableProvider](https://pub.dartlang.org/documentation/provider/latest/provider/ValueListenableProvider-class.html) | Listen to a ValueListenable and only expose `ValueListenable.value`.                                                                                                   |
| [StreamProvider](https://pub.dartlang.org/documentation/provider/latest/provider/StreamProvider-class.html)                   | Listen to a Stream and expose the latest value emitted.                                                                                                                |
| [FutureProvider](https://pub.dartlang.org/documentation/provider/latest/provider/FutureProvider-class.html)                   | Takes a `Future` and updates dependents when the future completes.

To read more about `provider`, see the [documentation](https://pub.dev/documentation/provider/latest/).