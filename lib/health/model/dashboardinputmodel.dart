class DashboardInputModel {
  int? bloodHigher, bloodLower, heartRate, calorieRate, sleepHour;
  String? mediceName1, mediceName2, mediceName3, doctorName;
  DashboardInputModel(
      {this.bloodHigher,
      this.bloodLower,
      this.calorieRate,
      this.doctorName,
      this.heartRate,
      this.mediceName1,
      this.mediceName2,
      this.mediceName3,
      this.sleepHour});
}
