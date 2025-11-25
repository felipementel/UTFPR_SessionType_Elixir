defmodule SessionType do
  @moduledoc """
  Minimal session type model focusing on output (!), input (?) and end (1).
  """

  # protocol nodes
  defstruct [:type, :data, :next]

  @doc """
  Output session type: S!⟨T⟩.S'
  S actual state of the session type.
  ⟨⟩ angle brackets, dellineating the type being sent.
  ! indicates sending (output).
  ⟨T⟩ indicates the type of value being transmitted.
  . chains the next step in the protocol.
  S' (or “next”) is the rest of the conversation after this transmission.
  """
  def sender(value_type, next \\ end_session()) do
    %__MODULE__{type: :send, data: value_type, next: next}
  end

  @doc """
  Input session type: S?⟨T⟩.S'
  ? indicates receiving (input).
  ⟨T⟩ indicates the type of value being received.
  . chains the next step in the protocol.
  S' (or “next”) is the rest of the conversation after this reception.
  """
  # receive
  def recv(value_type, next \\ end_session()) do
    # return struct
    %__MODULE__{type: :recv, data: value_type, next: next}
  end

  @doc """
  Terminated session: 1
  """
  def end_session() do
    %__MODULE__{type: :end, data: nil, next: nil}
  end

  @doc """
  Compute the dual of a session type
  Dual inverts send/recv directions.
  """
  def dual(%__MODULE__{type: :send, data: value_type, next: next}) when is_atom(value_type) do
    recv(value_type, dual(next))
  end

  def dual(%__MODULE__{type: :recv, data: value_type, next: next}) when is_atom(value_type) do
    sender(value_type, dual(next))
  end

  def dual(%__MODULE__{type: :end}) do
    end_session()
  end

  def dual(nil), do: nil
end
