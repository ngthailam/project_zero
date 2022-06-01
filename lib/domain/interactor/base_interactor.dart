abstract class BaseInteractor<I, O> {
  Future<O> execute(I input);
}
