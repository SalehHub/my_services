extension MyServicesExtensions on String {
  String limit(int length) {
    return substring(0, this.length < length ? null : length) + (this.length < length ? "" : "...");
  }
}
