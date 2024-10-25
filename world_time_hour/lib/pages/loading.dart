import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void getTime() async {
  try {
    Dio dio = Dio();

    // Make the API request
    Response response = await dio.get(
      'http://worldtimeapi.org/api/timezone/Europe/London',
      options: Options(
        validateStatus: (status) {
          // Accept 200-399 as valid, while 502 is handled gracefully
          return status! < 500;
        },
      ),
    );

    // If the response is successful (200-399)
    if (response.statusCode != null && response.statusCode! < 400) {
      Map data = response.data;

      String dateTime = data['datetime'];
      String offset = data['utc_offset'];

      DateTime now = DateTime.parse(dateTime); 

      String offsetSign = offset.substring(0, 1); 
      int offsetHours = int.parse(offset.substring(1, 3)); 
      int offsetMinutes = int.parse(offset.substring(4, 6)); 

      Duration offsetDuration = Duration(
        hours: offsetHours,
        minutes: offsetMinutes,
      );

      if (offsetSign == '+') {
        now = now.add(offsetDuration);
      } else {
        now = now.subtract(offsetDuration);
      }

      print('Adjusted time: $now');
    } else {
      print('Error: Received a ${response.statusCode} status code');
    }
    
  } catch (e) {
    // Handle other exceptions such as connection issues
    print('Error: $e');
  }
}

   @override
  void initState() {
    super.initState();
    getTime(); // Call the getTime function when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading...'),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
