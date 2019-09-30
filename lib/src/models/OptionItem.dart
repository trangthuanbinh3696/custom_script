//model for options in ScriptItemModel
import 'dart:convert';

class OptionItem {
  final String key;
  final String value;

  OptionItem({this.key, this.value});

  OptionItem copyWith({
    int key,
    String value,
  }) {
    return new OptionItem(key: key ?? this.key, value: value ?? this.value);
  }

  @override
  String toString() {
    // TODO: implement toString
    return "key: $key - value: $value";
  }

  dynamic fromJson(Map<String, dynamic> json) {
    return OptionItem(key: json['key'], value: json['value']);
  }

  Map toJson() {
    Map<String, dynamic> newJsonObj = {
      "key": key,
      "value": value,
    };
    return newJsonObj;
  }

  String toJsonString() {
    // Map<String, dynamic> newJsonObj = {
    //   "key": key,
    //   "value": value,
    // };
    // return newJsonObj;
    var newJsonObj = {
      "id": "ewe",
      "value": value,
    };
    String str = json.encode(newJsonObj);
    print(str);
    return str;
  }
}
