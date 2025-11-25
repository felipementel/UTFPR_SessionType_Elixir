#!/usr/bin/env elixir

# Examples simple where protocols are NOT compatible.

IO.puts("\n" <> String.duplicate("=", 50))
IO.puts("Compatibility Violations")
IO.puts(String.duplicate("=", 50) <> "\n")

# ---------------------------------------------------------------------------
# Case 1: Same order, different types
# ---------------------------------------------------------------------------
IO.puts(String.duplicate("-", 50))
IO.puts("CASE 1: Client sends :int but server expects :string")
IO.puts(String.duplicate("-", 50))

client = SessionType.sender(:int, SessionType.end_session())
server = SessionType.recv(:string, SessionType.end_session())

IO.puts("Client = #{ProtocolChecker.format(client)}")
IO.puts("Server = #{ProtocolChecker.format(server)}")
IO.puts("Compatible? #{ProtocolChecker.compatible?(client, server)}")

# ---------------------------------------------------------------------------
# Case 2: Inverted order
# ---------------------------------------------------------------------------
IO.puts("\n" <> String.duplicate("-", 50))
IO.puts("CASE 2: Client sends then receives, server also wants to send")
IO.puts(String.duplicate("-", 50))

client_sr = SessionType.sender(:ping, SessionType.recv(:pong, SessionType.end_session()))
server_sr = SessionType.sender(:status, SessionType.recv(:ack, SessionType.end_session()))

IO.puts("Client = #{ProtocolChecker.format(client_sr)}")
IO.puts("Server = #{ProtocolChecker.format(server_sr)}")
IO.puts("Compatible? #{ProtocolChecker.compatible?(client_sr, server_sr)}")

# ---------------------------------------------------------------------------
# Case 3: Client ends early
# ---------------------------------------------------------------------------
IO.puts("\n" <> String.duplicate("-", 50))
IO.puts("CASE 3: Client ends before sending the second value")
IO.puts(String.duplicate("-", 50))

client_short = SessionType.sender(:token, SessionType.end_session())
server_waits = SessionType.recv(:token, SessionType.recv(:confirmation, SessionType.end_session()))

IO.puts("Client = #{ProtocolChecker.format(client_short)}")
IO.puts("Server = #{ProtocolChecker.format(server_waits)}")
IO.puts("Compatible? #{ProtocolChecker.compatible?(client_short, server_waits)}")

IO.puts("\n" <> String.duplicate("=", 50))
IO.puts("End of compatibility violation examples")
IO.puts(String.duplicate("=", 50) <> "\n")
