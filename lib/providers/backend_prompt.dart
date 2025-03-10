import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graduation_project/models/peripheral_model.dart';
import 'package:graduation_project/services/mqtt_service_with_aws.dart';
import 'package:http/http.dart' as http;

class BackendService extends ChangeNotifier {
  Future<dynamic> sendPeripheralData(List<Peripheral> peripherals,
      String request, String result, String resultDataType) async {
    MqttService mqttService = MqttService();
    const String url =
        'http://ec2-3-147-6-28.us-east-2.compute.amazonaws.com:8080/config';
    final Map<String, dynamic> data = {
      'Peripherals':
          peripherals.map((peripheral) => peripheral.toMap()).toList(),
      'Request': request,
      'Result': result,
      'Result_Datatype': resultDataType,
    };

    final String json = jsonEncode(data);
    print('JSON Payload: $json');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json,
      );

      if (response.statusCode == 200) {
        await mqttService.waitForConnection();

        try {
          await mqttService.publishMessageOnSuccess(
              'esp32/sub', '{"type":"update"}');
          print("MQTT message sent successfully.");
          return true;
        } catch (e) {
          print("Error sending MQTT message: $e");
          return false;
        }
      } else {
        print('Failed to send data');
        return false;
      }
    } catch (e) {
      print('Error sending data: $e');
      return false;
    }
  }
}
