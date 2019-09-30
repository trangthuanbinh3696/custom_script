import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:convert';

import 'src/model/OptionItem.dart';
import 'src/model/ScriptItemWidgetModel.dart';
import 'src/constants/constants.dart';
import 'src/ScriptItemWrapper.dart';

enum WidgetType { TEXT, TEXT_INPUT, RADIO_BUTTON, CHECK_BOX }

class CustomScriptWidget extends StatefulWidget {
  final bool isCustomizable;
  final bool isEnterprise;
  final ScrollPhysics scrollPhysics;
  final String content;
  final Function onPressSave;

  CustomScriptWidget({
    Key key,
    @required this.isCustomizable = false,
    @required this.isEnterprise = false,
    this.scrollPhysics = const NeverScrollableScrollPhysics(),
    this.content = '{"text": [], "textInput": [], "checkBox": [], "radioButton": []}',
    this.onPressSave = null,
  }) : super(key: key);

  _CustomScriptWidgetState createState() => _CustomScriptWidgetState();
}

class _CustomScriptWidgetState extends State<CustomScriptWidget> {
  List<ScriptItemWidgetModel> _dataText;
  List<ScriptItemWidgetModel> _dataTextInput;
  List<ScriptItemWidgetModel> _dataRadioButton;
  List<ScriptItemWidgetModel> _dataCheckBox;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _dataText = [];
    _dataTextInput = [];
    _dataRadioButton = [];
    _dataCheckBox = [];
    if (widget.content != null && widget.content != "") {
      var inputJsonObj = jsonDecode(widget.content);
      if (inputJsonObj != null && inputJsonObj["text"] != null && inputJsonObj["text"].length > 0) {
        inputJsonObj["text"].forEach((item) {
          ScriptItemWidgetModel temp = ScriptItemWidgetModel(
              id: item['id'], type: item['type'], question: item['question'], answer: item['answer'], options: []);
          if (item['options'] != null && item['options'].length > 0) {
            List<OptionItem> listOpt = [];
            item['options'].forEach((itemOptionJson) {
              OptionItem optionItem = OptionItem().fromJson(itemOptionJson);
              listOpt.add(optionItem);
            });
            temp = temp.copyWith(options: listOpt);
          }
          _dataText.add(temp);
        });
      }
      if (inputJsonObj != null && inputJsonObj["textInput"] != null && inputJsonObj["textInput"].length > 0) {
        inputJsonObj["textInput"].forEach((item) {
          ScriptItemWidgetModel temp = ScriptItemWidgetModel(
              id: item['id'], type: item['type'], question: item['question'], answer: item['answer'], options: []);
          if (item['options'] != null && item['options'].length > 0) {
            List<OptionItem> listOpt = [];
            item['options'].forEach((itemOptionJson) {
              OptionItem optionItem = OptionItem().fromJson(itemOptionJson);
              listOpt.add(optionItem);
            });
            temp = temp.copyWith(options: listOpt);
          }
          _dataTextInput.add(temp);
        });
      }
      if (inputJsonObj != null && inputJsonObj["checkBox"] != null && inputJsonObj["checkBox"].length > 0) {
        inputJsonObj["checkBox"].forEach((item) {
          ScriptItemWidgetModel temp = ScriptItemWidgetModel(
              id: item['id'], type: item['type'], question: item['question'], answer: item['answer'], options: []);
          if (item['options'] != null && item['options'].length > 0) {
            List<OptionItem> listOpt = [];
            item['options'].forEach((itemOptionJson) {
              OptionItem optionItem = OptionItem().fromJson(itemOptionJson);
              listOpt.add(optionItem);
            });
            temp = temp.copyWith(options: listOpt);
          }
          _dataCheckBox.add(temp);
        });
      }
      if (inputJsonObj != null && inputJsonObj["radioButton"] != null && inputJsonObj["radioButton"].length > 0) {
        inputJsonObj["radioButton"].forEach((item) {
          ScriptItemWidgetModel temp = ScriptItemWidgetModel(
              id: item['id'], type: item['type'], question: item['question'], answer: item['answer'], options: []);
          if (item['options'] != null && item['options'].length > 0) {
            List<OptionItem> listOpt = [];
            item['options'].forEach((itemOptionJson) {
              OptionItem optionItem = OptionItem().fromJson(itemOptionJson);
              listOpt.add(optionItem);
            });
            temp = temp.copyWith(options: listOpt);
          }
          _dataRadioButton.add(temp);
        });
      }
    }
  }

  InputBorder _getInputBorder() {
    return widget.isCustomizable == true
        ? UnderlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: ptPrimaryColor(context)))
        : InputBorder.none;
  }

  bool _isAllowCustomizable() {
    return widget.isCustomizable ?? false;
  }

  bool _isEnterprise() {
    return widget.isEnterprise ?? false;
  }

  void _onPressRemoveButton(ScriptItemWidgetModel item, type) {
    List<ScriptItemWidgetModel> totalList = [];
    totalList.addAll(_dataText);
    totalList.addAll(_dataTextInput);
    totalList.addAll(_dataCheckBox);
    totalList.addAll(_dataRadioButton);
    int deletedItemId = item.id;

    totalList = totalList.where((e) => e.id != item.id).toList();
    List<ScriptItemWidgetModel> finalList = totalList.map((e) {
      if (e.id > deletedItemId) {
        ScriptItemWidgetModel itemWithNewIndex = e.copyWith(id: e.id - 1);
        return itemWithNewIndex;
      }
      return e;
    }).toList();

    setState(() {
      _dataText = finalList.where((e) => e.type == 'TEXT').toList();
      _dataTextInput = finalList.where((e) => e.type == 'TEXT_FIELD').toList();
      _dataCheckBox = finalList.where((e) => e.type == 'CHECK_BOX').toList();
      _dataRadioButton = finalList.where((e) => e.type == 'RADIO_BUTTON').toList();
    });
  }

  TextStyle getHintStyle() {
    return Theme.of(context).textTheme.body1;
  }

  TextStyle getTextStyle() {
    return Theme.of(context).textTheme.body1;
  }

  //TextField for Text
  Widget _createNewText(ScriptItemWidgetModel item, type) {
    return ScriptItemWrapper(
      isCustomizable: widget.isCustomizable,
      child: _createTextItem(item, type),
      onCallBack: () {
        this._onPressRemoveButton(item, type);
      },
    );
  }

  Widget _createTextItem(ScriptItemWidgetModel item, type) {
    return !widget.isCustomizable
        ? Text(
            item.question,
          )
        : TextField(
            enabled: _isAllowCustomizable() && _isEnterprise(),
            decoration: InputDecoration(
              hintText: item.question != null && item.question != '' ? item.question : 'Nhập nội dung',
              border: _getInputBorder(),
              hintStyle: getHintStyle(),
            ),
            style: getTextStyle(),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            // readOnly: true,
            onChanged: (String value) {
              setState(() {
                if (type == WidgetType.TEXT) {
                  _dataText = _dataText.map((ScriptItemWidgetModel scriptItem) {
                    if (item.id == scriptItem.id) {
                      return item.copyWith(question: value);
                    }
                    return scriptItem;
                  }).toList();
                } else if (type == WidgetType.TEXT_INPUT) {
                  _dataTextInput = _dataTextInput.map((ScriptItemWidgetModel scriptItem) {
                    if (item.id == scriptItem.id) {
                      return item.copyWith(question: value);
                    }
                    return scriptItem;
                  }).toList();
                } else if (type == WidgetType.CHECK_BOX) {
                  _dataCheckBox = _dataCheckBox.map((ScriptItemWidgetModel scriptItem) {
                    if (item.id == scriptItem.id) {
                      return item.copyWith(question: value);
                    }
                    return scriptItem;
                  }).toList();
                } else {
                  _dataRadioButton = _dataRadioButton.map((ScriptItemWidgetModel scriptItem) {
                    if (item.id == scriptItem.id) {
                      return item.copyWith(question: value);
                    }
                    return scriptItem;
                  }).toList();
                }
              });
            },
          );
  }

  Widget _createNewCheckBoxList(ScriptItemWidgetModel item, type) {
    //get list Option of current item:
    var listOptions = item.options;
    return ScriptItemWrapper(
      isCustomizable: widget.isCustomizable,
      onCallBack: () {
        this._onPressRemoveButton(item, type);
      },
      child: Column(
        children: <Widget>[
          _createTextItem(item, type),
          ListView.builder(
            physics: new NeverScrollableScrollPhysics(),
            itemCount: listOptions.length ?? 0,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              //get current option:
              var currentOptionItem = listOptions.elementAt(index);

              return CheckboxListTile(
                value: item.answer.split(",").contains(currentOptionItem.key.toString()) ? true : false,
                onChanged: _isAllowCustomizable() && !widget.isEnterprise
                    ? (bool value) {
                        setState(() {
                          _dataCheckBox = _dataCheckBox.map((ScriptItemWidgetModel scriptItem) {
                            if (item.id == scriptItem.id) {
                              //current item:
                              var temp = item.answer.split(",");
                              // index indez cua options
                              if (value == true) {
                                if (temp.contains(currentOptionItem.key.toString())) {
                                  temp = temp.where((item2) => item2 != item.options.elementAt(index).key.toString()).toList();
                                } else {
                                  temp.add("${currentOptionItem.key}");
                                }
                              } else {
                                if (temp.contains(currentOptionItem.key.toString())) {
                                  temp = temp.where((item2) => item2 != item.options.elementAt(index).key.toString()).toList();
                                }
                              }
                              var newAnswer = "";
                              temp.forEach((item) {
                                if (newAnswer == "") {
                                  newAnswer += "$item";
                                } else {
                                  newAnswer += ",$item";
                                }
                              });
                              return item.copyWith(answer: newAnswer);
                            } else {
                              return scriptItem;
                            }
                          }).toList();
                        });
                      }
                    : null,
                title: TextField(
                  enabled: _isAllowCustomizable() && _isEnterprise(),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText:
                        currentOptionItem != null && currentOptionItem.value != '' ? currentOptionItem.value : 'Nhập nội dung',
                    border: _getInputBorder(),
                    hintStyle: getHintStyle(),
                  ),
                  style: getTextStyle(),
                  onChanged: (String textFieldTextValue) {
                    setState(() {
                      _dataCheckBox = _dataCheckBox.map((ScriptItemWidgetModel scriptItem) {
                        if (item.id == scriptItem.id) {
                          List<OptionItem> temp = item.options.map((optionItem) {
                            if (currentOptionItem.key == optionItem.key) {
                              return optionItem.copyWith(value: textFieldTextValue);
                            }
                            return optionItem;
                          }).toList();
                          return item.copyWith(options: temp);
                        }
                        return scriptItem;
                      }).toList();
                    });
                  },
                ),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: ptPrimaryColor(context),
              );
            },
          ),
          _isAllowCustomizable() && _isEnterprise()
              ? ListTile(
                  leading: Icon(Icons.add),
                  title: Text(
                    'Thêm lựa chọn mới',
                    style: getTextStyle(),
                  ),
                  onTap: () {
                    setState(() {
                      _dataCheckBox = _dataCheckBox.map((ScriptItemWidgetModel scriptItem) {
                        if (item.id == scriptItem.id) {
                          List<OptionItem> newOptions = item.options.map((OptionItem optionItem) {
                            return optionItem;
                          }).toList();
                          newOptions.add(new OptionItem(key: "${item.id}_${(item.options.length + 1)}", value: ""));
                          return item.copyWith(options: newOptions);
                        }
                        return scriptItem;
                      }).toList();
                    });
                  },
                )
              : Container()
        ],
      ),
    );
  }

  Widget _createNewRadioButtonList(ScriptItemWidgetModel item, type) {
    //get list Option of current item:
    var listOptions = item.options;
    return ScriptItemWrapper(
      isCustomizable: widget.isCustomizable,
      onCallBack: () {
        this._onPressRemoveButton(item, type);
      },
      child: Column(
        children: <Widget>[
          _createTextItem(item, type),
          ListView.builder(
            physics: new NeverScrollableScrollPhysics(),
            itemCount: listOptions.length ?? 0,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              //get current option:
              var currentOptionItem = listOptions.elementAt(index);
              item.options.firstWhere((optionItem) => optionItem.key.toString() == item.answer, orElse: () => null);
              OptionItem foundSelectedItem =
                  item.options.firstWhere((optionItem) => optionItem.key.toString() == item.answer, orElse: () => null);
              return RadioListTile(
                value: currentOptionItem.value,
                groupValue: foundSelectedItem != null ? foundSelectedItem.value : "",
                onChanged: _isAllowCustomizable() && !widget.isEnterprise
                    ? (String value) {
                        print("selected: $value");
                        setState(() {
                          _dataRadioButton = _dataRadioButton.map((ScriptItemWidgetModel scriptItem) {
                            if (item.id == scriptItem.id) {
                              return item.copyWith(answer: currentOptionItem.key.toString());
                            } else {
                              return scriptItem;
                            }
                          }).toList();
                        });
                      }
                    : null,
                title: TextField(
                  enabled: _isAllowCustomizable() && _isEnterprise(),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText:
                        currentOptionItem != null && currentOptionItem.value != '' ? currentOptionItem.value : 'Nhập nội dung',
                    border: _getInputBorder(),
                    hintStyle: getHintStyle(),
                  ),
                  onChanged: (String textFieldTextValue) {
                    setState(() {
                      _dataRadioButton = _dataRadioButton.map((ScriptItemWidgetModel scriptItem) {
                        if (item.id == scriptItem.id) {
                          List<OptionItem> temp = item.options.map((optionItem) {
                            if (currentOptionItem.key == optionItem.key) {
                              return optionItem.copyWith(value: textFieldTextValue);
                            }
                            return optionItem;
                          }).toList();
                          return item.copyWith(options: temp);
                        }
                        return scriptItem;
                      }).toList();
                    });
                  },
                  style: getTextStyle(),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: ptPrimaryColor(context),
              );
            },
          ),
          _isAllowCustomizable() && _isEnterprise()
              ? ListTile(
                  leading: Icon(Icons.add),
                  title: Text(
                    'Thêm lựa chọn mới',
                    style: getTextStyle(),
                  ),
                  onTap: () {
                    setState(() {
                      _dataRadioButton = _dataRadioButton.map((ScriptItemWidgetModel scriptItem) {
                        if (item.id == scriptItem.id) {
                          List<OptionItem> newOptions = item.options.map((OptionItem optionItem) {
                            return optionItem;
                          }).toList();
                          newOptions.add(new OptionItem(key: "${item.id}_${(item.options.length + 1)}", value: ""));
                          return item.copyWith(options: newOptions);
                        }
                        return scriptItem;
                      }).toList();
                    });
                  },
                )
              : Container()
        ],
      ),
    );
  }

  Widget _createTextField(ScriptItemWidgetModel item, type) {
    return ScriptItemWrapper(
        isCustomizable: widget.isCustomizable,
        onCallBack: () {
          this._onPressRemoveButton(item, type);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _createTextItem(item, type),
            TextField(
              enabled: _isAllowCustomizable() && !widget.isEnterprise,
              // enabled: _isAllowCustomizable() && _isEnterprise(),
              decoration: InputDecoration(
                // border: InputBorder.none,
                hintText: item.answer != null && item.answer != ''
                    ? item.answer
                    : widget.isEnterprise ? '(Telesale sẽ nhập câu trả lời ở đây)' : 'Nhập câu trả lời',
                hintStyle: getHintStyle(),
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              onChanged: (String value) {
                setState(() {
                  _dataTextInput = _dataTextInput.map((ScriptItemWidgetModel scriptItem) {
                    if (item.id == scriptItem.id) {
                      return item.copyWith(answer: value);
                    } else {
                      return scriptItem;
                    }
                  }).toList();
                });
              },
              style: getTextStyle(),
            ),
          ],
        ));
  }

  Widget _createRandomNumber() {
    return Text('Random ${Random().nextInt(100)}');
  }

  Widget _popupCreateNewScriptButton() {
    return PopupMenuButton(
      child: ListTile(
        leading: Icon(Icons.add),
        title: Text(
          'Thêm kịch bản mới',
          style: Theme.of(context).textTheme.subtitle,
        ),
      ),
      onSelected: (choice) {
        int nextIndex = _dataText.length + _dataTextInput.length + _dataCheckBox.length + _dataRadioButton.length;
        if (choice == 'Text') {
          setState(() {
            _dataText.add(new ScriptItemWidgetModel(id: nextIndex + 1, type: 'TEXT', question: '', answer: ''));
          });
        } else if (choice == 'CheckBox') {
          setState(() {
            _dataCheckBox.add(new ScriptItemWidgetModel(
                id: nextIndex + 1, type: 'CHECK_BOX', question: '', options: new List<OptionItem>(), answer: ''));
          });
        } else if (choice == 'RadioButton') {
          setState(() {
            _dataRadioButton.add(new ScriptItemWidgetModel(
                id: nextIndex + 1, type: 'RADIO_BUTTON', question: '', options: new List<OptionItem>(), answer: ''));
          });
        } else if (choice == 'TextField') {
          setState(() {
            _dataTextInput.add(new ScriptItemWidgetModel(
                id: nextIndex + 1, type: 'TEXT_FIELD', question: '', options: new List<OptionItem>(), answer: ''));
          });
        }
      },
      // icon: Icon(Icons.edit),
      itemBuilder: (BuildContext context) {
        return <String>['Text', 'TextField', 'CheckBox', 'RadioButton'].map((String choice) {
          return PopupMenuItem(
            child: Text(
              choice,
              style: Theme.of(context).textTheme.subtitle,
            ),
            value: choice,
          );
        }).toList();
      },
    );
  }

  Widget _onCreateButton(String title, Color color, Color txtColor, Function onPress) {
    return RaisedButton(
      color: color,
      child: Text(title, style: Theme.of(context).textTheme.body1.copyWith(color: txtColor)),
      onPressed: onPress,
    );
  }

  _onSavePress() {
    print("chay 1");
    if (widget.onPressSave != null) {
      print("chay 2");
      var convertedDataTextToJson = [];
      var convertedDataTextInputToJson = [];
      var convertedDataCheckBoxToJson = [];
      var convertedDataRadioButtonToJson = [];
      _dataText.forEach((item) {
        convertedDataTextToJson.add(item.toJson());
      });
      _dataTextInput.forEach((item) {
        convertedDataTextInputToJson.add(item.toJson());
      });
      _dataCheckBox.forEach((item) {
        convertedDataCheckBoxToJson.add(item.toJson());
      });
      _dataRadioButton.forEach((item) {
        convertedDataRadioButtonToJson.add(item.toJson());
      });

      Map<String, dynamic> outputData = {
        "text": convertedDataTextToJson,
        "textInput": convertedDataTextInputToJson,
        "checkBox": convertedDataCheckBoxToJson,
        "radioButton": convertedDataRadioButtonToJson
      };
      String str = json.encode(outputData);
      print("SAVE sre" + str);
      widget.onPressSave(str);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("_dataText ne: $_dataText");
    print("_dataTextInput ne: $_dataTextInput");
    print("_dataCheckBox ne: $_dataCheckBox");
    print("_dataRadioButton ne: $_dataRadioButton");
    return Container(
      child: ListView(
        physics: widget.scrollPhysics,
        shrinkWrap: true,
        children: <Widget>[
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _dataText.length + _dataTextInput.length + _dataCheckBox.length + _dataRadioButton.length,
            itemBuilder: (BuildContext context, int index) {
              var foundText = _dataText.firstWhere((item) => (item.id == index + 1), orElse: () => null);
              if (foundText != null) {
                return (_createNewText(foundText, WidgetType.TEXT));
              }
              var foundTextInput = _dataTextInput.firstWhere((item) => (item.id == index + 1), orElse: () => null);
              if (foundTextInput != null) {
                return (_createTextField(foundTextInput, WidgetType.TEXT_INPUT));
              }
              var foundCheckBox = _dataCheckBox.firstWhere((item) => (item.id == index + 1), orElse: () => null);
              if (foundCheckBox != null) {
                return (_createNewCheckBoxList(foundCheckBox, WidgetType.CHECK_BOX));
              }
              var foundRadioButton = _dataRadioButton.firstWhere((item) => (item.id == index + 1), orElse: () => null);
              if (foundRadioButton != null) {
                return (_createNewRadioButtonList(foundRadioButton, WidgetType.RADIO_BUTTON));
              }
              return Container();
            },
          ),
          _isAllowCustomizable() && _isEnterprise() ? _popupCreateNewScriptButton() : Container(),
          _isAllowCustomizable() && _isEnterprise()
              ? Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _onCreateButton('Lưu kịch bản', Theme.of(context).primaryColor, Colors.white, _onSavePress),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
