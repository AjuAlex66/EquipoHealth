import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:equipohealth/offlinenotes/bloc/mainbloc.dart';
import 'package:equipohealth/utils/helper.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  // InterstitialAd? _interstitialAd;

  DateTime? pickedTime;
  final GlobalKey<FormState> notesFormKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  @override
  void initState() {
    pickedTime = DateTime.now().subtract(const Duration(days: 1));
    dateController.text =
        "${DateFormat("dd/MM/yyyy").format(DateTime.now())} (Today)";
    // _loadInterstitialAd();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        // actions: [const CircleAvatar(), Helper.allowWidth(10)],
        title: const Text("Add Logs"),
        elevation: 1.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<MainBloc, MainState>(
          listenWhen: (previous, current) =>
              current is NotesAdded ||
              current is NotesNotAdded ||
              current is AddingNotesError,
          listener: (context, state) {
            if (state is NotesAdded) {
              _loadInterstitialAd();
            }
          },
          builder: (context, state) {
            return Form(
              key: notesFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Title (Optional)"),
                  Helper.allowHeight(2),
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(hintText: "Log title"),
                  ),
                  Helper.allowHeight(20),
                  const Text("Content"),
                  Helper.allowHeight(2),
                  TextFormField(
                    controller: contentController,
                    // strutStyle: const StrutStyle(),
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(hintText: "Log content"),
                    maxLines: 10,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This fields is required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Helper.allowHeight(20),
                  const Text("Date"),
                  Helper.allowHeight(2),
                  TextFormField(
                    onTap: () => showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023, 11, 01),
                      lastDate: DateTime.now(),
                      initialDatePickerMode: DatePickerMode.day,
                      onDatePickerModeChange: (value) => Helper.showLog(value),
                    ),
                    readOnly: true,
                    controller: dateController,
                  ),
                  Helper.allowHeight(10),
                  SizedBox(
                    width: Helper.width(),
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.purple[200])),
                      onPressed: () {
                        // _loadInterstitialAd();
                        if (notesFormKey.currentState!.validate()) {
                          context.read<MainBloc>().add(AddNotes(
                              title: titleController.text,
                              content: contentController.text,
                              date: pickedTime!));
                        }
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _loadInterstitialAd() {
    try {
      InterstitialAd.load(
          adUnitId: 'ca-app-pub-3940256099942544/1033173712',
          // adUnitId: 'ca-app-pub-1921721310026993/1211623861',
          request: const AdRequest(),
          adLoadCallback:
              InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
            ad.fullScreenContentCallback =
                FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              Helper.pop();
            });
          }, onAdFailedToLoad: (LoadAdError error) {
            Helper.showLog(error.message);
            Helper.pop();
            // Helper.showToast(
            //     msg: 'Failed to load an interstitial ad: ${error.message}');
          }));
    } on Exception catch (e) {
      Helper.pop();
      Helper.showLog("Exception on ad loading $e");
    }
  }
}
