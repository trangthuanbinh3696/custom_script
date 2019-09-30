import 'package:flutter/material.dart';

///AppColor
const String appColor = "#FE0000";
const String appColorOrange = "#FF7300";
const String appShadowColor = "#00000030";
const String appBorderColor = "#00000005";
const String appText = "#1D2226";
const String appText60 = "#1D222660";
const String appWhite = "#FFFFFF";
const String appLine = "#EBEBEB";

Color ptPrimaryColor(BuildContext context) => Theme.of(context).primaryColor;
double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;

///TextTheme
TextStyle ptDisplay4(BuildContext context) => Theme.of(context).textTheme.display4;
TextStyle ptDisplay3(BuildContext context) => Theme.of(context).textTheme.display3;
TextStyle ptDisplay2(BuildContext context) => Theme.of(context).textTheme.display2;
TextStyle ptDisplay1(BuildContext context) => Theme.of(context).textTheme.display1;
TextStyle ptHeadline(BuildContext context) => Theme.of(context).textTheme.headline;
TextStyle ptTitle(BuildContext context) => Theme.of(context).textTheme.title;
TextStyle ptSubhead(BuildContext context) => Theme.of(context).textTheme.subhead;
TextStyle ptBody2(BuildContext context) => Theme.of(context).textTheme.body2;
TextStyle ptBody1(BuildContext context) => Theme.of(context).textTheme.body1;
TextStyle ptCaption(BuildContext context) => Theme.of(context).textTheme.caption;
TextStyle ptButton(BuildContext context) => Theme.of(context).textTheme.button;
TextStyle ptSubtitle(BuildContext context) => Theme.of(context).textTheme.subtitle;
TextStyle ptOverline(BuildContext context) => Theme.of(context).textTheme.overline;

///HeaderStyle
TextStyle ptHeadStyleText(BuildContext context) => Theme.of(context).textTheme.headline.copyWith(fontSize: 22);

///FontStyle
class FONT {
  static const String Bold = "OpenSans-Bold";
  static const String BoldItalic = "OpenSans-BoldItalic";
  static const String ExtraBold = "OpenSans-ExtraBold";
  static const String ExtraBoldItalic = "OpenSans-ExtraBoldItalic";
  static const String Italic = "OpenSans-Italic";
  static const String Light = "OpenSans-Light";
  static const String LightItalic = "OpenSans-LightItalic";
  static const String Regular = "OpenSans-Regular";
  static const String SemiBold = "OpenSans-SemiBold";
  static const String SemiBoldItalic = "OpenSans-SemiBoldItalic";
}

enum PaymentState { PENDING, SUCCESS, FAILED }
Map<String, dynamic> Gender = {
  'ALL': 'ALL',
  'MALE': 'MALE',
  'FEMALE': 'FEMALE',
};

class DropDownCustomItem {
  final String id;
  final String name;
  DropDownCustomItem({this.id, this.name});
}

final List<DropDownCustomItem> experiencesList = <DropDownCustomItem>[
  DropDownCustomItem(id: 'BELOW_1_YEAR', name: 'Dưới 1 Năm'),
  DropDownCustomItem(id: '1_YEAR', name: '1 Năm'),
  DropDownCustomItem(id: '2_YEARS', name: '2 Năm'),
  DropDownCustomItem(id: '3_YEARS', name: '3 Năm'),
  DropDownCustomItem(id: '4_YEARS', name: '4 Năm'),
  DropDownCustomItem(id: 'MORE_THAN_5_YEARS', name: 'Trên 5 Năm'),
];

final List<DropDownCustomItem> workHourList = <DropDownCustomItem>[
  DropDownCustomItem(id: 'BELOW_2_HOURS', name: 'Dưới 2 Giờ'),
  DropDownCustomItem(id: '2_TO_5_HOURS', name: '2 đến 5 Giờ'),
  DropDownCustomItem(id: '5_TO_8_HOURS', name: '5 đến 8 Giờ'),
  DropDownCustomItem(id: 'MORE_THAN_8_HOURS', name: 'Trên 8 Giờ'),
];

final List<DropDownCustomItem> incomelist = <DropDownCustomItem>[
  DropDownCustomItem(id: 'BELOW_5_MIL', name: 'Dưới 5 Triệu'),
  DropDownCustomItem(id: '5_TO_12_MIL', name: '5 đến 12 Triệu'),
  DropDownCustomItem(id: 'MORE_THAN_12_MIL', name: 'Hơn 12 Triệu'),
];

// Function<String> getNameFromSelectedId(List<DropDownCustomItem> list, String id) {

// }
