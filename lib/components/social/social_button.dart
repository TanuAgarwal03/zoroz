import 'package:clickcart/utils/constants/sizes.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  final String type;
  final Function() onTap;

  const SocialButton({ super.key , required this.type, required this.onTap});

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 25,right: 25,top: 12,bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(IKSizes.radiusMd),
          color: type == 'facebook' ? const Color(0xFF3f6eeb) : 
          type == 'twitter' ? const Color.fromARGB(255, 0, 0, 0) : 
          type == 'pinterest' ? const Color(0xFFd51a2b) : 
          type == 'instagram' ? Theme.of(context).dividerColor.withOpacity(.5) : 
          type == 'google' ? Theme.of(context).dividerColor.withOpacity(.5) :Colors.black
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: Text(
                type == 'facebook' ? 'Facebook' :
                type == 'twitter' ? 'Twitter' :
                type == 'pinterest' ? 'Pinterest' :
                type == 'instagram' ? 'Instagram' :
                type == 'google' ? 'Google' : ''
                ,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: (type == 'google' || type == 'instagram') ? Theme.of(context).textTheme.titleMedium?.color : Colors.white
                ),
              ),
            ),
            Positioned(
              left: 0,
              child: SvgPicture.string(
                type == 'facebook' ? IKSvg.facebook :
                type == 'twitter' ? IKSvg.twitter :
                type == 'pinterest' ? IKSvg.pinterest :
                type == 'instagram' ? IKSvg.instagram :
                type == 'google' ? IKSvg.google : ''
                ,
                height: 20,
                width: 20,
                // ignore: deprecated_member_use
                color: (type == 'instagram' || type == 'google') ? null : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}