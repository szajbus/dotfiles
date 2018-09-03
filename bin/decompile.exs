#!/usr/bin/env elixir
defmodule Decompile do
  def main([beam_file]) do
    {:ok,{_,[{:abstract_code,{_,ac}}]}} = :beam_lib.chunks(to_charlist(beam_file),[:abstract_code])
    :io.fwrite("~s~n", [:erl_prettypr.format(:erl_syntax.form_list(ac))])
  end
end

Decompile.main(System.argv)
