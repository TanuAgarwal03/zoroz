import 'package:clickcart/components/list/list_item.dart';
import 'package:clickcart/components/modal/confirm_modal.dart';
import 'package:clickcart/components/modal/login_modal.dart';
import 'package:clickcart/components/modal/register_modal.dart';
import 'package:clickcart/components/modal/success_modal.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ModalBox extends StatelessWidget {
  const ModalBox({ super.key });

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
              title: const Text('Modal Box'),
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
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return const ConfirmModal();
                      },
                    );
                  },
                  icon: const Icon(Icons.info_outline_rounded,color: IKColors.primary, size: 20,),
                  title: "Confirm Modal",
                ),
                ListItem(
                  onTap: (){
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return const SuccessModal();
                      },
                    );
                  },
                  icon: const Icon(Icons.check_circle_outline_rounded,color: IKColors.primary, size: 20,),
                  title: "Success Modal",
                ),
                ListItem(
                  onTap: (){
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return const LoginModal();
                      },
                    );
                  },
                  icon: const Icon(Icons.login,color: IKColors.primary, size: 20,),
                  title: "Login Modal",
                ),
                ListItem(
                  onTap: (){
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return const RegisterModal();
                      },
                    );
                  },
                  icon: const Icon(Icons.app_registration_rounded,color: IKColors.primary, size: 20,),
                  title: "Register Modal",
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}