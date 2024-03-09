import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equipohealth/offlinenotes/database/initializedb.dart';
import 'package:equipohealth/offlinenotes/model/notesmodel.dart';
import 'package:equipohealth/utils/helper.dart';
import 'package:equipohealth/utils/localstorage.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState()) {
    on<DoSignup>(doSignUp);
    on<DoLogin>(doLogin);
    on<GetRecentNotes>(getRecentNotes);
    on<AddNotes>(addNotes);
    on<DeleteNote>(deleteNote);
  }

  Future<FutureOr<void>> doSignUp(
      DoSignup event, Emitter<MainState> emit) async {
    try {
      UserCredential? userCredential;
      List<String> methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(event.email);
      if (methods.isNotEmpty) {
        Helper.showToast(
            msg: "The email address is already in use by another account");
      } else {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: event.email, password: event.pass);
      }
      Helper.showLog(userCredential!.additionalUserInfo!.isNewUser);
    } catch (e) {
      Helper.showLog("Exception on signin $e");
    }
  }

  Future<FutureOr<void>> getRecentNotes(
      GetRecentNotes event, Emitter<MainState> emit) async {
    try {
      List<Note> notesData = [];
      List data = await DatabaseHelper.getAllRecentNotes();
      if (data.isNotEmpty) {
        for (var element in data) {
          notesData.add(Note.fromJson(element));
        }
        if (notesData.isNotEmpty) {
          notesData.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
          emit(RecentNotesFetched(notesData: notesData));
        }
      } else {
        emit(RecentNotesNotFound());
      }
    } catch (e) {
      Helper.showLog("Exception on getting(bloc) notes $e");
      emit(GettingRecentNotesError());
    }
  }

  Future<FutureOr<void>> addNotes(
      AddNotes event, Emitter<MainState> emit) async {
    try {
      emit(AddingNotes());
      Map<String, dynamic> data = {
        "content": event.content,
        "isEditable": true,
        "isFinished": false,
        "timestamp": event.date.toString(),
        "shared": [],
        "userid": await LocalStorage.getUserId(),
      };
      FirebaseFirestore.instance
          .collection('rapidtodo')
          .add(data)
          .then((value) {
        Helper.showLog(value);
        Helper.showToast(msg: "Added successfully");
      });

      // final reponse =
      //     await DatabaseHelper.addNote(event.title, event.content, event.date);
      // if (reponse) {
      //   Helper.showToast(msg: "Log added successfully");
      //   add(GetRecentNotes());
      //   emit(NotesAdded());
      // } else {
      //   Helper.showToast(msg: "Log not added");
      //   emit(NotesNotAdded());
      // }
    } catch (e) {
      Helper.showLog("Exception on adding note $e");
      emit(AddingNotesError());
    }
  }

  Future<FutureOr<void>> doLogin(DoLogin event, Emitter<MainState> emit) async {
    try {
      UserCredential? userCredential;
      List<String> methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(event.email);
      if (methods.isEmpty) {
        Helper.showToast(
            msg: "This email address is not registered, please signup");
      } else {
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email, password: event.pass);
        // await LocalStorage.saveUserData(jsonEncode(userCredential));
        if (userCredential.user!.uid.isNotEmpty) {
          bool result = await DatabaseHelper.addLoginDetails(userCredential);
          if (result) {
            await LocalStorage.saveUserId(userCredential.user!.uid);
            FirebaseFirestore.instance.collection('rapidusers').add({
              "email": userCredential.user!.email,
              "uid": userCredential.user!.uid
            }).then((value) {
              Helper.showLog(value);
              Helper.showToast(msg: "Added successfully");
            });
            emit(LoginSuccess());
          } else {
            Helper.showToast(msg: "Login failed");
            emit(LoginFailed());
          }
        } else {
          Helper.showToast(msg: "Login failed");
          emit(LoginFailed());
        }
      }
      Helper.showLog(userCredential!.additionalUserInfo!.isNewUser);
    } catch (e) {
      emit(LoginFailed());
      Helper.showToast(msg: "Something went wrong");
      Helper.showLog("Exception on signin $e");
    }
  }

  Future<FutureOr<void>> deleteNote(
      DeleteNote event, Emitter<MainState> emit) async {
    try {
      final response =
          await DatabaseHelper.deleteNote(event.noteId, event.userId);
      if (response) {
        add(GetRecentNotes());
        Helper.showToast(msg: "Log deleted successfully");
        emit(NoteDeleted());
      } else {
        Helper.showToast(msg: "Unable to delete log");
        emit(NotesNotDeleted());
      }
    } catch (e) {
      Helper.showToast(msg: "Something went wrong");
      Helper.showLog("Deleting note exception $e");
    }
  }
}

class MainEvent {}

class MainState {}

class LoginFailed extends MainState {}

class LoginSuccess extends MainState {}

class DoSignup extends MainEvent {
  final String email, pass;
  DoSignup({required this.email, required this.pass});
}

class DoLogin extends MainEvent {
  final String email, pass;
  DoLogin({required this.email, required this.pass});
}

//**************************** */

class GetRecentNotes extends MainEvent {
  // final DateTime date;
  // GetRecentNotes({required this.date});
}

class GettingRecentNotes extends MainState {}

class RecentNotesFetched extends MainState {
  final List<Note>? notesData;
  RecentNotesFetched({required this.notesData});
}

class RecentNotesNotFound extends MainState {}

class GettingRecentNotesError extends MainState {}

//**************************** */

class AddNotes extends MainEvent {
  final String? title, content;

  final DateTime date;
  AddNotes({required this.date, required this.title, required this.content});
}

class AddingNotes extends MainState {}

class NotesAdded extends MainState {}

class NotesNotAdded extends MainState {}

class AddingNotesError extends MainState {}

class DeleteNote extends MainEvent {
  final String? noteId, userId;
  DeleteNote({this.noteId, this.userId});
}

class NoteDeleted extends MainState {}

class NotesNotDeleted extends MainState {}

class DeleteNoteError extends MainState {}
//AddNotes