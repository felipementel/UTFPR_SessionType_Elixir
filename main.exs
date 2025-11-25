#!/usr/bin/env elixir

# Minimal demonstration of session types focusing on send/receive.

IO.puts("\n" <> String.duplicate("=", 50))
IO.puts("DEMONSTRAÇÃO: Session Types")
IO.puts(String.duplicate("=", 50) <> "\n")

# ---------------------------------------------------------------------------
# Example 1: Client sends, server receives
# ---------------------------------------------------------------------------
IO.puts(String.duplicate("-", 50))
IO.puts("EXAMPLE 1: !⟨int⟩ followed by ?⟨string⟩")
IO.puts(String.duplicate("-", 50))

client = SessionType.sender(:int, SessionType.recv(:string, SessionType.end_session()))
server = SessionType.dual(client)

IO.puts("Client = #{ProtocolChecker.format(client)}")
IO.puts("Server = #{ProtocolChecker.format(server)}")
IO.puts("Compatible? #{ProtocolChecker.compatible?(client, server)}")

# ---------------------------------------------------------------------------
# Example 2: Server starts receiving
# ---------------------------------------------------------------------------
IO.puts("\n" <> String.duplicate("-", 50))
IO.puts("EXAMPLE 2: ?⟨bool⟩ followed by !⟨ack⟩")
IO.puts(String.duplicate("-", 50))

server_first = SessionType.recv(:bool, SessionType.sender(:ack, SessionType.end_session()))
client_first = SessionType.dual(server_first)

IO.puts("Server = " <> ProtocolChecker.format(server_first))
IO.puts("Client = " <> ProtocolChecker.format(client_first))
IO.puts("Compatible? " <> to_string(ProtocolChecker.compatible?(server_first, client_first)))

IO.puts("\n" <> String.duplicate("=", 50))
IO.puts("Demonstration completed.")
IO.puts(String.duplicate("=", 50) <> "\n")
