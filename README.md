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

## Built-in animations

Flutter provides widgets to implicitly animate several properties.

With `AnimatedContainer` gradually change values such as margin, width and color.

With `AnimatedOpacity` gradually change the opacity.

Both widgets require a `duration` field.

```dart
AnimatedContainer(
    duration: Duration(seconds: 1),
)
```

Any property set on the nested widget and updated with `setState` is then automatically tweened over time.

```dart
// set up variable
_color = Colors.blue;

// use in AnimatedContainer
AnimatedContainer(
    duration: Duration(seconds: 1),
    color: _color,
)

// update through setState
setState(() {
    _color: Colors.purple;
})
```

## TweenAnimationBuilder

With the `TweenAnimationBuilder` widget define implicit animations with a start and end value. Use the tweened result in the application.

Begin by wrapping the widgets to-be-animated in `TweenAnimationBuilder`.

```dart
TweenAnimationBuilder(
    child: Text()
)
```

The widget requires three fields: `duration`, `tween` and `builder`.

With `duration` describe the duration for the tween.

```dart
duration: const Duration(milliseconds: 500),
```

With `tween` define the start and end value.

```dart
tween: Tween<double>(begin: 0, end: 1),
```

With `builder` elaborate a function which receives a context, the tweened value and the widget — in the example `Text`.

```dart
builder: (BuildContext context, double _tweenedValue, Widget? child) {}
```

In the function return a widget. For instance an `Opacity` widget which wraps around the child and changes is opacity.

```dart
return Opacity(
    opacity: _tweenedValue,
    child: child
)
```

To animate multiple properties return a more complex widget tree.

```dart
return Opacity(
    opacity: _tweenedValue,
    child: Padding(
        padding: EdgeInsets.only(top: _tweenedValue * 20),
        child: child
    )
)
```

## Hero animation

Use the `Hero` widget to animate widgets between screens.

Wrap the widget in a `Hero` widget.

```dart
child: Hero(
    child: Image.asset()
)
```

Add the required `tag` field as a unique string.

```dart
child: Hero(
    tag: 'location-img-${trip.img}',
    child: Image.asset()
)
```

Repeat the same setup in a different screen and Flutter creates the animation.

## Mixin

Mixin provide an interface to include additional functionalities.

As an example, a `User` class might define a method so that every instance can invoke the function.

```dart
void main() {
  User().sayHello();
}


class User {
  void sayHello() {
    print('Hello');
  }
}
```

A class extending `User` has access to the same method.

```dart
void main() {
  PoliteUser().sayHello();
}

class PoliteUser extends User {}
```

For additional functionalities you can specify attributes and methods in the extending class _or_ rely on a mixin.

Define the mixin.

```dart
mixin Goodbye {
  void sayGoodbye() {
    print('Goodbye');
  }
}
```

Add the functionality of the mixin to the extending class.

```dart
void main() {
  PoliteUser().sayHello();
  PoliteUser().sayGoodbye();
}

class PoliteUser extends User with Goodbye {}
```

## Animation controller

An animation controller is how you create explicit animations. The feature is implemented in the context of the heart widget, in order to:

1. change the color of the icon as the button is toggled

2. change the size of the icon as the button is pressed — in the next section

### controller

Define a variable to store the controller.

```dart
late AnimationController _controller;
```

In the `initState` lifecycle method initialize the controller as an instance of `AnimationController`.

```dart
@override
void initState() {
    _controller = AnimationController()
}
```

The object requires a `duration` and `vsync` field. The duration refers to an instance of the `Duration` object.

```dart
AnimationController(
    duration: const Duration(milliseconds: 300),
)
```

`vsync` refers to a ticker. To gain access to this ticker include the `TickerProviderStateMixin` mixin.

```dart
class _HeartState extends State<Heart> with TickerProviderStateMixin {}
```

With the mixin you gain access to the vsync value through the `this` keyword.

```dart
AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this
);
```

### Animation

Once you initialize the controller run the animation with the `forward` function.

```dart
_controller.forward();
```

You can listen to the changing value through the `addListener` method.

```dart
_controller.addListener(() {
    print(_controller.value)
});
```

### ColorTween

To update the color refer to the controller through a `ColorTween` widget.

