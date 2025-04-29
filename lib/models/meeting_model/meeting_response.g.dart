// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingResponse _$MeetingResponseFromJson(Map<String, dynamic> json) =>
    MeetingResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data:
          json['data'] != null
              ? (json['data'] as List<dynamic>)
                  .map((e) => MeetingDate.fromJson(e as Map<String, dynamic>))
                  .toList()
              : [],
    );

Map<String, dynamic> _$MeetingResponseToJson(MeetingResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

MeetingDate _$MeetingDateFromJson(Map<String, dynamic> json) => MeetingDate(
  date: json['date'] as String,
  items:
      (json['items'] as List<dynamic>)
          .map((e) => MeetingItem.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$MeetingDateToJson(MeetingDate instance) =>
    <String, dynamic>{'date': instance.date, 'items': instance.items};
