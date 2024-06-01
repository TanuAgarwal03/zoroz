import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class LanguageItem {
  String title;
  String image;

  LanguageItem({required this.title , required this.image});
}

class ChooseLanguage extends StatefulWidget {

  const ChooseLanguage({ super.key });

  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {

  String _selectedValue = "English";
  
  // ignore: non_constant_identifier_names
  List<LanguageItem> LanguageItems = [
    LanguageItem(title: "English",image: IKImages.americaFlag),
    LanguageItem(title: "Hindi",image:  IKImages.indiaFlag),
    LanguageItem(title: "French",image:  IKImages.frenchFlag),
    LanguageItem(title: "Germany",image:  IKImages.germanyFlag),
    LanguageItem(title: "Italian",image:  IKImages.italianFlag),
    LanguageItem(title: "Thai",image:  IKImages.thaiFlag),
    LanguageItem(title: "Chinese",image:  IKImages.chineseFlag),
    LanguageItem(title: "Urdu",image:  IKImages.urduFlag),
    LanguageItem(title: "Polish",image:  IKImages.polishFlag),
    LanguageItem(title: "Canadian",image:  IKImages.canadaFlag),
    LanguageItem(title: "Danish",image:  IKImages.danishFlag),
    LanguageItem(title: "Japanese",image:  IKImages.japanFlag),
    LanguageItem(title: "Dutch",image:  IKImages.dutchFlag),
    LanguageItem(title: "Turkish",image:  IKImages.turkishFlag),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(IKSizes.container, IKSizes.headerHeight), 
        child: Container(
          color: IKColors.primary,
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: IKSizes.container
            ),
            child: AppBar(
              title: const Text("Choose Your Language"),
              actions: [
                TextButton(
                  onPressed: () { 
                    Navigator.pushNamed(context, '/main_home');
                  },
                  child: Text('Skip',
                      style: Theme.of(context).textTheme.bodyLarge?.merge(const TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        )
                      )
                  ),
                )
              ],
            ),
          ),
        )
      ),
      body: Container(
        color: IKColors.primary,
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.topCenter,
        child : Container(
          constraints: const BoxConstraints(
            maxWidth: IKSizes.container,
          ),
          child: Card(
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)), // Adjust the radius as needed
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Find a language',
                    contentPadding: const EdgeInsets.all(18),
                    suffixIcon: const Icon(Icons.search,color: IKColors.primary),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).dividerColor,width: 2.0),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: IKColors.primary,width: 2.0)
                    )
                  ),
                  style: Theme.of(context).textTheme.headlineMedium?.merge(const TextStyle(fontWeight: FontWeight.w400)),
                ),
                Expanded(
                  flex: 1,
                  child : GridView.builder(
                    padding: const EdgeInsets.all(15),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: (3.8 / 1),
                    ),
                    itemCount: LanguageItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return LanguageView(
                        data: LanguageItems[index],
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value;
                          });
                        },
                      );
                    },
                  )
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child:  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () { 
                            Navigator.pushNamed(context, '/signin');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: IKColors.secondary,
                            side: const BorderSide(color: IKColors.secondary),
                            foregroundColor: IKColors.title
                          ),
                          child: const Text('Keep Going'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LanguageView extends StatelessWidget {

  final LanguageItem data;
  final String groupValue;
  final Function onChanged;

  const LanguageView({super.key,  required this.data , required this.groupValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ onChanged(data.title); },
      child : Container(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
        decoration: BoxDecoration(
          border:  Border.all(color: groupValue == data.title ? IKColors.primary : Theme.of(context).dividerColor, width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image.asset(data.image,width: 28,height: 20,fit: BoxFit.cover,),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(data.title,style: Theme.of(context).textTheme.titleLarge?.merge(const TextStyle(fontWeight: FontWeight.w400))),
            ),
            Icon(Icons.check_circle,color: groupValue == data.title ? IKColors.primary : Theme.of(context).dividerColor),
          ],
        ),
      ),
    );
  }
}
