import 'dart:collection';

import 'package:counting_set/counting_set.dart';
import 'package:meta/meta.dart';

/// A [CountingSet] implementation that uses another [Set] for storage.
@internal
abstract class DelegatingCountingSet<E> extends CountingSet<E>
    with SetMixin<E> {
  final Set<E> _inner;
  final HashMap<E, int> _counts;

  DelegatingCountingSet(
    Set<E> inner, {
    bool Function(E, E)? equals,
    int Function(E)? hashCode,
  })  : _inner = inner,
        _counts = HashMap(
          equals: equals,
          hashCode: hashCode,
        );

  DelegatingCountingSet.identity(Set<E> inner)
      : _inner = inner,
        _counts = HashMap.identity();

  @override
  Map<E, int> get counts => UnmodifiableMapView(_counts);

  @override
  bool add(E value) {
    _counts[value] = (_counts[value] ?? 0) + 1;
    return _inner.add(value);
  }

  @override
  void addCounts(Map<E, int> counts) {
    _counts.addAll(counts);
    _inner.addAll(counts.keys);
  }

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
