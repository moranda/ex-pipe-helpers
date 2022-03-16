defmodule PipeHelpers do
  @moduledoc """
  Helper for piping data
  """

  @doc """
  Wrap into ok tuple
  """
  def ok(val) do
    {:ok, val}
  end

  @doc """
  Wrap into noreply tuple (genserver and phoenix socket format)
  """
  def noreply(val) do
    {:noreply, val}
  end

  @doc """
  Wrap into reply tuple (genserver and phoenix socket format)
  """
  def noreply(state, reply) do
    {:reply, reply, state}
  end

  @doc """
  Wrap into tuple pair
  """
  def pair(val, res) do
    {res, val}
  end

  @doc """
  Unwrap from a tuple pair
  """
  def unpair({_val, res}) do
    res
  end

  @doc """
  Wrap into tuple rpair
  """
  def rpair(val, res) do
    {val, res}
  end

  @doc """
  Tap only if ok tuple
  """
  def tap_ok(result, fun) do
    then_ok(result, fun)
    result
  end

  @doc """
  Tap only if value match
  """
  def tap_on(result, value, fun) do
    then_on(result, value, fun)
    value
  end

  @doc """
  Then only if ok tuple
  """
  def then_ok({:ok, ok_val} = _result, fun) do
    fun
    |> Function.info()
    |> Keyword.get(:arity)
    |> case do
      0 -> fun.()
      1 -> fun.(ok_val)
      _ -> raise "then_ok function arity can only be 0 or 1"
    end
  end

  def then_ok(result, _fun), do: result

  @doc """
  Then only if value match
  """
  def then_on(value, value, fun) do
    fun
    |> Function.info()
    |> Keyword.get(:arity)
    |> case do
      0 -> fun.()
      1 -> fun.(value)
      _ -> raise "then_on function arity can only be 0 or 1"
    end
  end

  def then_on(result, _value, _fun), do: result
end
