abstract interface class UseCase<T, U> {
  Future<T> execute(U params);
}
