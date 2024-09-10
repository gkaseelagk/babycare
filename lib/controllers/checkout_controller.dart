import 'dart:io';

import 'package:ecommerce/models/product.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share/share.dart';

class CheckoutController extends GetxController {
  var isProcessingPayment = false.obs;
  var transactionStatus = ''.obs;

  // Observable properties
  var transactionId = ''.obs;
  var purchaseDate = Rx<DateTime>(DateTime.now());
  var quantity = 1.obs;
  var productName = ''.obs;
  var totalPrice = 0.0.obs;

 
Future<void> processPayment({
  required Product product,
  required int selectedQuantity,
}) async {
  isProcessingPayment(true);
  await Future.delayed(Duration(seconds: 2));  // Simulate payment delay

  transactionId.value = "TXN${DateTime.now().millisecondsSinceEpoch}";
  purchaseDate.value = DateTime.now();
  this.productName.value = product.name;
  this.quantity.value = selectedQuantity;
  this.totalPrice.value = product.price * selectedQuantity;

  transactionStatus.value = "Payment successful! Transaction ID: ${transactionId.value}";
  isProcessingPayment(false);

  await generateReceipt(
    transactionId.value,
    purchaseDate.value,
    product.name,
    selectedQuantity,
    product.price * selectedQuantity,
  );
}

  Future<void> generateReceipt(
    String transactionId,
    DateTime purchaseDate,
    String productName,
    int quantity,
    double totalPrice,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(16),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.black),
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Product Name: $productName',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'Quantity: $quantity',
                  style: pw.TextStyle(
                    fontSize: 16,
                    color: PdfColors.black,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                  style: pw.TextStyle(
                    fontSize: 16,
                    color: PdfColors.green,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'Transaction ID: $transactionId',
                  style: pw.TextStyle(
                    fontSize: 16,
                    color: PdfColors.black,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'Date of Purchase: ${purchaseDate.toLocal()}',
                  style: pw.TextStyle(
                    fontSize: 16,
                    color: PdfColors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Save PDF to local storage
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/receipt_$transactionId.pdf");
    await file.writeAsBytes(await pdf.save());

    // Share PDF
    Share.shareFiles([file.path], text: 'Your receipt');
  }
}
