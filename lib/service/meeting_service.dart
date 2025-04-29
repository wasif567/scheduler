import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scheduler/models/meeting_model/meeting_response.dart';

class MeetingService {
  Future<MeetingResponse> fetchMeetings({required DateTime date}) async {
    try {
      final response = await http
          .get(
            Uri.parse(
              'https://yescrm.bigleap.tech/api/meeting-calender-list?year=${date.year}&month=${date.month}',
            ),
            headers: {
              "content-type": "application/json",
              "Authorization": "Bearer 62|ETMxY74TJrk98K055rI3k3FjGsBFJqnVlQH1MItAb6f42810",
            },
          )
          .timeout(const Duration(minutes: 2));

      if (response.statusCode == 200) {
        final decode = json.decode(response.body);
        return MeetingResponse.fromJson(decode);
      } else {
        throw Exception('Failed to load meetings');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
