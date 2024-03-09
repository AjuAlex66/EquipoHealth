import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:equipohealth/offlinenotes/model/notesmodel.dart';
import 'package:equipohealth/utils/helper.dart';
// import 'package:open_file_safe/open_file_safe.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class NoteViewPage extends StatefulWidget {
  final Note? noteData;
  const NoteViewPage({super.key, required this.noteData});

  @override
  State<NoteViewPage> createState() => _NoteViewPageState();
}

class _NoteViewPageState extends State<NoteViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        elevation: 1.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text("Note Title"),
            Helper.allowHeight(2.5),
            const Divider(),
            Helper.allowHeight(2.5),
            Text(
              widget.noteData!.noteTitle!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Helper.allowHeight(20),
            const Text("Note Content"),
            Helper.allowHeight(2.5),
            const Divider(),
            Helper.allowHeight(2.5),
            Text(
              widget.noteData!.noteContent!.trim(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Helper.allowHeight(20),
            const Text("Created Date"),
            Helper.allowHeight(2.5),
            const Divider(),
            Helper.allowHeight(2.5),
            Text(
              DateFormat('dd/MM/yyyy EEEE hh:mm:ss a')
                  .format(widget.noteData!.timestamp!),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Helper.allowHeight(50),
            Row(
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                      color: Colors.green[300]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.edit, color: Colors.white),
                      Helper.allowWidth(5.0),
                      const Text(
                        "Edit Note",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )),
                Helper.allowWidth(10.0),
                Expanded(
                    child: InkWell(
                  onTap: () async => await createPdf(widget.noteData),
                  child: Container(
                    padding: const EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        color: Colors.red[300]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.picture_as_pdf, color: Colors.white),
                        Helper.allowWidth(5.0),
                        const Text(
                          "View PDF",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }

  createPdf(Note? noteData) async {
    try {
      ByteData fontData =
          await rootBundle.load('assets/fonts/Ubuntu-Regular.ttf');
      final ttf = pw.Font.ttf(fontData.buffer.asByteData());
      final pdf = pw.Document();

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Padding(
              padding: const pw.EdgeInsets.all(14.0),
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisSize: pw.MainAxisSize.max,
                  children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisSize: pw.MainAxisSize.max,
                        children: [
                          pw.Text("SimpleLogs",
                              style: pw.TextStyle(
                                font: ttf,
                              )),
                          pw.Text(
                              DateFormat('dd/MM/yyyy EEEE hh:mm:ss a')
                                  .format(noteData!.timestamp!),
                              style: pw.TextStyle(
                                font: ttf,
                              )),
                        ]),
                    pw.SizedBox(height: 5),
                    pw.Divider(),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      noteData.noteTitle!,
                      style: pw.TextStyle(
                          font: ttf,
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(noteData.noteContent!,
                        style: pw.TextStyle(font: ttf, fontSize: 14)),
                  ]),
            );
          }));
      // final output = await getTemporaryDirectory();
      // final file = File("${output.path}/${noteData!.notesId!}.pdf");
      // await file.writeAsBytes(await pdf.save());
      // await OpenFile.open(file.path);
    } catch (e) {
      Helper.showLog("Exception on making pdf! $e");
    }
  }
}
