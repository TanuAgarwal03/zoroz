import 'package:clickcart/components/bottomsheet/login_sheet.dart';
import 'package:clickcart/components/bottomsheet/register_sheet.dart';
import 'package:clickcart/components/bottomsheet/success_sheet.dart';
import 'package:clickcart/components/list/list_item.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class Bottomsheet extends StatelessWidget {
  const Bottomsheet({ super.key });

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
              title: const Text('Bottom Sheets'),
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
              children: [
                ListItem(
                  onTap: (){
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return const SuccessSheet();
                      },
                    );
                  },
                  icon: const Icon(Icons.check_circle_outline_rounded,color: IKColors.primary, size: 20,),
                  title: "Success Sheet",
                ),
                ListItem(
                  onTap: (){
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return const LoginSheet();
                      },
                    );
                  },
                  icon: const Icon(Icons.login,color: IKColors.primary, size: 20,),
                  title: "Login Sheet",
                ),
                ListItem(
                  onTap: (){
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return const RegisterSheet();
                      },
                    );
                  },
                  icon: const Icon(Icons.app_registration_rounded,color: IKColors.primary, size: 20,),
                  title: "Register Sheet",
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}