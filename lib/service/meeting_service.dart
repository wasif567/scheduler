import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scheduler/models/meeting_model/meeting_response.dart';

class MeetingService {
  MeetingService() {
    fetchMeetings(date: DateTime.now());
  }

  Future<List<MeetingDate>> fetchMeetings({required DateTime date}) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://yescrm.bigleap.tech/api/meeting-calender-list?year=${date.year}&month=${date.month}',
        ),
        headers: {
          "content-type": "application/json",
          "Bearer Token": "62|ETMxY74TJrk98K055rI3k3FjGsBFJqnVlQH1MItAb6f42810",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => MeetingDate.fromJson(json["data"])).toList();
      } else {
        throw Exception('Failed to load meetings');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
