library counting_set;

import 'dart:collection';

/// A [HashSet] that remembers how many times an element was added, and requires
/// that element to be removed that many times before it's actually removed.
///
/// When elements are added, they replace existing equal elements (instead of
/// doing nothing).
class CountingHashSet<E> with SetMixin<E> implements Set<E> {
  final HashSet<E> _inner;
  final HashMap<E, int> _counts;

  /// Equivalent to [HashSet]'s main constructor.
  CountingHashSet({
    bool Function(E, E)? equals,
    int Function(E)? hashCode,
    bool Function(dynamic)? isValidKey,
  })  : _inner = HashSet(
          equals: equals,
          hashCode: hashCode,
          isValidKey: isValidKey,
        ),
        _counts = HashMap(
          equals: equals,
          hashCode: hashCode,
        );

  /// Equivalent to [HashSet.identity].
  CountingHashSet.identity()
      : _inner = HashSet.identity(),
        _counts = HashMap.identity();

  /// Equivalent to [HashSet.of].
  factory CountingHashSet.of(Iterable<E> elements) =>
      CountingHashSet()..addAll(elements);

  /// Values in the set, mapped to the number of times they've been added.
  ///
  /// The returned map may be updated; make a copy if you don't want the data to
  /// change.
  Map<E, int> get counts => UnmodifiableMapView(_counts);

  /// Adds [value] to the set.
  ///
  /// Returns `true` if [value] (or an equal value) was not yet in the set.
  /// Otherwise returns `false` and the required removal counter is incremented.
  ///
  /// If a value equal to [value] was already in the set, it is replaced with
  /// [value].
  @override
  bool add(E value) {
    _counts[value] = (_counts[value] ?? 0) + 1;
    return _inner.add(value);
  }

  /// Adds the given values with counts.
  ///
  /// For example, `addCounts({'example': 2})` would add 'example' to the set
  /// and require it to be removed twice to actually be removed from the set.
  void addCounts(Map<E, int> counts) {
    _counts.addAll(counts);
    _inner.addAll(counts.keys);
  }

  /// Removes [value] from the set.
  ///
  /// Returns `true` if [value] was in the set, and `false` if not.
  /// The method has no effect if [value] was not in the set.
  ///
  /// If [value] requires removal multiple times, the required removal counter
  /// is decremented. Otherwise, [value] is removed.
  @override
  bool remove(Object? value) {
    if (!_inner.contains(value)) return false;
    final newCount = _counts[value]! - 1;
    if (newCount == 0) {
      _inner.remove(value);
      _counts.remove(value);
    } else {
      _counts[value as E] = newCount;
    }
    return true;
  }

  @override
  void clear() {
    _inner.clear();
    _counts.clear();
  }

  @override
  bool contains(Object? element) => _inner.contains(element);

  @override
  E? lookup(Object? element) => _inner.lookup(element);

  @override
  Iterator<E> get iterator => _inner.iterator;

  @override
  Set<E> toSet() => _inner.toSet();

  @override
  int get length => _inner.length;

  @override
  bool get isEmpty => _inner.isEmpty;

  @override
  bool get isNotEmpty => _inner.isNotEmpty;

  @override
  Set<R> cast<R>() => _inner.cast();

  @override
  Iterable<E> followedBy(Iterable<E> other) => _inner.followedBy(other);

  @override
  Iterable<T> whereType<T>() => _inner.whereType();

  @override
  bool containsAll(Iterable<Object?> other) => _inner.containsAll(other);

  @override
  Set<E> union(Set<E> other) => _inner.union(other);

  @override
  Set<E> intersection(Set<Object?> other) => _inner.intersection(other);

  @override
  Set<E> difference(Set<Object?> other) => _inner.difference(other);

  @override
  List<E> toList({bool growable = true}) => _inner.toList(growable: true);

  @override
  Iterable<T> map<T>(T Function(E element) f) => _inner.map(f);

  @override
  E get single => _inner.single;

  @override
  String toString() => _inner.toString();

  @override
  Iterable<E> where(bool Function(E element) f) => _inner.where(f);

  @override
  Iterable<T> expand<T>(Iterable<T> Function(E element) f) => _inner.expand(f);

  @override
  void forEach(void Function(E element) f) => _inner.forEach(f);

  @override
  E reduce(E Function(E value, E element) combine) => _inner.reduce(combine);

  @override
  T fold<T>(T initialValue, T Function(T previousValue, E element) combine) =>
      _inner.fold(initialValue, combine);

  @override
  bool every(bool Function(E element) f) => _inner.every(f);

  @override
  String join([String separator = ""]) => _inner.join(separator);

  @override
  bool any(bool Function(E element) test) => _inner.any(test);

  @override
  Iterable<E> take(int n) => _inner.take(n);

  @override
  Iterable<E> takeWhile(bool Function(E value) test) => _inner.takeWhile(test);

  @override
  Iterable<E> skip(int n) => _inner.skip(n);

  @override
  Iterable<E> skipWhile(bool Function(E value) test) => _inner.skipWhile(test);

  @override
  E get first => _inner.first;

  @override
  E get last => _inner.last;

  @override
  E firstWhere(bool Function(E value) test, {E Function()? orElse}) =>
      _inner.firstWhere(test, orElse: orElse);

  @override
  E lastWhere(bool Function(E value) test, {E Function()? orElse}) =>
      _inner.lastWhere(test, orElse: orElse);

  @override
  E singleWhere(bool Function(E value) test, {E Function()? orElse}) =>
      _inner.singleWhere(test, orElse: orElse);

  @override
  E elementAt(int index) => _inner.elementAt(index);
}
