import 'package:flutter/material.dart';

void main() {
  runApp(const AnimatedListSample());
}

class AnimatedListSample extends StatefulWidget {
  const AnimatedListSample({Key? key}) : super(key: key);

  @override
  State<AnimatedListSample> createState() => _AnimatedListSampleState();
}

class _AnimatedListSampleState extends State<AnimatedListSample> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  
  List<int> items = [0, 1, 2];
  List<Widget> listTiles = [];
  
  final Tween<Offset> _offsetIn = Tween(begin: const Offset(-1, 0), end: const Offset(0, 0)); 
  final Tween<Offset> _offsetOut = Tween(begin: const Offset(1, 0), end: const Offset(0, 0)); 
  
  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      for(int item in items) {
        Widget listTile = ListTile(
          title: Text('$item')
        );
      
        listTiles.add(listTile);
        _listKey.currentState?.insertItem(listTiles.length - 1);
      }
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Animated list'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: () {
                Widget listTile = ListTile(
                  title: Text('${listTiles.length}')
                );
      
                setState(() {
                  listTiles.add(listTile);
                  _listKey.currentState?.insertItem(listTiles.length - 1);
                });
              },
              tooltip: 'insert a new item',
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: () {
                setState(() {
                  if(listTiles.isNotEmpty) {
                    Widget listTile = listTiles[0];
                    listTiles.remove(listTile);
                    _listKey.currentState?.removeItem(0, (context, animation) {
                      return SlideTransition(
                        child: listTile,
                        position: animation.drive(_offsetOut)
                      );
                    });
                  }
                });
              },
              tooltip: 'remove the selected item',
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
//           child: ListView.builder(
//             itemCount: listTiles.length,
//             itemBuilder: (context, index) {
//               return listTiles[index];
//             }
//           ),
          child: AnimatedList(
            key: _listKey,
            initialItemCount: listTiles.length,
            itemBuilder: (context, index, animation) {
              return SlideTransition(
                child: listTiles[index],
                position: animation.drive(_offsetIn)
              );
            }
          ),
        ),
      ),
    );
  }
}

