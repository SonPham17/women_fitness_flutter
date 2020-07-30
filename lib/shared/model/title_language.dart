class TitleLanguage {
  String vi;
  String fr;
  String ko;
  String es;
  String pt;
  String ru;

  TitleLanguage.fromJson(Map<String, dynamic> map) {
    vi = map['vi'];
    fr = map['fr'];
    ko = map['ko'];
    es = map['es'];
    pt = map['pt'];
    ru = map['ru'];
  }
}
