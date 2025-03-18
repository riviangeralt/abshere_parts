class AbshereAppApi {
  static String fetchIndustryDetails(String estId) {
    return '/establishment/$estId/industry';
  }

  static String fetchHookDetails(String estId) {
    return '/establishment/$estId/hooks-details';
  }

  static String fetchEmployeeSalary(String estId) {
    return '/establishment/$estId/employees-salary';
  }

  static String fetchTurnover(String estId) {
    return '/establishment/$estId/employee';
  }

  static String fetchEstablishment(String estId) {
    return '/establishment/$estId';
  }
}
