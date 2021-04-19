import 'dart:collection';

import 'package:counting_set/src/counting_hash_set.dart';
import 'package:counting_set/src/counting_set.dart';
import 'package:counting_set/src/delegating_counting_set.dart';
import 'package:meta/meta.dart';

/// A mixin to add to a [CountingSet] implementation to make it immutable and
/// empty.
mixin _EmptyImmutableCountingSetMixin<E> on CountingSet<E> {
  @override
  bool contains(Object? element) => false;

  @override
  Map<E, int> get counts => const {};

  @override
  Iterator<E> get iterator => <E>{}.iterator;

  @override
  int get length => 0;

  @override
  E? lookup(Object? element) => null;

  @override
  Set<E> toSet() => const {};

  static Never _throw() {
    throw UnsupportedError('Cannot modify an unmodifiable Set');
  }

  /// Throws an [UnsupportedError];
  /// operations that change the set are disallowed.
  @override
  void addCounts(Map<E, int> counts) => _throw();

  /// Throws an [UnsupportedError];
  /// operations that change the set are disallowed.
  @override
  bool add(E value) => _throw();

  /// Throws an [UnsupportedError];
  /// operations that change the set are disallowed.
  @override
  void addAll(Iterable<E> elements) => _throw();

  /// Throws an [UnsupportedError];
  /// operations that change the set are disallowed.
  @override
  bool remove(Object? value) => _throw();

  /// Throws an [UnsupportedError];
  /// operations that change the set are disallowed.
  @override
  void removeAll(Iterable elements) => _throw();

  /// Throws an [UnsupportedError];
  /// operations that change the set are disallowed.
  @override
  void retainAll(Iterable elements) => _throw();

  /// Throws an [UnsupportedError];
  /// operations that change the set are disallowed.
  @override
  void removeWhere(bool Function(E) test) => _throw();

  /// Throws an [UnsupportedError];
  /// operations that change the set are disallowed.
  @override
  void retainWhere(bool Function(E) test) => _throw();

  /// Throws an [UnsupportedError];
  /// operations that change the set are disallowed.
  @override
  void clear() => _throw();
}

/// An empty, immutable, [CountingSet], [DelegatingCountingSet] and
/// [CountingHashSet] implementation.
@internal
class EmptyImmutableCountingSet<E> = CountingSet<E>
    with SetMixin<E>, _EmptyImmutableCountingSetMixin<E>
    implements DelegatingCountingSet<E>, CountingHashSet<E>;
