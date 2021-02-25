class GlobalVariables {
  static final String _routePrefix = "http://45.55.44.174/SM/";

  static String baseUrl(String route) {
    return "$_routePrefix$route";
  }
}
