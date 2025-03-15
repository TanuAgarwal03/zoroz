// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';

// class PrivacyPolicy extends StatefulWidget {
//    const PrivacyPolicy({super.key});

//   @override
//   State<PrivacyPolicy> createState() => _PrivacyPolicyState();
// }

// class _PrivacyPolicyState extends State<PrivacyPolicy> {
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       body: Column(
//         children: [
//           Text('hsdgjsdskdjsd')
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:loading_indicator/loading_indicator.dart';
class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  String title = '';
  String description = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPrivacyPolicy();
  }

  Future<void> fetchPrivacyPolicy() async {
    try {
      final url = Uri.parse(
          'https://backend.vansedemo.xyz/api/setting/store/customization/all');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        // print('Decoded response: $decodedResponse');

        final Map<String, dynamic> data =
            decodedResponse is List ? decodedResponse[0] : decodedResponse;

        if (data.containsKey('privacy_policy')) {
          final privacyPolicy = data['privacy_policy'];

          setState(() {
            title = privacyPolicy['title']['en'] ?? 'Privacy Policy';
            description = privacyPolicy['description']['en'] ?? '';
            isLoading = false;
          });
        } else {
          print('Privacy policy data missing in response.');
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching privacy policy: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title.isEmpty ? 'Privacy Policy' : title),
        backgroundColor: IKColors.primary,
      ),
      body: isLoading
          ? const Center(child: SizedBox(width: 25,child: LoadingIndicator(indicatorType: Indicator.lineScalePulseOut)))
          : description.isEmpty
              ? const Center(child: Text('No privacy policy found.'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Html(
                    data: description,
                    style: {
                      "body": Style(
                        fontSize: FontSize(14.0),
                        color: Colors.black87,
                      ),
                      "p": Style(
                        // margin: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      "strong": Style(
                        fontWeight: FontWeight.bold,
                      ),
                    },
                  ),
                ),
    );
  }
}
