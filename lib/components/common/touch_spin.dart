import 'package:flutter/material.dart';

class TouchSpin extends StatefulWidget {

  final String count;

  const TouchSpin({super.key, 
    required this.count,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TouchSpinState createState() => _TouchSpinState();
}

class _TouchSpinState extends State<TouchSpin> {

  late int countnum;

  @override
  void initState(){
    super.initState();
    countnum = int.parse(widget.count);
  }

  @override
  Widget build(BuildContext context) {
    
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if(countnum > 0){
                countnum -= 1;
              }
            });
          },
          child: const Padding(
            padding: EdgeInsets.only(bottom: 14.0),
            child: Icon(Icons.minimize,color: Color(0xFF7D899D)),
          ),
        ),
        Text('$countnum',style: Theme.of(context).textTheme.titleMedium),
        GestureDetector(
          onTap: () {
            setState(() {
              countnum += 1;
            });
          },
          child: const Icon(Icons.add,color: Color(0xFF7D899D))
        ),
      ],
    );
  }
}