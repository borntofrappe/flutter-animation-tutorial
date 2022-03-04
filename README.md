[Flutter Animation Tutorial](https://youtube.com/playlist?list=PL4cUxeGkcC9gP1qg8yj-Jokef29VRCLt1)

> instead of instantiating the project from the first lesson I try to recreate the application from scratch

## Overview

```text
lib
    models
        Trip.dart
    screens
        details.dart
        home.dart
    shared
        heart.dart
        screenTitle.dart
        tripList.dart

    main.dart
```

`Trip.dart` defines a model for the trip.

`details.dart` and `home.dart` describe the two routes of the application.

The `shared` folder includes reusable widgets.

`main.dart` kickstarts the application.

### main

`main.dart` instantiates the application by creating a material application with the `Home` widget created in `home.dart`.

```dart
return MaterialApp(
    title: 'Trips',
    home: Home()
);
```

### home

`home.dart` creates a stateful widget with the following tree structure.

```text
Scaffold
    Container
        Column
            SizedBox
            SizedBox
                ScreenTitle
            Flexible
                TripList
```

The `Container` widget adds padding and a background image in the form of a `BoxDecoration` widget.

```dart
decoration: const BoxDecoration(
    image: DecorationImage(
        image: AssetImage('images/bg.png'),
        fit: BoxFit.fitWidth,
        alignment: Alignment.topLeft
    )
),
```

In the column the second `SizedBox` widget wraps around the reusable component `ScreenTitle` to create a container of a larger size.

The `Flexible` widget wraps around the reusable component `TripList`.

### screenTitle

The reusable widget is instantiated with a `text` property.

```dart
child: ScreenTitle(text: 'Trips'),
```

Create `ScreenTitle` as a stateless widget with the input string.

In the `build` function return a `Text` widget with said string.

```dart
return Text(text)
```

### tripList

`tripList.dart` creates a stateful widget for the list of trips. The idea is to ultimately add the widgets through a `ListView` widget.

```dart
return ListView.builder(
    key: _listKey,
    itemCount: _tripTiles.length,
    itemBuilder: (_, i) => _tripTiles[i]
);
```

Create an instance of a global key to keep track of the state in the widget.

```dart
final GlobalKey _listKey = GlobalKey();
```

Define a list to store the different widgets.

```dart
List<Widget> _tripTiles = [];
```

The list is populated in two steps:

- with `_addTrips` loop though a list of `Trip` objects to call for each instance the `_buildTile` function

  ```dart
  for (Trip trip in _trips) {
      _tripTiles.add(_buildTile(trip));
  }
  ```

  For the list define `_trips` with a few instances of the trip model.

  ```dart
  List<Trip> _trips = [
      Trip(),
      Trip(),
  ];
  ```

- with `_buildTile` produce the widget tree for an individual trip

  ```dart
  Widget _buildTile(Trip trip) {
      return ListTile()
  }
  ```

For each trip object the `ListTile` widget has several properties:

- `onTap` to consider the tap event — more of this later

- `title` to add the number of nights and the title of the trip

- `leading` to show the image

- `trailing` to highlight the price

In the `initState` method, lifecycle function invoked as the widget is first created, call `_addTrips` to populate the list of widgets.

```dart
@override
void initState() {
    super.initState();
    _addTrips();
}
```

### details

As a `ListTile` widget is tapped the idea is to create a details page for the individual trip. This is achieved with `Navigator.push` and the `MaterialPageRoute` object.

```dart
onTap: () {
    Navigator.push();
},
```

As the second argument of the `push` function include `MaterialPageRoute` with a `builder` field. It is this field which creates the second screen returning a widget.

```dart
MaterialPageRoute(
    builder: (context) => Details(trip: trip)
)
```

As the page is pushed the screen is added above the home widget. The action also implies that an application bar in the details page will include a back arrow to pop the screen.

Create `details.dart` as a stateless widget which receives a trip object.

In the `build` function return a `Scaffold` widget with several fields and a specific widget tree.

In a column add a `ClipRRect` widget to show a clippd version of the image associated with the trip.

```dart
ClipRRect(child: Image.asset())
```

Add a `ListTile` widget to describe the trip.

```dart
ListTile()
```

In the tile illustrate the trip with several a `title` and `subtitle`. Add also an instance of the heart widget in the `trailing field.

```dart
ListTile(
    trailing: Heart()
)
```

Finally add lorem ipsum text in a `Padding` and `Text` widget.

```dart
Padding(
    child: Text()
)
```

To include random letters install `flutter-lorem` — the course relies on `ipsum`, but the package no longer seems to be supported.

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_lorem: ^2.0.0
```

Import the module and produce the relevant string with the `lorem` function.

```dart
import 'package:flutter_lorem/flutter_lorem.dart';

//
Text(
    lorem(paragraphs: 1, words: 50),
)
```

### heart

The reusable widget is created as a stateful widget to ultimately change the state and appearance of the icon.

In the `build` function return an `IconButton` widget with a specific icon and an empty `onPressed` callback.

```dart
return IconButton(
    icon: Icon(Icons.favorite),
    onPressed: () {}
);
```
