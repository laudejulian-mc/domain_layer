// Minimal Either implementation for domain layer use (replace with dartz in infrastructure layer)
class Either<L, R> {
  final L? _left;
  final R? _right;
  final bool _isLeft;

  Either.left(L value)
      : _left = value,
        _right = null,
        _isLeft = true;

  Either.right(R value)
      : _left = null,
        _right = value,
        _isLeft = false;

  bool get isLeft => _isLeft;
  bool get isRight => !_isLeft;
  L get left => _left as L;
  R get right => _right as R;
}