Define a variable for the color animation.

```dart
late Animation _colorAnimation;
```

As you instantiate the controller initialize the color animation as well.

With `ColorTween` specify the start and end values for the animation.

```dart
ColorTween(begin: Colors.grey[400], end: Colors.red)
```

To obtain the animation chain the `animate` function and refer to the controller.

```dart
_colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red).animate(_controller);
```

In this manner `_colorAnimation.value` describes a color in the selected range, animated through the controller.

```dart
Icon(
    Icons.favorite,
    color: _colorAnimation.value,
),
```

To update the widget, however, you need to update the state.

```dart
_controller.addListener(() {
    setState(() {});
});
```

Alternatively, create an `AnimatedBuilder` widget.

```dart
AnimatedBuilder()
```

In this widget refer to the controller through the `animation` field.

```dart
AnimatedBuilder(
    animation: _controller,
)
```

Through the `builder` field describe a function which returns the desired, changing widget tree.

```dart
AnimatedBuilder(
    animation: _controller,
    builder: (BuildContext context, _) {
        return IconButton(
            icon: Icon(
                icons.faorite,
                color: _colorAnimation.value
            ),
            onPressed: () {
                _controller.forwards();
            }
        )
    }
)
```

The widget automatically updates the value of the affected animations.

### direction

`forward` runs the animation forward, meaning the specific animation updates the color from grey to red. As the button is pressed once more, however, the color does not revert to its initial value. To achieve this tap into the status of the animation.

Create a variable to keep track of the button's state.

```
bool isFavorite = false;
```

In the addStatusListener method the controller passes the status as the animation is run.

```dart
_controller.addStatusListener((status) {}
```

Use the value to update the boolean considering two specific statuses: completed and dismissed.

```dart
if(status == AnimationStatus.completed) {
    setState(() {
        isFavorite = true;
    });
} else if(status == AnimationStatus.dismissed) {
    setState(() {
        isFavorite = false;
    });
}
```

With the updated boolean run the animation forward or backwards.

```dart
onPressed: () {
    if(isFavorite) {
    _controller.reverse();
    } else {
    _controller.forward();
    }
}
```

### dispose

As the widget is destroyed dispose of the animation controller to let flutter free the necessary resources.

@override
void dispose() {
super.dispose();
\_controller.dispose();
}

Invoke the dispose method in the dispose lifecycle function.

## Tween sequences

`ColorTween` interpolates between a start and end value, changing the color of the icon between grey and red.

For the size the idea is to interpolate between three values, effectively expanding the icon for brief amount of time.

Create a variable to keep track of the animation.

```dart
late Animation _sizeAnimation;
```

As the controller is defined store in the variable a an instance of `TweenSequence`, again animated by the controller.

```dart
TweenSequence().animate(_controller);
```

`TweenSequence` receives a list of `TweenSequenceItem`, themselves responsible for interpolating between multiple values.

```dart
TweenSequence([
    TweenSequenceItem(),
    TweenSequenceItem(),
])
```

Each item specifies a tween and weight.

`tween` works similarly to the color tween, instantiating a `Tween` with a begin and end value.

```dart
TweenSequenceItem(
    tween: Tween(begin: 1, end: 1.5)
)
```

`weight` describes the percentage of the animation duration. By assigning the same weight to two items the duration is split equally between the two steps.

```dart
TweenSequenceItem(
    tween: Tween(begin: 1, end: 1.5),
    weight: 50,
),
TweenSequenceItem(
    tween: Tween(begin: 1.5, end: 1),
    weight: 50,
)
```

With this setup `_sizeAnimation` is updated similarly to `_colorAnimation`. Tap in the changing value in the `AnimatedBuilder` widget to modify the size of the icon.

```dart
Icon(
    Icons.favorite,
    color: _colorAnimation.value,
    size: _sizeAnimation.value
),
```

---

The course uses the value directly the `size` field of the icon widget.

```dart
Icon(
    Icons.favorite,
    color: _colorAnimation.value,
    size: _sizeAnimation.value
),
```

The scale is however updated from the top left corner. To have the icon scale from its center wrap the widget in a `Transform.scale` widget and use the `scale` field instead.

