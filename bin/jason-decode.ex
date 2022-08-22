#!/usr/bin/env elixir

Mix.install([{:jason, "~> 1.0"}])

IO.read(:stdio, :all)
|> Jason.decode!()
|> IO.inspect(limit: :infinity)
