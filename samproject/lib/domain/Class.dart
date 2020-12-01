class Class{

  String _className;
  String _classGrade;
  String _classLesson;
  String _classDescription;
  String _classId;
  String _classPassword;
  String _ownerFullName;
  bool _isOwner = false;

  Class(this._className, this._ownerFullName, this._classId, this._isOwner);

  String get className => _className;

  set className(String value) {
    _className = value;
  }

  String get classGrade => _classGrade;

  String get classPassword => _classPassword;

  set classPassword(String value) {
    _classPassword = value;
  }

  String get classId => _classId;

  set classId(String value) {
    _classId = value;
  }

  String get classDescription => _classDescription;

  set classDescription(String value) {
    _classDescription = value;
  }

  String get classLesson => _classLesson;

  set classLesson(String value) {
    _classLesson = value;
  }

  set classGrade(String value) {
    _classGrade = value;
  }


  String get ownerFullName => _ownerFullName;

  set ownerFullName(String value) {
    _ownerFullName = value;
  }


  bool get isOwner => _isOwner;

  set isOwner(bool value) {
    _isOwner = value;
  }

  @override
  String toString() {
    return 'Class{_className: $_className, _classId: $_classId, _ownerFullName: $_ownerFullName, _isOwner: $_isOwner}';
  }


}