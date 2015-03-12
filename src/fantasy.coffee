K = require 'kefir'
{Left, Right} = require 'fantasy-eithers'

# :: Kefir e a -> Kefir _ (Either e a)
#
# Lift errors into values, emitting them as Left and values as Right.
#
attempt = (obs) ->
  obs.map(Right).errorsToValues((e) -> {convert: true, value: Left(e)})

# :: Either e a -> Kefir e a
#
# Convert an Either to a Kefir observable, Left is treated as an error, Right
# as a value.
#
fromEither = (either) ->
  either.fold(K.constantError, K.constant)

# :: Option a -> Kefir _ a
#
# Convert an Option to a Kefir observable.
#
fromOption = (option) ->
  option.fold(K.constant, K.never)

module.exports = {
  attempt,
  fromEither,
  fromOption
}

