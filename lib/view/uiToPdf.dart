import 'dart:io';
import 'dart:io' as io;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:file_picker/file_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class MyInvoiceScreen extends StatefulWidget {
  @override
  State<MyInvoiceScreen> createState() => _MyInvoiceScreenState();
}

class _MyInvoiceScreenState extends State<MyInvoiceScreen> {
// Create a function to generate the PDF
  Future generatePDF() async {
    final pdf = pw.Document();

    // Create a page
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          // Add your UI widgets to the PDF page
          return pw.Center(
            child: pw.Text('Hello, PDF!'),
          );
        },
      ),
    );

    // Save the PDF to a file
    // final outputFile = File('path/to/output.pdf');
    // await outputFile.writeAsBytes(await pdf.save());
  }

  Future<void> _downloadInvoice() async {
    // Generate the PDF
    final pdf = await generatePDF();

    // Prompt the user to select a file location
    final destination = await FilePicker.platform.getDirectoryPath();

    if (destination != null) {
      // Create the output file path
      final outputFilePath = '$destination/invoice.pdf';

      // Save the PDF to the selected file location
      // final outputFile = File(outputFilePath);
      // await outputFile.writeAsBytes(await pdf.save());

      final file = await io.File(outputFilePath).writeAsBytes(pdf.save());

      // Show a confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('PDF Saved'),
          content: Text('The PDF was saved to:\n$outputFilePath'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _downloadInvoice,
          child: Text('Download'),
        ),
      ),
    );
  }
}
