import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:tanent_management/common/utils.dart';

class ReportPdfView extends StatelessWidget {
  final String pdfUrl;
  final String name;
  const ReportPdfView({super.key, required this.pdfUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          if (pdfUrl != "")
            IconButton(
                onPressed: () {
                  saveNetworkPdf(pdfUrl);
                },
                icon: const Icon(
                  Icons.download,
                ))
        ],
      ),
      body: PDF().cachedFromUrl(
        pdfUrl,
        placeholder: (progress) => Center(child: Text('$progress %')),
        errorWidget: (error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
