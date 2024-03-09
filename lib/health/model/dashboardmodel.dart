
class Medication {
  DateTime due;
  String description;
  String medicinename;

  Medication(
      {required this.due,
      required this.description,
      required this.medicinename});

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      due:json['due'].toDate(),
      description: json['description'],
      medicinename: json['medicinename'],
    );
  }

  Map<String, dynamic> toJson() => {
        'due': due,
        'description': description,
        'medicinename': medicinename,
      };
}

class Overall {
  String unit;
  String title;
  dynamic value;

  Overall({required this.unit, required this.title, required this.value});

  factory Overall.fromJson(Map<String, dynamic> json) {
    return Overall(
      unit: json['unit'],
      title: json['title'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() => {
        'unit': unit,
        'title': title,
        'value': value,
      };
}

class Appointment {
  DateTime date;
  String referel;

  Appointment({required this.date, required this.referel});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      date: json['date'].toDate(),
      referel: json['referel'],
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'referel': referel,
      };
}

class HealthData {
  List<Medication> medications;
  List<Overall> overall;
  Appointment appointment;
  String id;

  HealthData(
      {required this.medications,
      required this.overall,
      required this.appointment,
      required this.id});

  factory HealthData.fromJson(Map<String, dynamic> json) {
    return HealthData(
      medications: List<Medication>.from(
          json['medications'].map((x) => Medication.fromJson(x))),
      overall:
          List<Overall>.from(json['overall'].map((x) => Overall.fromJson(x))),
      appointment: Appointment.fromJson(json['appointment']),
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'medications': List<dynamic>.from(medications.map((x) => x.toJson())),
        'overall': List<dynamic>.from(overall.map((x) => x.toJson())),
        'appointment': appointment.toJson(),
        '_id': id,
      };
}
