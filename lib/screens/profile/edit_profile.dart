import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditProfile extends StatelessWidget {

  const EditProfile({ super.key });

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
              title: const Text('Edit Profile'),
              titleSpacing: 5,
            ),
          ),
        )
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: IKSizes.container
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        color: Theme.of(context).cardColor,
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2,color: IKColors.primary),
                                      borderRadius: BorderRadius.circular(48)
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(42),
                                      child: Image.asset(IKImages.profile,height: 84,width: 84),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: IKColors.primary,
                                      border: Border.all(width: 3,color: Theme.of(context).cardColor),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignment: Alignment.center,
                                    child: SvgPicture.string(
                                      IKSvg.edit,
                                      width: 16,
                                      height: 16,
                                    ),
                                  )
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text('James Smith',style:Theme.of(context).textTheme.titleLarge?.merge(const TextStyle(fontSize: 24))),
                                  const SizedBox(height: 4),
                                  Text('Last Visit : 17 Jan 2024',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.primary)))
                                ],
                              )
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        color: Theme.of(context).cardColor,
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: const UnderlineInputBorder(),
                                  labelText: 'Your Name',
                                  labelStyle: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontSize: 15)),
                                  floatingLabelStyle: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.primary)), 
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2,color: Theme.of(context).dividerColor)),
                                  focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2,color: IKColors.primary)),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                ),
                                cursorColor: IKColors.primary,
                                style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: const UnderlineInputBorder(),
                                  labelText: 'Mobile Number',
                                  labelStyle: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontSize: 15)),
                                  floatingLabelStyle: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.primary)), 
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2,color: Theme.of(context).dividerColor)),
                                  focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2,color: IKColors.primary)),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                ),
                                keyboardType: TextInputType.phone,
                                cursorColor: IKColors.primary,
                                style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: const UnderlineInputBorder(),
                                  labelText: 'Email',
                                  labelStyle: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontSize: 15)),
                                  floatingLabelStyle: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.primary)), 
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2,color: Theme.of(context).dividerColor)),
                                  focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2,color: IKColors.primary)),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                ),
                                cursorColor: IKColors.primary,
                                style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: const UnderlineInputBorder(),
                                  labelText: 'Location',
                                  labelStyle: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontSize: 15)),
                                  floatingLabelStyle: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.primary)), 
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2,color: Theme.of(context).dividerColor)),
                                  focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2,color: IKColors.primary)),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                ),
                                cursorColor: IKColors.primary,
                                style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color),
                              ),
                            ),
                          ],
          
                        ),
                      )
                    ],
                  ),
                )
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: IKColors.secondary,
                    side: const BorderSide(color: IKColors.secondary),
                    foregroundColor: IKColors.title
                  ),
                  child: const Text('Update Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}