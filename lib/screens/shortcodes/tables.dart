import 'package:clickcart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class Tables extends StatelessWidget {
  const Tables({ super.key });

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
              title: const Text('Tables'),
              titleSpacing: 5,
            ),
          ),
        )
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: IKSizes.container,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(IKSizes.radiusMd)
                  ),
                  padding: const EdgeInsets.all(15.0),
                  child: Table(
                    border: TableBorder.all(color: Theme.of(context).dividerColor),
                    columnWidths: const <int, TableColumnWidth>{
                      0: IntrinsicColumnWidth(),
                      1: IntrinsicColumnWidth(),
                      2: FlexColumnWidth(),
                    },
                    children: [
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                            child: Text('S.no.',style: Theme.of(context).textTheme.titleMedium),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                            child: Text('Name',style: Theme.of(context).textTheme.titleMedium),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                            child: Text('Email',style: Theme.of(context).textTheme.titleMedium),
                          ),
                        ]
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                            child: Text('1',style: Theme.of(context).textTheme.bodyMedium),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                            child: Text('John Doe',style: Theme.of(context).textTheme.bodyMedium),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                            child: Text('johndoe@example.com',style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ]
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                            child: Text('2',style: Theme.of(context).textTheme.bodyMedium),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                            child: Text('Richard Smith',style: Theme.of(context).textTheme.bodyMedium),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                            child: Text('richard@example.com',style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ]
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                            child: Text('3',style: Theme.of(context).textTheme.bodyMedium),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                            child: Text('David geta',style: Theme.of(context).textTheme.bodyMedium),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                            child: Text('devid@example.com',style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ]
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                            child: Text('4',style: Theme.of(context).textTheme.bodyMedium),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                            child: Text('Stive smith',style: Theme.of(context).textTheme.bodyMedium),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                            child: Text('steve@example.com',style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ]
                      ),
                    ],
                  ),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}