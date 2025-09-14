library my_prj.globals;

String getApiBaseUrl(String lot) {
  const appEnv = "production";
  if (appEnv == "production") {
    if (lot == "lot1") {
      return "http://prodlot1.parknjetseatac.com:9000";
    } else {
      return "http://prodlot2.parknjetseatac.com:9000";
    }
  } else if (appEnv == "plg") {
    if (lot == "lot1") {
      return "http://lot1.plg.parknjetseatac.com";
    } else {
      return "http://lot2.plg.parknjetseatac.com";
    }
  } else {
    if (lot == "lot1") {
      return "https://plg.parknjetseatac.com/b/api";
    } else {
      return "https://plg.parknjetseatac.com/b/api";
    }
  }
}
