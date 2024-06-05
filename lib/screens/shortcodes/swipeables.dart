import 'package:clickcart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class Swipeables extends StatefulWidget {
  const Swipeables({ super.key });

  @override
  State<Swipeables> createState() => _SwipeablesState();
}

class _SwipeablesState extends State<Swipeables> {

  final List<String> items = List<String>.generate(20, (i) => "Item ${i + 1}");

  void _editItem(int index) {
    // Handle edit action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit ${items[index]}')),
    );
  }

  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Deleted Item ${index + 1}')),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(IKSizes.container, IKSizes.headerHeight), 
        child: Container(
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: IKSizes.container
            ),
            child: AppBar(
              title: const Text('Swipeable'),
              titleSpacing: 5,
            ),
          ),
        )
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return Dismissible(
            key: Key(item),
            background: slideLeftBackground(index),
            secondaryBackground: slideRightBackground(index),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                return false; // Prevent dismissal for edit action
              } else if (direction == DismissDirection.endToStart) {
                final bool res = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm"),
                      content: const Text("Are you sure you want to delete this item?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("Delete"),
                        ),
                      ],
                    );
                  },
                );
                return res; // Only delete if confirmed
              }
              return false;
            },
            child: ListTile(
              title: Text(item),
            ),
          );
        },
      ),
    );
    
  }
  Widget slideLeftBackground(int index) {
    return Container(
      color: Colors.green,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: () => _editItem(index),
            ),
          ],
        ),
      ),
    );
  }

  Widget slideRightBackground(int index) {
    return Container(
      color: Colors.red,
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: () async {
                final bool res = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm"),
                      content: const Text("Are you sure you want to delete this item?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("Delete"),
                        ),
                      ],
                    );
                  },
                );
                if (res) {
                  _deleteItem(index);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}