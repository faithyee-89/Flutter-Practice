class UtilsString {
  static fixedHttpStart(String url) {
    if (url == null || url == "") return "";
    if (url != null && !url.startsWith('http')) return 'https:' + url;
    if (url.startsWith('http:')) return url.replaceAll('http:', 'https:');
    return url;
  }
}
