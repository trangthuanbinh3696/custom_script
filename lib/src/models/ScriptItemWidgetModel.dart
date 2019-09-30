import 'dart:convert';

import 'package:custom_script/src/models/OptionItem.dart';

class ScriptItemWidgetModel {
  final int id;
  final String type;
  final String question;
  final String answer;
  final List<OptionItem> options;

  ScriptItemWidgetModel({this.id, this.type, this.question, this.answer, this.options});

  ScriptItemWidgetModel copyWith({int id, String type, String question, String answer, List<OptionItem> options}) {
    return new ScriptItemWidgetModel(
        id: id ?? this.id,
        type: type ?? this.type,
        question: question ?? this.question,
        answer: answer ?? this.answer,
        options: options ?? this.options);
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$id _@_@_ $type _@_@_ $question _@_@_ $answer _@_@_ $options";
  }

  dynamic fromJson(Map<String, dynamic> json) {
    return ScriptItemWidgetModel(
      id: json['id'],
      type: json['type'],
      question: json['question'],
      answer: json['answer'],
      options: json['options'],
    );
  }

  Map toJson() {
    Map<String, dynamic> newJsonObj = {
      "id": id,
      "type": type,
      "question": question,
      "answer": answer,
      "options": options,
    };
    return newJsonObj;
  }

  String toJsonString() {
    var convertedOptionsToJson = [];
    if (options != null && options.length > 0) {
      options.forEach((optionItem) {
        convertedOptionsToJson.add(optionItem.toJsonString());
      });
    }
    var newJsonObj = {
      "id": id,
      "type": type,
      "question": question,
      "answer": answer,
      "options": convertedOptionsToJson.length > 0 ? convertedOptionsToJson : null,
    };
    String str = json.encode(newJsonObj);
    print("scripte model:" + str);
    return str;
  }
}
