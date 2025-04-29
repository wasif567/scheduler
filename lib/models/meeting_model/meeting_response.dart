import 'package:json_annotation/json_annotation.dart';
import '../meeting_item/meeting_item.dart';

part 'meeting_response.g.dart';

@JsonSerializable()
class MeetingResponse {
  int status;
  String message;
  List<MeetingDate> data;

  MeetingResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MeetingResponse.fromJson(Map<String, dynamic> json) =>
      _$MeetingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MeetingResponseToJson(this);
}

@JsonSerializable()
class MeetingDate {
  String date;
  List<MeetingItem> items;

  MeetingDate({required this.date, required this.items});

  factory MeetingDate.fromJson(Map<String, dynamic> json) =>
      _$MeetingDateFromJson(json);

  Map<String, dynamic> toJson() => _$MeetingDateToJson(this);
}
