import 'package:auf/models/user/bank_model.dart';
import 'package:auf/models/user/state_model.dart';
import 'package:auf/models/user/title_model.dart';
import 'package:flutter/material.dart';

// const rootUrl = "http://10.0.2.2:8000/api/";
const rootUrl = "https://easy.aufmbz.com/api/";

const runBillToyyibpayUrl = "https://toyyibpay.com/";
const version = "AUFMBZ v 1.7.31";

const kPrimaryColor = Color.fromRGBO(16, 185, 129, 1);
const kLightBlue = Color.fromRGBO(244, 247, 255, 1);
const kDisabledText = Color.fromARGB(255, 152, 152, 152);
const kWhite = Colors.white;
const kLightGrey = Color.fromRGBO(204, 204, 204, 1);
const kGrey = Colors.grey;
const kDarkGrey = Color.fromRGBO(64, 64, 64, 1);
const kBlack = Colors.black;
const kBgColor = Color.fromARGB(255, 252, 252, 252);
const kTransparent = Colors.transparent;
const kPrimaryLight = Color.fromARGB(255, 238, 250, 246);
const kDanger = Color.fromARGB(255, 209, 0, 10);
const kDisabledBg = Color.fromARGB(255, 224, 224, 224);
const kPrimaryLightColor = Color.fromRGBO(241, 244, 250, 1.0);
const kTextGray = Color.fromRGBO(0, 0, 0, 0.40);

// Success
const kBgSuccess = Color.fromRGBO(236, 253, 245, 1.0);
const kTextSuccess = kPrimaryColor;

// Danger
const kBgDanger = Color.fromRGBO(254, 242, 242, 1.0);
const kTextDanger = Color.fromRGBO(153, 27, 27, 1.0);

// Warning
const kBgWarning = Color.fromRGBO(255, 251, 235, 1.0);
const kTextWarning = Color.fromRGBO(188, 139, 20, 6);

// Info
const kBgInfo = Color.fromRGBO(236, 253, 245, 1.0);
const kTextInfo = kPrimaryColor;

const inputBoxShadowColor = Color(0x006d6d6d);

const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    kPrimaryColor,
    Color.fromRGBO(21, 52, 35, 1),
  ],
);

class DialogType {
  static const int info = 1;
  static const int danger = 2;
  static const int warning = 3;
  static const int success = 4;
}

class GraphSelectionOption {
  static const int sales = 1;
  static const int commission = 2;
  static const int points = 3;
}

class TransactionStatus {
  static const String success = "1";
  static const String pending = "2";
  static const String fail = "3";
}

const SEARCH_TYPE_ALL = 0;

const pageSize = 15;

List<BankModel> listBankModel = [
  BankModel(id: 1, name: "Maybank2U"),
  BankModel(id: 2, name: "CIMB Bank"),
  BankModel(id: 3, name: "Bank Islam"),
  BankModel(id: 4, name: "Public Bank"),
  BankModel(id: 5, name: "Hong Leong Bank"),
  BankModel(id: 6, name: "RHB Bank"),
  BankModel(id: 7, name: "Ambank"),
  BankModel(id: 8, name: "Bank Rakyat"),
  BankModel(id: 9, name: "Alliance Bank"),
  BankModel(id: 10, name: "Affin Bank"),
  BankModel(id: 11, name: "Bank Muamalat"),
  BankModel(id: 12, name: "Bank Simpanan Nasional"),
  BankModel(id: 13, name: "Standard Chartered"),
  BankModel(id: 14, name: "OCBC Bank"),
  BankModel(id: 15, name: "Agro Bank"),
  BankModel(id: 16, name: "UOB Bank"),
  BankModel(id: 17, name: "HSBC"),
  BankModel(id: 18, name: "Kuwait Finance House"),
  BankModel(id: 19, name: "CIMB Islamic Bank"),
  BankModel(id: 20, name: "Maybank2E"),
  BankModel(id: 21, name: "Al Rajhi Bank"),
  BankModel(id: 22, name: "Citibank Berhad"),
  BankModel(id: 23, name: "Maybank"),
  BankModel(id: 24, name: "MBSB Bank"),
];

List<DivisionModel> listDivisionModel = [
  DivisionModel(id: 10, name: "Johor"),
  DivisionModel(id: 11, name: "Kedah"),
  DivisionModel(id: 12, name: "Kelantan"),
  DivisionModel(id: 13, name: "Kuala Lumpur"),
  DivisionModel(id: 14, name: "Labuan"),
  DivisionModel(id: 15, name: "Melaka"),
  DivisionModel(id: 16, name: "Negeri Sembilan"),
  DivisionModel(id: 17, name: "Pahang"),
  DivisionModel(id: 18, name: "Perak"),
  DivisionModel(id: 19, name: "Perlis"),
  DivisionModel(id: 20, name: "Penang"),
  DivisionModel(id: 21, name: "Sabah"),
  DivisionModel(id: 22, name: "Sarawak"),
  DivisionModel(id: 23, name: "Selangor"),
  DivisionModel(id: 24, name: "Terengganu"),
];

List<TitleModel> listTitleModel = [
  TitleModel(id: 0, title: "Tan Sri"),
  TitleModel(id: 1, title: "Puan Sri"),
  TitleModel(id: 2, title: "Dato Sri"),
  TitleModel(id: 3, title: "Dato Seri"),
  TitleModel(id: 4, title: "Datuk"),
  TitleModel(id: 5, title: "Datin"),
  TitleModel(id: 6, title: "Haji"),
  TitleModel(id: 7, title: "Hajah"),
  TitleModel(id: 8, title: "Tuan"),
  TitleModel(id: 9, title: "Puan"),
  TitleModel(id: 10, title: "Encik"),
  TitleModel(id: 11, title: "Cik"),
  TitleModel(id: 12, title: "Dr"),
];
