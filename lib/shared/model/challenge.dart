class Challenge {
  int id;
  int week;
  int day;
  int sectionId;
  int status;

  Challenge.fromData(Map<String, dynamic> map) {
    this.id = map['id'];
    this.week = map['week'];
    this.day = map['day'];
    this.sectionId = map['sectionId'];
    this.status = map['status'];
  }
}
