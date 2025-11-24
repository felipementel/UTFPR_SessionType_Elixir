defmodule ProtocolChecker do
  @moduledoc """
  Minimal protocol compatibility checker focusing on send/recv interactions.
  """

  @doc """
  Check if two session types are compatible (dual of each other)
  """
  def compatible?(s, t) do
    dual_equal?(s, SessionType.dual(t))
  end

  @doc """
  Check if a session type equals another (structural equality)
  """
  def dual_equal?(%SessionType{type: :end}, %SessionType{type: :end}), do: true

  def dual_equal?(
        %SessionType{type: :send, data: t1, next: n1},
        %SessionType{type: :send, data: t2, next: n2}
      ) do
    t1 == t2 and dual_equal?(n1, n2)
  end

  def dual_equal?(
        %SessionType{type: :recv, data: t1, next: n1},
        %SessionType{type: :recv, data: t2, next: n2}
      ) do
    t1 == t2 and dual_equal?(n1, n2)
  end

  def dual_equal?(nil, nil), do: true
  def dual_equal?(_, _), do: false

  @doc """
  Pretty print a session type for debugging
  """
  def format(%SessionType{type: :send, data: data, next: next}) do
    "!⟨#{inspect(data)}⟩." <> format(next)
  end

  def format(%SessionType{type: :recv, data: data, next: next}) do
    "?⟨#{inspect(data)}⟩." <> format(next)
  end

  def format(%SessionType{type: :end}) do
    "1"
  end

  def format(nil), do: "nil"
end
