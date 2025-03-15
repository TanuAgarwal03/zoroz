
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:loading_indicator/loading_indicator.dart';
class TermsConditions extends StatefulWidget {
  const TermsConditions({super.key});

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  String title = '';
  String description = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTermsConditions();
  }

  Future<void> fetchTermsConditions() async {
    try {
      final url = Uri.parse(
          'https://backend.vansedemo.xyz/api/setting/store/customization/all');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        // print('Decoded response: $decodedResponse');

        final Map<String, dynamic> data =
            decodedResponse is List ? decodedResponse[0] : decodedResponse;

        if (data.containsKey('term_and_condition')) {
          final termsconditions = data['term_and_condition'];

          setState(() {
            title = termsconditions['title']['en'] ?? 'Terms & Conditions';
            description = termsconditions['description']['en'] ?? '';
            isLoading = false;
          });
        } else {
          print('Terms & conditions data missing in response.');
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
      print('Error fetching terms & conditions: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title.isEmpty ? 'Terms & Conditions' : title),
        backgroundColor: IKColors.primary,
      ),
      body: isLoading
          ? const Center(child: SizedBox(width: 25,child: LoadingIndicator(indicatorType: Indicator.lineScalePulseOut)))
          : description.isEmpty
              ? const Center(child: Text('No terms & conditions found.'))
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
