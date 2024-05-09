import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import '../../models/database_provider.dart';
import '../../models/expense.dart';

class PdfScreen extends StatelessWidget {
  const PdfScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Export'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _generateAndSavePdf(context);
          },
          child: const Text('Generate PDF'),
        ),
      ),
    );
  }

  Future<void> _generateAndSavePdf(BuildContext context) async {
    try {
      final dbProvider = Provider.of<DatabaseProvider>(context, listen: false);
      final List<Expense> expenses = await dbProvider.fetchAllExpenses();

      final pdf = pw.Document();

      final pw.TextStyle regularTextStyle = pw.TextStyle(
        font: pw.Font.ttf(
            await rootBundle.load('assets/fonts/NotoSans-Regular.ttf')),
      );
      final pw.TextStyle boldTextStyle = pw.TextStyle(
        font: pw.Font.ttf(
            await rootBundle.load('assets/fonts/NotoSans-Bold.ttf')),
      );

      final List<pw.TableRow> expenseRows = [
  pw.TableRow(
    children: [
      pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text('Title', style: boldTextStyle.copyWith(fontSize: 14.0)), 
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text('Amount', style: boldTextStyle.copyWith(fontSize: 14.0)), 
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text('Date', style: boldTextStyle.copyWith(fontSize: 14.0)), 
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text('Category', style: boldTextStyle.copyWith(fontSize: 14.0)), 
      ),
    ],
  ),
  for (var expense in expenses) ...[
    pw.TableRow(
      children: [
        pw.Container(
          alignment: pw.Alignment.center,
          child: pw.Text(expense.title, style: regularTextStyle.copyWith(fontSize: 12.0)), // Increased font size
        ),
        pw.Container(
          alignment: pw.Alignment.center,
          child: pw.Text(expense.amount.toString(), style: regularTextStyle.copyWith(fontSize: 12.0)), // Increased font size
        ),
        pw.Container(
          alignment: pw.Alignment.center,
          child: pw.Text(expense.date.toString(), style: regularTextStyle.copyWith(fontSize: 12.0)), // Increased font size
        ),
        pw.Container(
          alignment: pw.Alignment.center,
          child: pw.Text(expense.category, style: regularTextStyle.copyWith(fontSize: 12.0)), // Increased font size
        ),
      ],
    ),
  ],
];

final DateTime now = DateTime.now();
final String formattedDate = DateFormat('dd-MM-yyyy').format(now);


// Add widgets to a list
List<pw.Widget> pdfContent = [
  pw.Text('Expense Report', style: boldTextStyle.copyWith(fontSize: 16.0)),
  pw.Table(
    border: pw.TableBorder.all(),
    children: expenseRows,
  ),
  pw.SizedBox(height: 10),
  pw.Text('Date Printed: $formattedDate', style: const pw.TextStyle(fontSize: 10)),
];

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Center(
            child: pw.Column(children: pdfContent,)
          ),
        ),
      );
      final bytes = await pdf.save();
      final directory = await getExternalStorageDirectory();
      print('$directory!.path');
      final file = File('${directory!.path}/expenses_report.pdf');
      await file.writeAsBytes(bytes);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('PDF Saved'),
            content: const Text('Expenses report PDF saved successfully.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Log any errors that occur during PDF generation and saving
      print('Error: $e');
    }
  }
}
