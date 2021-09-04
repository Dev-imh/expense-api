import 'package:expense/model/user.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetsApi {
  static const _cerdentials = r'''
  {
  "type": "service_account",
  "project_id": "expense-api-79b08",
  "private_key_id": "31fcc572b60f19e0741d602e305fd02928536374",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDyWFIvAX0CQyNl\nqX0JOrFYcbbFItH7cd0325hXDY5S7NBajZX8hm5HqQ1nF4jSWHv/a4IDMgNtjWac\nL9MrXfcOiP2gXS3ej3gJFhHaY4yq1Tvwgh6CwUg9+yMMerY48XfTQg2nn6qeH5XC\nZaboJ5pv42oNrxYRUS3JHABErTQo4BPTQ8huQkgnMixXvfXYJRgWCXp5NDKR4nQa\nr5omhhAuIR/C5OMrDh5ozLggZAHKzW0LSy8jGicFepVrUQ/h7uQS3ZwHO5GDk0u3\ndnQolr9xR4bkfRSOf8xnV22U5VvamJdREXRGSgl7feNLm7jHQC/1C4s+FH0Z7K+r\nOZZ6fAzJAgMBAAECggEACwYRufXoPvK5INoaeBGhiM+GY/YDJXwO1yg/6CDTmynO\nyfm0C4Q9brjNxWVcic3w2QPlynmrTn/OvbbOtSOtde2tFM78Q8oUqJwmhH/AAbLY\nqsZudx3t6HTcqagI0zMHs3ZHGvuANjhjVnALjTak96c5dyUiXLgLvEDP8c/LpjrB\nfv9cfSMWpqI8yXXKzot6gg8IeOgZ+3KeUlhYOqeRzodVUpYmIchnp/tJ0fEse/Ui\nqAygiJ1nW/BXVDgY0ebnotCmcNnqBBQ3GhjT7oIQV8ZEGNHyZqVZj3F/muvUzWHK\nF23Kn8TvgZwSs+EPsxqXvsjvst761kPGfZEPs0rAUQKBgQD6J0Wz+g07bVwBI56x\nyOzvxv4oePMpIn1Q9S2LqDjROdlL++HH7zhooJW1osQAExcnoxjyLOo0U/YW3WUY\nowAZEn92AHpBb5Ep/2jVfeCNIBhjZq7hDmn0/3aHu+HF8hr+JffTpq0NNzNNEuZD\neb+lS+v3B6dC3ftnM3fBeBROcQKBgQD4AlRG1yYCAT1HEDhcaGrku9eyZjj+6VD0\nkC5Vjcl55eU8Ux4NS71ewkicAJJ0q266hdSbd145s/VfqrpcFUEJATkwr3HhYH27\nM7Td8AXYrc+awzLFvDJgb1VvVplRukhhYqueaDK5sHl9azvHfbdthxzPmZspqTfA\nrtcz0NP/2QKBgFmBHb6EtKFTwryhmxFvm987KwseI5rPPVlvMEms+g9ajHZUfHeG\nD3/YHVjtEQYZzoofIDjeezoX5JBPzPFguRM/fB2jlBq/qYgGW+Mvc93q4u8F+YKL\nHrxLf4SXY/PoaWIQAblYBMkavB9SqNLxx/GD1b0Anwcc1+wYDTxLE7DxAoGAKVAS\nA97xCOJ197F/Af2u2L1lt+UJV4U8JBEkdsHwruqZ3gumdOaJ/A/3Em2R9/dasZ17\nhg5DVu9gT3hcJNyxgbN/eFmxaa6uIxIA7ft+rdJ+Q7SCb6fi6GeDXtGZJqEWT4ql\nNfT7hi0cf8TuJ1QMyyT3qqlWzIDQtbsqRApkVjkCgYBEL4nutTGRN9fTzkdO/c8k\nS4ApwLZYUhfLru2CzewKMggip6gsmJ/Ekoht/NnHbWjRREyvODv21+DlzkcjvGRB\n33Wye0SrSo+Pyy9CwVuzimA3wznA+gbU+QpkHelC2rKDF2ofyyyTgLOn23/o2I3p\nX6t6FwvKUPDoGl68U+ZuYA==\n-----END PRIVATE KEY-----\n",
  "client_email": "passakorn@expense-api-79b08.iam.gserviceaccount.com",
  "client_id": "114474926498737909922",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/passakorn%40expense-api-79b08.iam.gserviceaccount.com"
}

''';
  static final _spreadsheetId = '1uyqVv1QcDuShYFgiGb4DxCm2tUWwpPmtuBBe5yX8fjE';
  static final _gsheets = GSheets(_cerdentials);
  static Worksheet? _userSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Users');

      final firstRow = UserFileds.getFields();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<int> getRowCount() async {
    if (_userSheet == null) return 0;
    final lastRow = await _userSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_userSheet == null) return;

    _userSheet!.values.map.appendRows(rowList);
  }
}
