import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:novindus_mechine_test/constatnts/string_utils.dart';
import 'package:novindus_mechine_test/data/models/branch_model.dart';
import 'package:novindus_mechine_test/data/models/treatments_model.dart';
import 'package:novindus_mechine_test/presentation/screens/pdf_viewing_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

createPdf(
  BuildContext context, {
  required String name,
  required String executive,
  required String payment,
  required String phone,
  required String address,
  required double totalAmount,
  required double discountAmount,
  required double advanceAmount,
  required double balanceAmount,
  required String date,
  required String time,
  required List<String> male,
  required List<String> feMale,
  required Branch branch,
  required List<Treatment> treatments,
}) async {
  final pdf = pw.Document(
    pageMode: PdfPageMode.fullscreen,
  );
  final fadedLogoimage = await imageFromAssetBundle('assets/images/png/faded_logo.png');
  final logoImage = await imageFromAssetBundle('assets/images/png/logo.png');
  final signature = await imageFromAssetBundle('assets/images/png/signature.png');

  pdf.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        pageFormat: PdfPageFormat.a3,
        margin: pw.EdgeInsets.zero,
        buildBackground: (c) {
          return pw.Align(
            child: pw.Image(
              fadedLogoimage,
              height: 400,
              width: 400,
            ),
          );
        },
      ),
      build: (pw.Context context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Header(
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(50),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(
                    logoImage,
                    height: 76,
                    width: 80,
                  ),
                  pw.Container(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        buildText(
                          branch.name!,
                          pw.TextStyle(
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        buildText(
                          branch.address!,
                          pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        buildText(
                          branch.mail!,
                          pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        buildText(
                          'Mob: ${branch.phone} | +91 9786543210',
                          pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        buildText(
                          branch.phone!,
                          pw.TextStyle(
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 50, vertical: 16),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Patient Details',
                  style: pw.TextStyle(
                    fontBold: pw.Font.courierBold(),
                    fontSize: 13,
                    color: PdfColors.green800,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                        children: [
                          buildRowText(title: 'Name', content: name),
                          pw.SizedBox(height: 10),
                          buildRowText(title: 'Address', content: address),
                          pw.SizedBox(height: 10),
                          buildRowText(title: 'WhatsApp Number', content: phone),
                        ],
                      ),
                    ),
                    pw.SizedBox(width: 50),
                    pw.Expanded(
                      child: pw.Column(
                        children: [
                          buildRowText(title: 'Booked On', content: '12-02-12'),
                          pw.SizedBox(height: 10),
                          buildRowText(title: 'Treatment Date', content: date),
                          pw.SizedBox(height: 10),
                          buildRowText(title: 'Treatment Time ', content: time),
                        ],
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 25),
                buildDottedDash(),
                pw.SizedBox(height: 25),
                pw.Table(
                  children: [
                    pw.TableRow(
                      children: titles
                          .map(
                            (e) => pw.Padding(
                              padding: const pw.EdgeInsets.only(right: 10),
                              child: pw.Text(e, style: pw.TextStyle(color: PdfColors.green700, fontWeight: pw.FontWeight.bold, fontSize: 15)),
                            ),
                          )
                          .toList(),
                    ),
                    ...treatments
                        .asMap()
                        .entries
                        .map(
                          (e) => pw.TableRow(
                            children: [
                              pw.Padding(
                                padding: const pw.EdgeInsets.only(right: 10, top: 10, bottom: 10),
                                child: pw.Text(e.value.name!, style: pw.TextStyle(color: PdfColors.grey700, fontWeight: pw.FontWeight.bold, fontSize: 15)),
                              ),
                              pw.Padding(
                                padding: const pw.EdgeInsets.only(right: 10, top: 10, bottom: 10),
                                child: pw.Text(e.value.price!, style: pw.TextStyle(color: PdfColors.grey700, fontWeight: pw.FontWeight.bold, fontSize: 15)),
                              ),
                              pw.Padding(
                                padding: const pw.EdgeInsets.only(right: 10, top: 10, bottom: 10),
                                child: pw.Text(male[e.key], style: pw.TextStyle(color: PdfColors.grey700, fontWeight: pw.FontWeight.bold, fontSize: 15)),
                              ),
                              pw.Padding(
                                padding: const pw.EdgeInsets.only(right: 10, top: 10, bottom: 10),
                                child: pw.Text(feMale[e.key], style: pw.TextStyle(color: PdfColors.grey700, fontWeight: pw.FontWeight.bold, fontSize: 15)),
                              ),
                              pw.Padding(
                                padding: const pw.EdgeInsets.only(right: 10, top: 10, bottom: 10),
                                child: pw.Text(totalAmount.toString(), style: pw.TextStyle(color: PdfColors.grey700, fontWeight: pw.FontWeight.bold, fontSize: 15)),
                              )
                            ],
                          ),
                        )
                        .toList(),
                  ],
                ),
                pw.SizedBox(height: 25),
                buildDottedDash(),
                pw.SizedBox(height: 40),
                pw.Align(
                  alignment: pw.Alignment.topRight,
                  child: pw.Container(
                    width: 300,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Total',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            pw.SizedBox(width: 30),
                            pw.Text(
                              '7,620',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 10),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Discount',
                              style: const pw.TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            pw.SizedBox(width: 30),
                            pw.Text(
                              '500',
                              style: const pw.TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 10),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Advance',
                              style: const pw.TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            pw.SizedBox(width: 30),
                            pw.Text(
                              '1,200',
                              style: const pw.TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 10),
                        buildDottedDash(),
                        pw.SizedBox(height: 10),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Balance',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            pw.SizedBox(width: 30),
                            pw.Text(
                              '\u{20B9}5,920',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(height: 60),
                pw.Align(
                  alignment: pw.Alignment.topRight,
                  child: pw.Container(
                    width: 400,
                    child: pw.Column(
                      children: [
                        pw.Text(
                          'Thank you for choosing us',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.green600,
                            fontSize: 16,
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          "Your well-being is our commitment, and we're honored you've entrusted us with your health journey",
                          textAlign: pw.TextAlign.right,
                          style: const pw.TextStyle(
                            color: PdfColors.grey600,
                            fontSize: 14,
                          ),
                        ),
                        pw.SizedBox(height: 20),
                        pw.Image(
                          height: 41,
                          width: 107,
                          signature,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.Spacer(),
          buildDottedDash(),
          pw.Footer(
            title: pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 18),
                child: pw.Column(children: [
                  pw.Text(
                    "“Booking amount is non-refundable, and it's important to arrive on the allotted time for your treatment”",
                    style: const pw.TextStyle(color: PdfColors.grey500, fontSize: 14),
                  ),
                ])),
          ),
        ],
      ),
    ),
  );

  final output = await getTemporaryDirectory();
  final file = File('${output.path}/treatment_data.pdf');
  await file.writeAsBytes(await pdf.save());

  context.pushNamed(
    PdfViewingScreen.route,
    extra: <String, dynamic>{
      'file': file.path,
    },
  );
}

Future<pw.ImageProvider> imageFromAssetBundle(String assetPath) async {
  final bytes = await rootBundle.load(assetPath);
  return pw.MemoryImage(bytes.buffer.asUint8List());
}

buildText(String s, pw.TextStyle style) {
  return pw.Text(
    s,
    style: style,
  );
}

buildRowText({required String title, required String content}) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      pw.Text(
        title,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 10,
        ),
      ),
      pw.Text(
        content,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.grey600,
          fontSize: 10,
        ),
      ),
    ],
  );
}

List<String> titles = ['Treatment', 'Price', 'Male', 'Female', 'Total'];

buildDottedDash() => pw.LayoutBuilder(
      builder: (c, co) {
        final boxWidth = co!.constrainWidth();
        const dashWidth = 10.0;
        final dashCount = (boxWidth / (2 * dashWidth));
        return pw.Flex(
          children: List.generate(dashCount.toInt(), (_) {
            return pw.SizedBox(
              width: dashWidth,
              height: 2,
              child: pw.DecoratedBox(
                decoration: const pw.BoxDecoration(color: PdfColors.grey500),
              ),
            );
          }),
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          direction: pw.Axis.horizontal,
        );
      },
    );