```dart
Transform.scale(
    scale: _sizeAnimation.value,
    child: Icon()
)
```

## Curves

Specify a curve to modify the pace of an animation, its timing function.

With built-in animations add a curve directly in the animatng widget.

```dart
TweenAnimationBuilder(
    curve: Curves.easeIn,
)
```

For custom animations the process is slightly more elaborate, and relies on creating a curved animation inheriting from the controller.

Define a variable for the curved animation.

```dart
late Animation<double> _curve;
```

With the controller initialize the curve with the `CurvedAnimation` object.

```dart
_curve = CurvedAnimation();
```

In the object specify the curve and the parent controller.

```dart
CurvedAnimation(parent: _controller, curve: Curves.slowMiddle)
```

With this setup animate the different tween through the curve.

```diff
-.animate(_controller);
+.animate(_curve);
```

The controller is already incorporated in the curved animation.

## List

To illustrate how items are animated in a list I created a small playground in `animatedListSample.dart`.

### List widgets

With a list of widgets `listTiles` the `ListView` widget creates multiple widgets through the `itemBuilder` function.

```dart
ListView.builder(
  itemCount: listTiles.length,
  itemBuilder: (context, index) {
    return listTiles[index];
  }
),
```

To animate the items replace the widget with an `AnimatedList`.

```dart
AnimatedList()
```

### AnimatedList

In the instance specify a key which is of type `AnimatedListState`.

```dart
final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

// later
AnimatedList(
    key: _listKey
)
```

Instead of `itemCount` describe the number of initial items with `initialItemCount`.

```dart
AnimatedList(
    key: _listKey
    initialItemCount: listTiles.length,
)
```

In the `itemBuilder` function structure a function which receives three arguments: the context, index as well as the animation object.

```dart
AnimatedList(
    key: _listKey
    initialItemCount: listTiles.length,
    itemBuilder: (context, index, animation) {}
)
```

In the body of the function return a widget which benefits from the animation, for instance a `SlideTransition` widget.

```dart
itemBuilder: (context, index, animation) {
    return SlideTransition();
}
```

`SlideTransition` wraps around the widget and animates its position through the matching field.

```dart
SlideTransition(
    child: listTiles[index],
    position: animation.drive(_offsetIn)
)
```

`animation.drive` receives an instance of a `Tween`, detailing the start and end value.

```dart
final Tween<Offset> _offsetIn = Tween(begin: const Offset(-1, 0), end: const Offset(0, 0));
```

### Key

`AnimatedList` is not enough to run the animation. It is necessary to instruct flutter of the changing state through the global key.

In the moment you add new items, for instance.

```dart
listTiles.add(listTile);
```

Update the key with the `insertItem` method available in the `currentState` object.

```dart
_listKey.currentState?.insertItem(listTiles.length - 1);
```

As you remove items

```dart
listTiles.remove(listTile);
```

Use the key with `removeItem` method, this time specifying not only the index of the item, but a widget for how the widget is removed.

```dart
_listKey.currentState?.removeItem(0, (context, animation) {
    return SlideTransition(
    child: listTile,
    position: animation.drive(_offsetOut)
    );
});
```

### WidgetsBinding

When items are added in the `initState` lifecycle method the animation is not run. To wait for the `build` method wrap the instruction in a specific callback.

```dart
void initState() {
  super.initState();

  WidgetsBinding.instance?.addPostFrameCallback((_) {
      // add and animate
  }
}
```

### Stagger

In the actual application the logic of the playground is included to only animate existing items. The state of the key is therefore updated in the `_addTrips` function.

```dart
_tripTiles.add(_buildTile(trip));
_listKey.currentState?.insertItem(_tripTiles.length - 1);
```

To stagger the animation the course relies on dart concept of _futures_, promises to run logic in sequence. The idea is to chain multiple futures so that Flutter waits before adding a new item and updating the key.

Define a starting, empty primise.

```dart
Future ft = Future(() {});
```

In the loop update the future with `ft.then()`, which describes the promise itself.

```dart
ft = ft.then((_) {
}
```

With `Future.delayed` the promise resolves after the specified duration, meaning the iteration waits for the specific amount of time.

```dart
return Future.delayed(const Duration(milliseconds: 200), () {});
```
