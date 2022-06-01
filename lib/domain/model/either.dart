class Either<D, E> {
  final D? data;
  final E? exception;

  Either({this.data, this.exception});
}

extension EitherExtensions on Either {
  bool isSuccess() {
    return exception == null;
  }
}
