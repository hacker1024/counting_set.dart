import 'dart:collection';

import 'package:counting_set/src/base_counting_set.dart';

/// A [HashSet] based [CountingSet].
class CountingHashSet<E> extends DelegatingCountingSet<E> {
  /// Equivalent to [HashSet]'s main constructor.
  CountingHashSet({
    bool Function(E, E)? equals,
    int Function(E)? hashCode,
    bool Function(dynamic)? isValidKey,
  }) : super(
          HashSet(
            equals: equals,
            hashCode: hashCode,
            isValidKey: isValidKey,
          ),
          equals: equals,
          hashCode: hashCode,
        );

  /// Equivalent to [HashSet.identity].
  CountingHashSet.identity() : super(HashSet.identity());

  /// Equivalent to [HashSet.of].
  factory CountingHashSet.of(Iterable<E> elements) =>
      CountingHashSet()..addAll(elements);
}
