# City Watch - RailsChallenge v1.0

Basic, minimal implementation of the [RailsChallenge v1.0 "City Watch" app](https://github.com/railschallenge/railschallenge-city-watch) with the provided tests passing. Gemfile unchanged. Shouldn't be any Rubocop warnings.

A couple of obvious areas in which it is lacking:

* Naïve logic for dispatching multiple responders (of one type) to an emergency - it will never dispatch more responder *units* than is necessary, but it is possible for capacity to be wasted.

* No implementation for adding/removing/reshuffling responders if an emergency is updated without being resolved yet (probably should have tested for this :wink:).

* Dispatch stuff should probably be extracted into some sort of service/domain object of its own.
