class UtilsString {
  static fixedHttpStart(String url) {
    if (url != null && !url.startsWith('http')) return 'https:' + url;
    return url;
  }
}
