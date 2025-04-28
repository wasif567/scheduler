// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingItem _$MeetingItemFromJson(Map<String, dynamic> json) => MeetingItem(
  id: json['id'] as String,
  title: json['title'] as String,
  meetingTime: json['time'] as String,
  conflicted: json['conflicted'] as bool,
);

Map<String, dynamic> _$MeetingItemToJson(MeetingItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'time': instance.meetingTime,
      'conflicted': instance.conflicted,
    };
